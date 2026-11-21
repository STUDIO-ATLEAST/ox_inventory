// Tarkov-style grid body (data/grid.lua): items cover width x height cells and can sit anywhere they fit.
// The whole cell area is one drop target; it works out where the dragged item would land from the
// pointer, the grabbed cell and the rotation (R while dragging).
import React, { useCallback, useEffect, useMemo, useRef, useState } from 'react';
import { useDrag, useDragDropManager, useDrop, XYCoord } from 'react-dnd';
import { DragSource, Inventory, InventoryType, Slot, SlotWithItem } from '../../typings';
import { store, useAppDispatch } from '../../store';
import { canStack, getItemUrl, getTargetInventory, isSlotWithItem } from '../../helpers';
import { Items } from '../../store/items';
import { canSwap, cellAt, cellCoords, fits, footprint, GridLayout, occupancy } from '../../store/grid';
import { getGridDrag, setHoveredGridItem, startGridDrag, useGridDrag } from '../../store/gridDrag';
import { getRarity } from '../../store/rarity';
import { onDrop } from '../../dnd/onDrop';
import { onBuy } from '../../dnd/onBuy';
import { onCraft } from '../../dnd/onCraft';
import { onUse } from '../../dnd/onUse';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { openContextMenu } from '../../store/contextMenu';
import WeightBar from '../utils/WeightBar';
import InventorySlot, { formatWeight } from './InventorySlot';

type Placement = {
  kind: 'move' | 'stack' | 'swap';
  slot: number;
  valid: boolean;
  x: number;
  y: number;
  w: number;
  h: number;
};

const position = (x: number, y: number, w: number, h: number) =>
  ({ '--x': x, '--y': y, '--w': w, '--h': h }) as React.CSSProperties;

const GridItem: React.FC<{ item: SlotWithItem; inventory: Inventory; layout: GridLayout }> = ({
  item,
  inventory,
  layout,
}) => {
  const dispatch = useAppDispatch();
  const timerRef = useRef<number | null>(null);
  const [w, h] = footprint(item.name, item.rotated);
  const [iw, ih] = footprint(item.name, false);
  const { x, y } = cellCoords(layout, item.slot);
  const rarity = getRarity(item);

  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({ isDragging: monitor.isDragging() }),
      item: () => ({
        inventory: inventory.type,
        item: { name: item.name, slot: item.slot },
        image: `url(${getItemUrl(item) || 'none'}`,
      }),
    }),
    [inventory.type, item]
  );

  // remember which cell was grabbed, so the item lands under the cursor the same way
  const onPointerDown = (event: React.MouseEvent<HTMLDivElement>) => {
    const rect = event.currentTarget.getBoundingClientRect();
    const grabX = Math.min(w - 1, Math.max(0, Math.floor(((event.clientX - rect.left) / rect.width) * w)));
    const grabY = Math.min(h - 1, Math.max(0, Math.floor(((event.clientY - rect.top) / rect.height) * h)));
    startGridDrag(!!item.rotated, grabX, grabY);
  };

  const onContext = (event: React.MouseEvent<HTMLDivElement>) => {
    event.preventDefault();
    if (inventory.type !== InventoryType.PLAYER) return;
    dispatch(openContextMenu({ item, coords: { x: event.clientX, y: event.clientY } }));
  };

  const onClick = (event: React.MouseEvent<HTMLDivElement>) => {
    dispatch(closeTooltip());
    if (timerRef.current) clearTimeout(timerRef.current);
    if (event.ctrlKey) onDrop({ item, inventory: inventory.type });
    else if (event.altKey && inventory.type === InventoryType.PLAYER) onUse(item);
  };

  const clearTimer = () => {
    if (timerRef.current) clearTimeout(timerRef.current);
    timerRef.current = null;
  };

  useEffect(() => clearTimer, []);

  const label = item.metadata?.label || Items[item.name]?.label || item.name;
  // turned items show their picture turned too, at the size of the unturned footprint
  const imageStyle: React.CSSProperties = item.rotated
    ? {
        backgroundImage: `url(${getItemUrl(item)})`,
        width: `calc(${iw} * var(--grid-pitch) - var(--grid-gap) - 0.8vh)`,
        height: `calc(${ih} * var(--grid-pitch) - var(--grid-gap) - 0.8vh)`,
        transform: 'translate(-50%, -50%) rotate(90deg)',
      }
    : { backgroundImage: `url(${getItemUrl(item)})` };

  return (
    <div
      ref={(element) => {
        drag(element);
      }}
      className={`grid-item${rarity?.tinted ? ' rarity' : ''}${w === 1 ? ' narrow' : ''}`}
      style={{ ...position(x, y, w, h), ...rarity?.vars, opacity: isDragging ? 0.4 : 1 }}
      onMouseDown={onPointerDown}
      onContextMenu={onContext}
      onClick={onClick}
      onMouseEnter={() => {
        setHoveredGridItem({ inventoryType: inventory.type, slot: item.slot });
        timerRef.current = window.setTimeout(() => {
          dispatch(openTooltip({ item, inventoryType: inventory.type }));
        }, 500) as unknown as number;
      }}
      onMouseLeave={() => {
        setHoveredGridItem(null);
        dispatch(closeTooltip());
        clearTimer();
      }}
    >
      <div className={`grid-item-image${item.rotated ? ' rotated' : ''}`} style={imageStyle} />
      <div className="grid-item-header">
        {item.count > 1 ? <p className="item-slot-count">{item.count.toLocaleString('en-us')}x</p> : <span />}
        {w > 1 && h > 1 && <p className="item-slot-weight">{formatWeight(item.weight)}</p>}
      </div>
      <div className="grid-item-footer">
        <div className="inventory-slot-label-text">{label}</div>
        {item.durability !== undefined && <WeightBar percent={item.durability} durability />}
      </div>
    </div>
  );
};

const GridInventory: React.FC<{ inventory: Inventory; layout: GridLayout; showHotbar?: boolean }> = ({
  inventory,
  layout,
  showHotbar,
}) => {
  const cellsRef = useRef<HTMLDivElement | null>(null);
  const manager = useDragDropManager();
  const gridDrag = useGridDrag();
  const [placement, setPlacement] = useState<Placement | null>(null);

  const items = useMemo(
    () =>
      inventory.items.filter(
        (item): item is SlotWithItem => isSlotWithItem(item) && item.slot >= layout.first && item.slot <= layout.last
      ),
    [inventory.items, layout.first, layout.last]
  );

  const hotbar = useMemo(
    () => (showHotbar ? inventory.items.filter((item) => item.slot <= layout.first - 1) : []),
    [showHotbar, inventory.items, layout.first]
  );

  // where the dragged item would land for the pointer position
  const resolve = useCallback(
    (source: DragSource | null, offset: XYCoord | null): Placement | null => {
      const element = cellsRef.current;
      if (!source || !offset || !element) return null;

      const rect = element.getBoundingClientRect();
      const px = Math.floor(((offset.x - rect.left) / rect.width) * layout.cols);
      const py = Math.floor(((offset.y - rect.top) / rect.height) * layout.rows);

      if (px < 0 || py < 0 || px >= layout.cols || py >= layout.rows) return null;

      const state = store.getState().inventory;
      const { sourceInventory, targetInventory } = getTargetInventory(state, source.inventory, inventory.type);
      const sourceItem = sourceInventory.items[source.item.slot - 1] as Slot;

      if (!isSlotWithItem(sourceItem)) return null;

      const { rotated, grabX, grabY } = getGridDrag();
      const [w, h] = footprint(sourceItem.name, rotated);
      const same = sourceInventory === targetInventory;
      const fromShop = source.inventory === InventoryType.SHOP || source.inventory === InventoryType.CRAFTING;
      const whole =
        !fromShop &&
        !(state.shiftPressed && sourceItem.count > 1) &&
        (state.itemAmount === 0 || state.itemAmount >= sourceItem.count);

      const occupied = occupancy(targetInventory.items, layout);
      const hitSlot = occupied.get(cellAt(layout, px, py));
      const hit = hitSlot !== undefined && !(same && hitSlot === sourceItem.slot) ? targetInventory.items[hitSlot - 1] : null;

      // dropping onto a matching stack adds to it
      if (hit && isSlotWithItem(hit) && Items[sourceItem.name]?.stack && canStack(sourceItem, hit)) {
        const at = cellCoords(layout, hit.slot);
        const [hw, hh] = footprint(hit.name, hit.rotated);
        return { kind: 'stack', slot: hit.slot, valid: true, x: at.x, y: at.y, w: hw, h: hh };
      }

      const x = Math.max(0, Math.min(px - grabX, layout.cols - w));
      const y = Math.max(0, Math.min(py - grabY, layout.rows - h));
      const slot = cellAt(layout, x, y);
      const free = occupancy(targetInventory.items, layout, same && whole ? [sourceItem.slot] : undefined);

      if (fits(layout, free, slot, w, h)) return { kind: 'move', slot, valid: true, x, y, w, h };

      // dropping a whole item onto another one trades their places when both fit
      if (hit && isSlotWithItem(hit) && whole && !fromShop && canSwap(sourceInventory, sourceItem, targetInventory, hit, rotated)) {
        const at = cellCoords(layout, hit.slot);
        const [hw, hh] = footprint(hit.name, hit.rotated);
        return { kind: 'swap', slot: hit.slot, valid: true, x: at.x, y: at.y, w: hw, h: hh };
      }

      return { kind: 'move', slot, valid: false, x, y, w, h };
    },
    [inventory.type, layout]
  );

  const update = useCallback(
    (next: Placement | null) =>
      setPlacement((current) =>
        current?.slot === next?.slot &&
        current?.valid === next?.valid &&
        current?.kind === next?.kind &&
        current?.x === next?.x &&
        current?.y === next?.y &&
        current?.w === next?.w &&
        current?.h === next?.h
          ? current
          : next
      ),
    []
  );

  const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({ isOver: monitor.isOver() }),
      hover: (source, monitor) => update(resolve(source, monitor.getClientOffset())),
      drop: (source, monitor) => {
        const result = resolve(source, monitor.getClientOffset());
        update(null);
        store.dispatch(closeTooltip());

        if (!result?.valid) return;

        const target = { inventory: inventory.type, item: { slot: result.slot }, rotate: getGridDrag().rotated };

        if (source.inventory === InventoryType.SHOP) onBuy(source, target);
        else if (source.inventory === InventoryType.CRAFTING) onCraft(source, target);
        else onDrop(source, target);
      },
    }),
    [inventory.type, resolve]
  );

  // R while hovering without moving the mouse still moves the preview
  useEffect(() => {
    if (!isOver) return update(null);
    const monitor = manager.getMonitor();
    update(resolve(monitor.getItem() as DragSource | null, monitor.getClientOffset()));
  }, [isOver, gridDrag, resolve, update, manager]);

  const style = { '--grid-cols': layout.cols, '--grid-rows': layout.rows } as React.CSSProperties;

  return (
    <div className="grid-inventory">
      {hotbar.length > 0 && (
        <div className="grid-hotbar">
          {hotbar.map((item) => (
            <InventorySlot
              key={`${inventory.type}-${inventory.id}-${item.slot}`}
              item={item}
              inventoryType={inventory.type}
              inventoryGroups={inventory.groups}
              inventoryId={inventory.id}
            />
          ))}
        </div>
      )}
      <div className="grid-scroll">
        <div
          className="grid-cells"
          style={style}
          ref={(element) => {
            cellsRef.current = element;
            drop(element);
          }}
        >
          {Array.from({ length: layout.last - layout.first + 1 }, (_, index) => (
            <div key={index} className="grid-cell" />
          ))}
          {isOver && placement && (
            <div
              className={`grid-placement${placement.valid ? '' : ' invalid'}${placement.kind !== 'move' ? ` ${placement.kind}` : ''}`}
              style={position(placement.x, placement.y, placement.w, placement.h)}
            />
          )}
          {items.map((item) => (
            <GridItem key={`${inventory.type}-${inventory.id}-${item.slot}`} item={item} inventory={inventory} layout={layout} />
          ))}
        </div>
      </div>
    </div>
  );
};

export default GridInventory;
