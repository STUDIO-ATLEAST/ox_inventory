import { CaseReducer, PayloadAction } from '@reduxjs/toolkit';
import { getItemData, itemDurability } from '../helpers';
import { Items } from '../store/items';
import { Inventory, State } from '../typings';

const EMPTY_INVENTORY: Inventory = { id: '', type: '', slots: 0, maxWeight: 0, items: [] };

// Lays the sparse item list out as one entry per slot
const withSlots = (inventory: Inventory, curTime: number): Inventory => ({
  ...inventory,
  items: Array.from(Array(inventory.slots), (_, index) => {
    const item = Object.values(inventory.items).find((item) => item?.slot === index + 1) || {
      slot: index + 1,
    };

    if (!item.name) return item;

    if (typeof Items[item.name] === 'undefined') {
      getItemData(item.name);
    }

    item.durability = itemDurability(item.metadata, curTime);
    return item;
  }),
});

export const setupInventoryReducer: CaseReducer<
  State,
  PayloadAction<{
    leftInventory?: Inventory;
    rightInventory?: Inventory;
    // false closes the worn backpack panel
    backpackInventory?: Inventory | false;
  }>
> = (state, action) => {
  const { leftInventory, rightInventory, backpackInventory } = action.payload;
  const curTime = Math.floor(Date.now() / 1000);

  if (leftInventory) state.leftInventory = withSlots(leftInventory, curTime);

  if (rightInventory) state.rightInventory = withSlots(rightInventory, curTime);

  if (backpackInventory === false) state.backpackInventory = EMPTY_INVENTORY;
  else if (backpackInventory) state.backpackInventory = withSlots(backpackInventory, curTime);

  state.shiftPressed = false;
  state.isBusy = false;
};
