import React, { useState } from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { useBackpackLayout } from './RightInventory';

const COLLAPSE_KEY = 'ox_inventory:backpackCollapsed';

const readCollapsed = () => {
  try {
    return window.localStorage.getItem(COLLAPSE_KEY) === '1';
  } catch {
    return false;
  }
};

// Pockets, with the worn backpack stacked underneath when it is open (4 + 2 rows, or the backpack
// folded down to its header so the pockets get the whole column)
const LeftInventory: React.FC<{ hideHotkeys?: boolean }> = ({ hideHotkeys }) => {
  const leftInventory = useAppSelector(selectLeftInventory);
  const { backpackInventory, stacked } = useBackpackLayout();
  const [collapsed, setCollapsed] = useState(readCollapsed);

  const toggle = () =>
    setCollapsed((value) => {
      try {
        window.localStorage.setItem(COLLAPSE_KEY, value ? '0' : '1');
      } catch {}
      return !value;
    });

  if (!stacked) return <InventoryGrid inventory={leftInventory} hideHotkeys={hideHotkeys} fill />;

  return (
    <div className="column-stack">
      <section className="inventory-section">
        <InventoryGrid inventory={leftInventory} hideHotkeys={hideHotkeys} fill />
      </section>
      <section className={`inventory-section backpack-section${collapsed ? ' collapsed' : ''}`}>
        <InventoryGrid inventory={backpackInventory} fill collapsed={collapsed} onToggle={toggle} />
      </section>
    </div>
  );
};

export default LeftInventory;
