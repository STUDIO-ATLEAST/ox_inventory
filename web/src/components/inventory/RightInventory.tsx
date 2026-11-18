import React from 'react';
import InventoryGrid from './InventoryGrid';
import { useAppSelector } from '../../store';
import { selectBackpackInventory, selectRightInventory } from '../../store/inventory';
import { InventoryType } from '../../typings';

// The worn backpack opens with the world inventory (ground, glovebox, trunk, stash) and sits under the
// pockets in the left column; an opened container takes the right column instead.
export const useBackpackLayout = () => {
  const rightInventory = useAppSelector(selectRightInventory);
  const backpackInventory = useAppSelector(selectBackpackInventory);
  const stacked = !!backpackInventory.id && rightInventory.type !== InventoryType.CONTAINER;

  return { rightInventory, backpackInventory, stacked };
};

const RightInventory: React.FC = () => {
  const rightInventory = useAppSelector(selectRightInventory);

  return <InventoryGrid inventory={rightInventory} fill />;
};

export default RightInventory;
