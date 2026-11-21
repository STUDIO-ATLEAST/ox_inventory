import React, { useEffect, useLayoutEffect, useRef } from 'react';
import { useDragLayer, useDragDropManager } from 'react-dnd';
import { DragSource } from '../../typings';
import { store } from '../../store';
import { getTargetInventory, isSlotWithItem } from '../../helpers';
import { footprint, Grid, itemSize } from '../../store/grid';
import { getGridDrag, hoveredGridItem, toggleGridDragRotation, useGridDrag } from '../../store/gridDrag';
import { onRotate } from '../../dnd/onDrop';

// name of the item being dragged, read from the inventory it came from
const draggedName = (data: DragSource | null) => {
  if (!data?.item) return undefined;
  if (data.item.name) return data.item.name;
  const { sourceInventory } = getTargetInventory(store.getState().inventory, data.inventory);
  const slot = sourceInventory.items[data.item.slot - 1];
  return isSlotWithItem(slot) ? slot.name : undefined;
};

// distance between two grid cells on screen, measured from the first visible grid
const measurePitch = () => {
  const cells = document.querySelectorAll('.grid-cell');
  if (cells.length < 2) return 0;
  const a = cells[0].getBoundingClientRect();
  const b = cells[1].getBoundingClientRect();
  return { pitch: b.left - a.left, cell: a.width };
};

const DragPreview: React.FC = () => {
  const manager = useDragDropManager();
  const rootRef = useRef<HTMLDivElement>(null);
  const gridDrag = useGridDrag();

  // Only collect item/isDragging here, so we re-render on drag start/end rather than
  // on every pointer move.
  const { data, isDragging } = useDragLayer((monitor) => ({
    data: monitor.getItem() as DragSource | null,
    isDragging: monitor.isDragging(),
  }));

  useEffect(() => {
    document.body.classList.toggle('inv-dragging', isDragging);
    return () => document.body.classList.remove('inv-dragging');
  }, [isDragging]);

  // grid inventory: R turns the dragged item, or the item under the cursor when nothing is dragged
  useEffect(() => {
    if (!Grid.enabled) return;

    const onKey = (event: KeyboardEvent) => {
      if (event.key.toLowerCase() !== 'r' || event.repeat) return;
      const target = event.target as HTMLElement | null;
      if (target && (target.tagName === 'INPUT' || target.tagName === 'TEXTAREA')) return;

      const monitor = manager.getMonitor();

      if (monitor.isDragging()) {
        const name = draggedName(monitor.getItem() as DragSource | null);
        if (!name) return;
        const [w, h] = itemSize(name);
        if (w !== h) toggleGridDragRotation(w, h);
      } else if (hoveredGridItem) onRotate(hoveredGridItem.inventoryType, hoveredGridItem.slot);
    };

    window.addEventListener('keydown', onKey);
    return () => window.removeEventListener('keydown', onKey);
  }, [manager]);

  const name = isDragging ? draggedName(data) : undefined;
  const size = Grid.enabled && name ? measurePitch() : 0;
  const [w, h] = footprint(name, gridDrag.rotated);
  const [iw, ih] = footprint(name, false);

  // Write the position straight to the node so the preview tracks the cursor 1:1
  // instead of lagging a render behind it.
  useLayoutEffect(() => {
    if (!isDragging) return;
    const monitor = manager.getMonitor();
    const el = rootRef.current;
    const apply = () => {
      const offset = monitor.getClientOffset();
      if (!el || !offset) return;

      if (size) {
        // grid preview: the grabbed cell stays under the cursor
        const { grabX, grabY } = getGridDrag();
        const dx = (grabX + 0.5) * size.pitch;
        const dy = (grabY + 0.5) * size.pitch;
        el.style.transform = `translate3d(${offset.x - dx}px, ${offset.y - dy}px, 0)`;
      } else el.style.transform = `translate3d(${offset.x}px, ${offset.y}px, 0) translate(-50%, -50%)`;
    };
    apply();
    return monitor.subscribeToOffsetChange(apply);
  }, [isDragging, manager, size, gridDrag]);

  if (!isDragging || !data?.item) return null;

  if (size) {
    const boxW = w * size.pitch - (size.pitch - size.cell);
    const boxH = h * size.pitch - (size.pitch - size.cell);
    const imgW = iw * size.pitch - (size.pitch - size.cell);
    const imgH = ih * size.pitch - (size.pitch - size.cell);

    return (
      <div className="item-drag-preview grid" ref={rootRef} style={{ width: boxW, height: boxH }}>
        <div
          className="grid-item-image"
          style={{
            backgroundImage: data.image,
            width: imgW,
            height: imgH,
            transform: `translate(-50%, -50%)${gridDrag.rotated ? ' rotate(90deg)' : ''}`,
          }}
        />
      </div>
    );
  }

  return <div className="item-drag-preview" ref={rootRef} style={{ backgroundImage: data.image }} />;
};

export default DragPreview;
