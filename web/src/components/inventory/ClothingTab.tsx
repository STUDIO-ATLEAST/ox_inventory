// Clothing tab (data/clothing.lua): the character with one square per piece of clothing.
// What sits in a square is what the character wears; drag clothes in to put them on and out to take them off.
import React from 'react';
import {
  Columns2,
  Ear,
  Footprints,
  Gem,
  Glasses,
  Hand,
  HardHat,
  Layers,
  Link,
  LucideIcon,
  Shirt,
  VenetianMask,
  Watch,
} from 'lucide-react';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { Locale } from '../../store/locale';
import { ClothingSlot, Utility } from '../../store/utility';
import { Slot } from '../../typings';
import InventorySlot from './InventorySlot';
import BodySvg from '../utils/BodySvg';
import PanelHeading from './PanelHeading';
import InventoryControl from './InventoryControl';

const ICONS: Record<string, LucideIcon> = {
  hat: HardHat,
  glasses: Glasses,
  ears: Ear,
  mask: VenetianMask,
  chain: Link,
  watch: Watch,
  shirt: Shirt,
  undershirt: Layers,
  gloves: Hand,
  pants: Columns2,
  shoes: Footprints,
  bracelet: Gem,
};

const ClothingTab: React.FC = () => {
  const inventory = useAppSelector(selectLeftInventory);
  const slotOf = (slot: number): Slot => inventory.items[slot - 1] ?? { slot };

  const box = (entry: ClothingSlot) => {
    const Icon = ICONS[entry.key] ?? Shirt;

    return (
      <div key={entry.key} className="utility-box clothing-box">
        <div className="utility-box-label">
          <span>{Locale[`ui_clothing_${entry.key}`] || entry.label}</span>
        </div>
        <InventorySlot
          item={slotOf(entry.slot)}
          inventoryId={inventory.id}
          inventoryType={inventory.type}
          inventoryGroups={inventory.groups}
          className="utility-slot clothing-slot"
          placeholder={<Icon className="utility-slot-icon" strokeWidth={1.5} />}
        />
      </div>
    );
  };

  const left = Utility.clothing.filter((entry) => entry.side !== 'right');
  const right = Utility.clothing.filter((entry) => entry.side === 'right');

  return (
    <div className="character-panel clothing-panel">
      <div className="panel-header">
        <PanelHeading
          icon={Shirt}
          title={Locale.ui_clothing || 'Clothing'}
          subtitle={Locale.ui_outfit || 'Outfit'}
        />
      </div>

      <div className="character-body clothing-body">
        <div className="utility-column">{left.map(box)}</div>

        <div className="character-stage">
          <div className="character-grid" />
          <BodySvg className="character-image" />
        </div>

        <div className="utility-column">{right.map(box)}</div>
      </div>

      <InventoryControl inline />
    </div>
  );
};

export default ClothingTab;
