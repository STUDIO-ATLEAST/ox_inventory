import { Inventory, SlotWithItem } from '../../typings';
import React, { Fragment, useMemo } from 'react';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { useAppSelector } from '../../store';
import { Clock } from 'lucide-react';
import { getItemUrl } from '../../helpers';
import Markdown from '../utils/Markdown';
import { getRarity } from '../../store/rarity';
import { Grid, itemSize } from '../../store/grid';
import { formatWeight } from './InventorySlot';

const t = (key: string, fallback: string) => Locale[key] || fallback;

// small line under the name when the item has no metadata.type
const kindOf = (name: string) => {
  if (/^weapon_/i.test(name)) return t('ui_weapon', 'Weapon');
  if (/^ammo/i.test(name)) return t('ui_ammunition', 'Ammunition');
  if (/^at_|component/i.test(name)) return t('ui_attachment', 'Attachment');
  return t('ui_item', 'Item');
};

// label on the left, value on the right, one row per stat
const Stat: React.FC<{ label: string; children: React.ReactNode }> = ({ label, children }) => (
  <div className="tooltip-stat">
    <span className="tooltip-stat-label">{label}</span>
    <span className="tooltip-stat-value">{children}</span>
  </div>
);

const SlotTooltip: React.ForwardRefRenderFunction<
  HTMLDivElement,
  { item: SlotWithItem; inventoryType: Inventory['type']; style: React.CSSProperties }
> = ({ item, inventoryType, style }, ref) => {
  const additionalMetadata = useAppSelector((state) => state.inventory.additionalMetadata);
  const itemData = useMemo(() => Items[item.name], [item]);
  const ingredients = useMemo(() => {
    if (!item.ingredients) return null;
    return Object.entries(item.ingredients).sort((a, b) => a[1] - b[1]);
  }, [item]);
  const description = item.metadata?.description || itemData?.description;
  const ammoName = itemData?.ammoName && Items[itemData?.ammoName]?.label;
  const crafting = inventoryType === 'crafting';
  // optional features: rarity badge (data/rarity.lua) and the grid size in cells (data/grid.lua)
  const rarity = getRarity(item);
  const size = Grid.enabled && !crafting ? itemSize(item.name) : null;
  const label = item.metadata?.label || itemData?.label || item.name;
  const durability = item.durability !== undefined ? Math.max(0, Math.min(100, Math.trunc(item.durability))) : null;
  const components: string[] = Array.isArray(item.metadata?.components) ? item.metadata!.components : [];
  const extras = additionalMetadata.filter((data) => item.metadata && item.metadata[data.metadata]);

  const hasStats =
    !crafting &&
    (durability !== null ||
      item.metadata?.ammo !== undefined ||
      !!ammoName ||
      !!item.metadata?.serial ||
      components.length > 0 ||
      !!item.metadata?.weapontint ||
      extras.length > 0 ||
      item.weight > 0 ||
      item.count > 1);

  return (
    <div style={{ ...style, ...rarity?.vars }} className={`tooltip-wrapper${rarity ? ' rarity' : ''}`} ref={ref}>
      <div className="tooltip-head">
        <div className={`tooltip-icon${rarity?.tinted ? ' rarity' : ''}`}>
          <div style={{ backgroundImage: `url(${getItemUrl(item)})` }} />
        </div>
        <div className="tooltip-head-text">
          <p className={`tooltip-title${rarity?.tinted ? ' tinted' : ''}`}>{label}</p>
          {crafting ? (
            <p className="tooltip-subtitle">
              <Clock />
              {(item.duration !== undefined ? item.duration : 3000) / 1000}s
            </p>
          ) : (
            <p className="tooltip-subtitle">{item.metadata?.type || kindOf(item.name)}</p>
          )}
        </div>
      </div>

      {(rarity || size) && (
        <div className="tooltip-tags">
          {rarity && <span className="tooltip-rarity">{rarity.tier.label}</span>}
          {size && (
            <span className="tooltip-size">
              {size[0]} x {size[1]}
            </span>
          )}
        </div>
      )}

      {description && (
        <div className="tooltip-section tooltip-description">
          <Markdown content={description} className="tooltip-markdown" />
        </div>
      )}

      {hasStats && (
        <div className="tooltip-section tooltip-stats">
          {item.count > 1 && <Stat label={t('ui_amount', 'Amount')}>{item.count.toLocaleString('en-us')}</Stat>}
          {item.weight > 0 && <Stat label={t('ui_weight', 'Weight')}>{formatWeight(item.weight)}</Stat>}
          {durability !== null && (
            <div className="tooltip-stat durability">
              <div className="tooltip-stat-row">
                <span className="tooltip-stat-label">{t('ui_durability', 'Durability')}</span>
                <span className="tooltip-stat-value">{durability}%</span>
              </div>
              <div className="tooltip-bar">
                <div
                  className={durability < 25 ? 'low' : durability < 50 ? 'mid' : undefined}
                  style={{ width: `${durability}%` }}
                />
              </div>
            </div>
          )}
          {item.metadata?.ammo !== undefined && <Stat label={t('ui_ammo', 'Ammo')}>{item.metadata.ammo}</Stat>}
          {ammoName && <Stat label={t('ammo_type', 'Ammo type')}>{ammoName}</Stat>}
          {item.metadata?.serial && <Stat label={t('ui_serial', 'Serial')}>{item.metadata.serial}</Stat>}
          {item.metadata?.weapontint && <Stat label={t('ui_tint', 'Tint')}>{item.metadata.weapontint}</Stat>}
          {components.length > 0 && (
            <Stat label={t('ui_components', 'Components')}>
              {components.map((component) => Items[component]?.label || component).join(', ')}
            </Stat>
          )}
          {extras.map((data, index) => (
            <Fragment key={`metadata-${index}`}>
              <Stat label={data.value}>{item.metadata![data.metadata]}</Stat>
            </Fragment>
          ))}
        </div>
      )}

      {crafting && ingredients && (
        <div className="tooltip-section tooltip-ingredients">
          {ingredients.map(([name, count]) => (
            <div className="tooltip-ingredient" key={`ingredient-${name}`}>
              <div className="tooltip-ingredient-icon" style={{ backgroundImage: `url(${getItemUrl(name)})` }} />
              <p>{Items[name]?.label || name}</p>
              <span>{count >= 1 ? `${count}x` : count === 0 ? '' : `${count * 100}%`}</span>
            </div>
          ))}
        </div>
      )}
    </div>
  );
};

export default React.forwardRef(SlotTooltip);
