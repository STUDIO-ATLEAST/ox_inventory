import { CaseReducer, PayloadAction } from '@reduxjs/toolkit';
import { getTargetInventory, itemDurability } from '../helpers';
import { Inventory, SlotWithItem, State } from '../typings';

export const swapSlotsReducer: CaseReducer<
  State,
  PayloadAction<{
    fromSlot: SlotWithItem;
    fromType: Inventory['type'];
    toSlot: SlotWithItem;
    toType: Inventory['type'];
    // grid inventory: rotation the dragged item gets at the target (undefined keeps its own)
    rotate?: boolean;
  }>
> = (state, action) => {
  const { fromSlot, fromType, toSlot, toType, rotate } = action.payload;
  const { sourceInventory, targetInventory } = getTargetInventory(state, fromType, toType);
  const curTime = Math.floor(Date.now() / 1000);
  const fromItem = sourceInventory.items[fromSlot.slot - 1];

  [sourceInventory.items[fromSlot.slot - 1], targetInventory.items[toSlot.slot - 1]] = [
    {
      ...targetInventory.items[toSlot.slot - 1],
      slot: fromSlot.slot,
      durability: itemDurability(toSlot.metadata, curTime),
    },
    {
      ...fromItem,
      slot: toSlot.slot,
      durability: itemDurability(fromSlot.metadata, curTime),
      rotated: (rotate ?? fromItem.rotated) || undefined,
    },
  ];
};
