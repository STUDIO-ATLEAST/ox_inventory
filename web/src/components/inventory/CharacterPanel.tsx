import React from 'react';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { Locale } from '../../store/locale';
import { Utility } from '../../store/utility';
import { Inventory, Slot } from '../../typings';
import InventorySlot from './InventorySlot';
import UtilityIcon from '../utils/icons/UtilityIcons';
import BodySvg from '../utils/BodySvg';
import { PersonStanding } from 'lucide-react';
import PanelHeading from './PanelHeading';
import InventoryControl from './InventoryControl';

// Equipment boxes beside the character: the first half go left, the rest right
const HOTBAR_SLOTS = [1, 2, 3, 4, 5];

interface UtilityBoxProps {
  label: string;
  kind: string;
  item: Slot;
  inventory: Inventory;
  badge?: number;
}

export const UtilityBox: React.FC<UtilityBoxProps> = ({ label, kind, item, inventory, badge }) => (
  <div className={`utility-box utility-box-${kind}`}>
    <div className="utility-box-label">
      {badge !== undefined && <span className="utility-box-badge">{badge}</span>}
      <span>{label}</span>
    </div>
    <InventorySlot
      item={item}
      inventoryId={inventory.id}
      inventoryType={inventory.type}
      inventoryGroups={inventory.groups}
      className="utility-slot"
      placeholder={<UtilityIcon kind={kind} className="utility-slot-icon" />}
    />
  </div>
);

const CharacterPanel: React.FC = () => {
  const inventory = useAppSelector(selectLeftInventory);

  const slotOf = (slot: number): Slot => inventory.items[slot - 1] ?? { slot };

  const equipment = Utility.equipment.map((entry) => (
    <UtilityBox
      key={entry.kind}
      label={Locale[`ui_${entry.kind}`] || entry.label}
      kind={entry.kind}
      item={slotOf(entry.slot)}
      inventory={inventory}
    />
  ));
  const half = Math.ceil(equipment.length / 2);

  return (
    <div className="character-panel">
      <div className="panel-header">
        <PanelHeading
          icon={PersonStanding}
          title={inventory.label || Locale.ui_character || 'Character'}
          subtitle={Locale.ui_equipment || 'Equipment'}
        />
      </div>

      <div className="character-body">
        <div className="utility-column">{equipment.slice(0, half)}</div>

        <div className="character-stage">
          <div className="character-grid" />
          <BodySvg className="character-image" />
        </div>

        <div className="utility-column">{equipment.slice(half)}</div>
      </div>

      <div className="utility-hotbar">
        {/* the keybind number sits inside the empty slot and hides once an item is in it */}
        {HOTBAR_SLOTS.map((slot) => (
          <InventorySlot
            key={`hotbar-${slot}`}
            item={slotOf(slot)}
            inventoryId={inventory.id}
            inventoryType={inventory.type}
            inventoryGroups={inventory.groups}
            className="utility-slot hotbar-slot"
            placeholder={
              <span className={`hotbar-key${Utility.weaponSlots.includes(slot) ? ' weapon' : ''}`}>{slot}</span>
            }
          />
        ))}
      </div>

      <InventoryControl inline />
    </div>
  );
};

export default CharacterPanel;
