// Tarkov-style grid inventory (data/grid.lua). Mirrors modules/grid/shared.lua so the UI can show
// where an item fits before the server checks the move again.
import { Inventory, InventoryType, Slot } from '../typings';
import { Items } from './items';

export interface GridConfig {
  enabled: boolean;
  columns: number;
  playerRows: number;
  hotbar: number;
}

export interface GridLayout {
  first: number;
  last: number;
  cols: number;
  rows: number;
}

const devParams = typeof window !== 'undefined' ? new URLSearchParams(window.location.search) : null;

// browser preview: ?grid=1 turns the grid on, overwritten by the init event in game
export const Grid: GridConfig = {
  enabled: devParams?.get('grid') === '1',
  columns: 8,
  playerRows: 8,
  hotbar: 5,
};

export const setGrid = (config?: Partial<GridConfig>) => {
  if (!config) return;
  Grid.enabled = config.enabled === true;
  if (config.columns) Grid.columns = config.columns;
  if (config.playerRows) Grid.playerRows = config.playerRows;
  if (config.hotbar) Grid.hotbar = config.hotbar;
};

const NO_GRID = new Set<string>([InventoryType.SHOP, InventoryType.CRAFTING, 'inspect']);

export const usesGrid = (type?: string) => Grid.enabled && !!type && !NO_GRID.has(type);

export const isPlayerType = (type?: string) => type === InventoryType.PLAYER || type === 'otherplayer';

export const gridLayout = (inventory: Pick<Inventory, 'type' | 'slots'>): GridLayout | null => {
  if (!usesGrid(inventory.type)) return null;

  const cols = Grid.columns;

  if (isPlayerType(inventory.type)) {
    const first = Grid.hotbar + 1;
    return { first, last: first + cols * Grid.playerRows - 1, cols, rows: Grid.playerRows };
  }

  const rows = Math.ceil(inventory.slots / cols);
  return { first: 1, last: Math.min(inventory.slots, rows * cols), cols, rows };
};

export const isCellOf = (layout: GridLayout, slot: number) => slot >= layout.first && slot <= layout.last;

export const cellCoords = (layout: GridLayout, slot: number) => {
  const index = slot - layout.first;
  return { x: index % layout.cols, y: Math.floor(index / layout.cols) };
};

export const cellAt = (layout: GridLayout, x: number, y: number) => layout.first + y * layout.cols + x;

export const itemSize = (name?: string): [number, number] => {
  const size = name ? Items[name]?.size : undefined;
  const w = Math.max(1, Math.min(Math.floor(size?.[0] ?? 1), Grid.columns));
  const h = Math.max(1, Math.floor(size?.[1] ?? 1));
  return [w, h];
};

export const footprint = (name?: string, rotated?: boolean): [number, number] => {
  const [w, h] = itemSize(name);
  return rotated ? [h, w] : [w, h];
};

export type Occupancy = Map<number, number>;

// occupied cell slot -> slot of the item covering it
export const occupancy = (items: Slot[], layout: GridLayout, ignore?: number[]): Occupancy => {
  const occupied: Occupancy = new Map();

  for (const item of items) {
    if (!item?.name || ignore?.includes(item.slot) || !isCellOf(layout, item.slot)) continue;
    mark(occupied, layout, item.slot, item.name, item.rotated);
  }

  return occupied;
};

export const mark = (occupied: Occupancy, layout: GridLayout, slot: number, name: string, rotated?: boolean) => {
  const [w, h] = footprint(name, rotated);
  const { x: x0, y: y0 } = cellCoords(layout, slot);

  for (let dy = 0; dy < h; dy++)
    for (let dx = 0; dx < w; dx++) {
      const x = x0 + dx;
      const y = y0 + dy;
      if (x < layout.cols && y < layout.rows) occupied.set(cellAt(layout, x, y), slot);
    }
};

export const fits = (layout: GridLayout, occupied: Occupancy, slot: number, w: number, h: number) => {
  if (!isCellOf(layout, slot)) return false;

  const { x: x0, y: y0 } = cellCoords(layout, slot);

  if (x0 + w > layout.cols || y0 + h > layout.rows) return false;

  for (let dy = 0; dy < h; dy++)
    for (let dx = 0; dx < w; dx++) {
      const cell = cellAt(layout, x0 + dx, y0 + dy);
      if (cell > layout.last || occupied.has(cell)) return false;
    }

  return true;
};

// Non-grid slots (hotbar, equipment) and non-grid inventories always pass; callers check if the slot is free
export const canPlace = (inventory: Inventory, slot: number, name: string, rotated?: boolean, ignore?: number[]) => {
  const layout = gridLayout(inventory);

  if (!layout || !isCellOf(layout, slot)) return true;

  const [w, h] = footprint(name, rotated);
  return fits(layout, occupancy(inventory.items, layout, ignore), slot, w, h);
};

// first free spot, upright before rotated
export const findSpot = (inventory: Inventory, name: string, ignore?: number[]) => {
  const layout = gridLayout(inventory);

  if (!layout) return null;

  const occupied = occupancy(inventory.items, layout, ignore);
  const [w, h] = itemSize(name);

  for (let slot = layout.first; slot <= layout.last; slot++) {
    if (occupied.has(slot)) continue;
    if (fits(layout, occupied, slot, w, h)) return { slot, rotated: false };
    if (w !== h && fits(layout, occupied, slot, h, w)) return { slot, rotated: true };
  }

  return null;
};

// Whole-item swap: `from` lands on toSlot with `rotate`, `to` lands on fromSlot with its own rotation
export const canSwap = (
  fromInventory: Inventory,
  from: Slot,
  toInventory: Inventory,
  to: Slot,
  rotate?: boolean
): boolean => {
  if (fromInventory.id === toInventory.id && fromInventory.type === toInventory.type) {
    const layout = gridLayout(toInventory);

    if (!layout) return true;

    const occupied = occupancy(toInventory.items, layout, [from.slot, to.slot]);

    if (isCellOf(layout, to.slot)) {
      const [w, h] = footprint(from.name, rotate);
      if (!fits(layout, occupied, to.slot, w, h)) return false;
      mark(occupied, layout, to.slot, from.name!, rotate);
    }

    if (isCellOf(layout, from.slot)) {
      const [w, h] = footprint(to.name, to.rotated);
      if (!fits(layout, occupied, from.slot, w, h)) return false;
    }

    return true;
  }

  return (
    canPlace(toInventory, to.slot, from.name!, rotate, [to.slot]) &&
    canPlace(fromInventory, from.slot, to.name!, to.rotated, [from.slot])
  );
};
