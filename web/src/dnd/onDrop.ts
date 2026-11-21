import { canStack, findAvailableSlot, getTargetInventory, isSlotWithItem } from '../helpers';
import { validateMove } from '../thunks/validateItems';
import { store } from '../store';
import { DragSource, DropTarget, InventoryType, SlotWithItem } from '../typings';
import { moveSlots, stackSlots, swapSlots } from '../store/inventory';
import { Items } from '../store/items';
import { canPlace, canSwap, findSpot, gridLayout, isCellOf, usesGrid } from '../store/grid';

export const onDrop = (source: DragSource, target?: DropTarget) => {
  const { inventory: state } = store.getState();

  const { sourceInventory, targetInventory } = getTargetInventory(state, source.inventory, target?.inventory);

  const sourceSlot = sourceInventory.items[source.item.slot - 1] as SlotWithItem;
  const isOpenContainer = (id: string) => state.rightInventory.id === id || state.backpackInventory.id === id;

  const sourceData = Items[sourceSlot.name];

  if (sourceData === undefined) return console.error(`${sourceSlot.name} item data undefined!`);

  // If dragging from container slot
  if (sourceSlot.metadata?.container !== undefined) {
    // Prevent storing container in container
    if (targetInventory.type === InventoryType.CONTAINER)
      return console.log(`Cannot store container ${sourceSlot.name} inside another container`);

    // Prevent dragging of container slot when opened
    if (isOpenContainer(sourceSlot.metadata.container))
      return console.log(`Cannot move container ${sourceSlot.name} when opened`);
  }

  // grid inventory: rotation the item gets where it lands (quick moves pick whatever fits)
  let rotate = target?.rotate;

  let targetSlot = target ? targetInventory.items[target.item.slot - 1] : undefined;

  if (!target) {
    const available = findAvailableSlot(sourceSlot, sourceData, targetInventory.items, targetInventory.type);

    if (available && !isSlotWithItem(available) && usesGrid(targetInventory.type)) {
      // a free grid cell is not enough, the whole item has to fit; a free hotbar slot takes any size
      const spot = findSpot(targetInventory, sourceSlot.name);
      const layout = gridLayout(targetInventory);

      if (spot) {
        targetSlot = targetInventory.items[spot.slot - 1];
        rotate = spot.rotated;
      } else if (layout && !isCellOf(layout, available.slot)) targetSlot = available;
    } else targetSlot = available;
  }

  if (targetSlot === undefined) return console.error('Target slot undefined!');

  // If dropping on container slot when opened
  if (targetSlot.metadata?.container !== undefined && isOpenContainer(targetSlot.metadata.container))
    return console.log(`Cannot swap item ${sourceSlot.name} with container ${targetSlot.name} when opened`);

  const count =
    state.shiftPressed && sourceSlot.count > 1 && sourceInventory.type !== 'shop'
      ? Math.floor(sourceSlot.count / 2)
      : state.itemAmount === 0 || state.itemAmount > sourceSlot.count
        ? sourceSlot.count
        : state.itemAmount;

  const sameInventory = sourceInventory === targetInventory;
  const stacking = isSlotWithItem(targetSlot, true) && sourceData.stack && canStack(sourceSlot, targetSlot);

  // grid inventory: refuse moves the server would refuse, before anything changes on screen
  if (usesGrid(targetInventory.type) || usesGrid(sourceInventory.type)) {
    const landing = rotate ?? sourceSlot.rotated ?? false;

    if (isSlotWithItem(targetSlot, true)) {
      if (!stacking && !canSwap(sourceInventory, sourceSlot, targetInventory, targetSlot, landing)) return;
    } else {
      const ignore = sameInventory && count >= sourceSlot.count ? [sourceSlot.slot] : undefined;
      if (!canPlace(targetInventory, targetSlot.slot, sourceSlot.name, landing, ignore)) return;
    }

    rotate = landing;
  }

  const data = {
    fromSlot: sourceSlot,
    toSlot: targetSlot,
    fromType: sourceInventory.type,
    toType: targetInventory.type,
    count: count,
    rotate,
  };

  store.dispatch(
    validateMove({
      ...data,
      fromSlot: sourceSlot.slot,
      toSlot: targetSlot.slot,
    })
  );

  isSlotWithItem(targetSlot, true)
    ? stacking
      ? store.dispatch(
          stackSlots({
            ...data,
            toSlot: targetSlot,
          })
        )
      : store.dispatch(
          swapSlots({
            ...data,
            toSlot: targetSlot,
          })
        )
    : store.dispatch(moveSlots(data));
};

// grid inventory: turn an item where it lies (R over an item)
export const onRotate = (inventoryType: string, slot: number) => {
  const { inventory: state } = store.getState();
  const { sourceInventory: inventory } = getTargetInventory(state, inventoryType, inventoryType);
  const item = inventory.items[slot - 1];

  if (!isSlotWithItem(item) || !usesGrid(inventory.type)) return;

  const rotate = !item.rotated;

  if (!canPlace(inventory, slot, item.name, rotate, [slot])) return;

  store.dispatch(
    validateMove({ fromSlot: slot, toSlot: slot, fromType: inventory.type, toType: inventory.type, count: item.count, rotate })
  );
  store.dispatch(
    moveSlots({ fromSlot: item, toSlot: item, fromType: inventory.type, toType: inventory.type, count: item.count, rotate })
  );
};
