// Grid inventory drag state: which cell of the item was grabbed and whether it is turned.
// R flips `rotated` while dragging (handled in DragPreview), so it lives outside redux and the
// grid drop targets subscribe to it.
import { useSyncExternalStore } from 'react';

export interface GridDragState {
  rotated: boolean;
  // grabbed cell inside the item, counted from its top-left
  grabX: number;
  grabY: number;
}

let state: GridDragState = { rotated: false, grabX: 0, grabY: 0 };
const listeners = new Set<() => void>();

const emit = () => listeners.forEach((listener) => listener());

export const getGridDrag = () => state;

export const startGridDrag = (rotated: boolean, grabX = 0, grabY = 0) => {
  state = { rotated, grabX, grabY };
  emit();
};

// turning the item keeps the grab point on the same part of it
export const toggleGridDragRotation = (w: number, h: number) => {
  const rotated = !state.rotated;
  // footprint after the turn
  const [nw, nh] = rotated ? [h, w] : [w, h];
  state = {
    rotated,
    grabX: Math.min(state.grabY, nw - 1),
    grabY: Math.min(state.grabX, nh - 1),
  };
  emit();
};

const subscribe = (listener: () => void) => {
  listeners.add(listener);
  return () => listeners.delete(listener);
};

export const useGridDrag = () => useSyncExternalStore(subscribe, getGridDrag);

// item under the cursor while nothing is dragged, so R can turn it in place
export let hoveredGridItem: { inventoryType: string; slot: number } | null = null;

export const setHoveredGridItem = (value: typeof hoveredGridItem) => {
  hoveredGridItem = value;
};
