import React, { useEffect, useMemo, useRef, useState } from 'react';
import { Inventory } from '../../typings';
import WeightBar from '../utils/WeightBar';
import InventorySlot from './InventorySlot';
import { getTotalWeight } from '../../helpers';
import { useAppSelector } from '../../store';
import { useIntersection } from '../../hooks/useIntersection';
import { Locale } from '../../store/locale';
import { getClothingSlot, getEquipmentSlot, Utility } from '../../store/utility';
import UtilityIcon from '../utils/icons/UtilityIcons';
import { ChevronDown, Weight } from 'lucide-react';
import PanelHeading, { iconForType } from './PanelHeading';
import GridInventory from './GridInventory';
import { gridLayout, isPlayerType } from '../../store/grid';

const PAGE_SIZE = 30;

const TYPE_LABELS: Record<string, [string, string]> = {
  player: ['ui_pockets', 'Pockets'],
  otherplayer: ['ui_otherplayer', 'Player'],
  drop: ['ui_ground', 'Ground'],
  newdrop: ['ui_ground', 'Ground'],
  stash: ['ui_stash', 'Stash'],
  trunk: ['ui_trunk', 'Trunk'],
  glovebox: ['ui_glovebox', 'Glovebox'],
  container: ['ui_container', 'Container'],
  shop: ['ui_shop', 'Shop'],
  crafting: ['ui_crafting', 'Crafting'],
};

const typeLabel = (type: string) => {
  const entry = TYPE_LABELS[type];
  return entry ? Locale[entry[0]] || entry[1] : type;
};

// fill: stretch to the parent's height instead of the fixed row count
// onToggle: shows a collapse chevron in the header (worn backpack)
const InventoryGrid: React.FC<{
  inventory: Inventory;
  hideHotkeys?: boolean;
  fill?: boolean;
  collapsed?: boolean;
  onToggle?: () => void;
}> = ({ inventory, hideHotkeys, fill, collapsed, onToggle }) => {
  const weight = useMemo(
    () => (inventory.maxWeight !== undefined ? Math.floor(getTotalWeight(inventory.items) * 1000) / 1000 : 0),
    [inventory.maxWeight, inventory.items]
  );
  const [page, setPage] = useState(0);
  const containerRef = useRef(null);
  const { ref, entry } = useIntersection({ threshold: 0.5 });
  const isBusy = useAppSelector((state) => state.inventory.isBusy);
  const isPlayer = inventory.type === 'player';
  const isPlayerLike = isPlayerType(inventory.type);
  // grid inventory (data/grid.lua): cells instead of slots
  const layout = useMemo(() => gridLayout(inventory), [inventory.type, inventory.slots]);
  // hotkey and equipment slots live on the utility panel while it is shown
  const items = useMemo(
    () =>
      hideHotkeys && isPlayer
        ? inventory.items.filter((item) => item.slot > 5 && !getEquipmentSlot(item.slot) && !getClothingSlot(item.slot))
        : inventory.items,
    [hideHotkeys, isPlayer, inventory.items]
  );

  const placeholderFor = (slot: number) => {
    if (!isPlayer) return undefined;
    const kind = getEquipmentSlot(slot)?.kind ?? (Utility.weaponSlots.includes(slot) ? 'weapon' : undefined);
    return kind && <UtilityIcon kind={kind} className="utility-slot-icon" />;
  };

  useEffect(() => {
    if (entry && entry.isIntersecting) {
      setPage((prev) => ++prev);
    }
  }, [entry]);
  return (
    <>
      <div className={`inventory-grid-wrapper${fill ? ' fill' : ''}`} style={{ pointerEvents: isBusy ? 'none' : 'auto' }}>
        <div className="panel-header">
          <PanelHeading
            icon={iconForType(inventory.type)}
            title={inventory.label || typeLabel(inventory.type)}
            subtitle={inventory.label !== typeLabel(inventory.type) && typeLabel(inventory.type)}
            aside={
              <>
                {inventory.maxWeight ? (
                  <p className="inventory-weight">
                    <Weight />
                    <span className="inventory-weight-value">{Math.round(weight / 100) / 10}</span>
                    <span className="inventory-weight-max">/ {inventory.maxWeight / 1000}kg</span>
                  </p>
                ) : null}
                {onToggle && (
                  <button
                    className={`panel-collapse${collapsed ? ' collapsed' : ''}`}
                    onClick={onToggle}
                    title={collapsed ? 'Expand' : 'Collapse'}
                  >
                    <ChevronDown />
                  </button>
                )}
              </>
            }
          />
          <WeightBar percent={inventory.maxWeight ? (weight / inventory.maxWeight) * 100 : 0} />
        </div>
        {layout ? (
          <GridInventory inventory={inventory} layout={layout} showHotbar={isPlayerLike && !hideHotkeys} />
        ) : (
          <div className="inventory-grid-container" ref={containerRef}>
            <>
              {items.slice(0, (page + 1) * PAGE_SIZE).map((item, index) => (
                <InventorySlot
                  key={`${inventory.type}-${inventory.id}-${item.slot}`}
                  item={item}
                  ref={index === (page + 1) * PAGE_SIZE - 1 ? ref : null}
                  inventoryType={inventory.type}
                  inventoryGroups={inventory.groups}
                  inventoryId={inventory.id}
                  placeholder={placeholderFor(item.slot)}
                />
              ))}
            </>
          </div>
        )}
      </div>
    </>
  );
};

export default InventoryGrid;
