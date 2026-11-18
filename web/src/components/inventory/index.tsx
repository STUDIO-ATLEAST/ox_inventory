import React, { useEffect, useState } from 'react';
import useNuiEvent from '../../hooks/useNuiEvent';
import InventoryControl from './InventoryControl';
import InventoryHotbar from './InventoryHotbar';
import { useAppDispatch } from '../../store';
import { refreshSlots, setAdditionalMetadata, setupInventory } from '../../store/inventory';
import { useExitListener } from '../../hooks/useExitListener';
import type { Inventory as InventoryProps } from '../../typings';
import RightInventory, { useBackpackLayout } from './RightInventory';
import LeftInventory from './LeftInventory';
import Tooltip from '../utils/Tooltip';
import { closeTooltip } from '../../store/tooltip';
import InventoryContext from './InventoryContext';
import { closeContextMenu } from '../../store/contextMenu';
import Fade from '../utils/transitions/Fade';
import { Hammer, HeartPulse, LayoutGrid, LucideIcon } from 'lucide-react';
import CharacterPanel from './CharacterPanel';
import CraftingTab from './CraftingTab';
import HealthTab from './HealthTab';
import ShopView from './ShopView';
import CraftingStation from './CraftingStation';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';
import { Locale } from '../../store/locale';
import { isUtilityMode } from '../../store/utility';
import { isEnvBrowser } from '../../utils/misc';

type Tab = 'inventory' | 'crafting' | 'health';

const TABS: { id: Tab; icon: LucideIcon; locale: string; label: string }[] = [
  { id: 'inventory', icon: LayoutGrid, locale: 'ui_inventory', label: 'Inventory' },
  { id: 'crafting', icon: Hammer, locale: 'ui_crafting', label: 'Crafting' },
  { id: 'health', icon: HeartPulse, locale: 'ui_health', label: 'Health' },
];

const Inventory: React.FC = () => {
  const [inventoryVisible, setInventoryVisible] = useState(false);
  // browser preview can start on a tab with ?tab=crafting / ?tab=health
  const [tab, setTab] = useState<Tab>(() => {
    const wanted = isEnvBrowser() ? new URLSearchParams(window.location.search).get('tab') : null;
    return TABS.some((entry) => entry.id === wanted) ? (wanted as Tab) : 'inventory';
  });
  const { stacked } = useBackpackLayout();
  // shops and crafting benches get their own view across the centre and right columns
  const rightType = useAppSelector(selectRightInventory).type;
  const wide = rightType === 'shop' ? 'shop' : rightType === 'crafting' ? 'crafting' : null;
  const utility = isUtilityMode();
  const dispatch = useAppDispatch();

  useNuiEvent<boolean>('setInventoryVisible', setInventoryVisible);
  useNuiEvent<false>('closeInventory', () => {
    setInventoryVisible(false);
    dispatch(closeContextMenu());
    dispatch(closeTooltip());
  });
  useExitListener(setInventoryVisible);

  useNuiEvent<{
    leftInventory?: InventoryProps;
    rightInventory?: InventoryProps;
    backpackInventory?: InventoryProps | false;
  }>('setupInventory', (data) => {
    dispatch(setupInventory(data));
    // opening a trunk, stash, shop etc. jumps to the inventory view; plain TAB keeps the last picked tab
    if (data.rightInventory && data.rightInventory.type !== 'newdrop' && !(isEnvBrowser() && window.location.search.includes('tab=')))
      setTab('inventory');
    !inventoryVisible && setInventoryVisible(true);
  });

  useNuiEvent('refreshSlots', (data) => dispatch(refreshSlots(data)));

  useNuiEvent('displayMetadata', (data: Array<{ metadata: string; value: string }>) => {
    dispatch(setAdditionalMetadata(data));
  });

  // Q / E step through the tabs, like the keycaps beside them show
  useEffect(() => {
    if (!inventoryVisible || !utility || wide) return;

    const onKey = (event: KeyboardEvent) => {
      const target = event.target as HTMLElement | null;
      if (target && (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA')) return;
      const key = event.key.toLowerCase();
      if (key !== 'q' && key !== 'e') return;

      setTab((current) => {
        const index = TABS.findIndex((entry) => entry.id === current);
        const next = (index + (key === 'e' ? 1 : TABS.length - 1)) % TABS.length;
        return TABS[next].id;
      });
    };

    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [inventoryVisible, utility, wide]);

  const stackClass = stacked ? ' stacked' : '';

  return (
    <>
      <Fade in={inventoryVisible}>
        <div className={`inventory-wrapper${utility ? ' layout-utility' : ''}`}>
          {utility && (
            <header className="inventory-topbar">
              <nav className="inventory-tabs" style={wide ? { visibility: 'hidden' } : undefined}>
                <span className="tab-key">Q</span>
                {TABS.map(({ id, icon: Icon, locale, label }) => (
                  <button
                    key={id}
                    className={`inventory-tab${tab === id ? ' active' : ''}`}
                    onClick={() => setTab(id)}
                  >
                    <Icon />
                    {Locale[locale] || label}
                  </button>
                ))}
                <span className="tab-key">E</span>
              </nav>
            </header>
          )}
          <div className="inventory-stage">
            <div className="inventory-row">
              <div className={`inventory-panel panel-left${stackClass}`}>
                <LeftInventory hideHotkeys={utility} />
              </div>
              {wide ? (
                <div className="inventory-panel panel-wide">{wide === 'shop' ? <ShopView /> : <CraftingStation />}</div>
              ) : !utility ? (
                <>
                  <InventoryControl />
                  <div className="inventory-panel panel-right">
                    <RightInventory />
                  </div>
                </>
              ) : (
                // both inventories stay put, only the centre column swaps with the tab
                <>
                  <div className="inventory-panel panel-center">
                    {tab === 'inventory' ? <CharacterPanel /> : tab === 'crafting' ? <CraftingTab /> : <HealthTab />}
                  </div>
                  <div className="inventory-panel panel-right">
                    <RightInventory />
                  </div>
                </>
              )}
            </div>
          </div>
          <Tooltip />
          <InventoryContext />
        </div>
      </Fade>
      <InventoryHotbar />
    </>
  );
};

export default Inventory;
