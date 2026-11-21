// Browser preview fixtures for the optional features.
//   ?grid=1    grid inventory (pockets 8 x 8, stash 8 x 6, worn bag 8 x 2)
//   ?rarity=0  rarity off (it is on by default, like data/rarity.lua)
// Sizes and rarities mirror data/grid.lua and data/rarity.lua; in game they come from the init event.
import { Items } from '../store/items';
import { Grid } from '../store/grid';
import { Utility } from '../store/utility';
import { debugData } from './debugData';
import { ItemData } from '../typings';
import { store } from '../store';
import { openTooltip } from '../store/tooltip';

const add = (name: string, label: string, extra: Partial<ItemData> = {}) => {
  Items[name] = { name, label, stack: true, usable: true, close: false, count: 0, ...Items[name], ...extra };
};

// ?tooltip=<item name>: opens that item's tooltip a moment after load (headless screenshots can't hover)
const devTooltip = () => {
  const name = new URLSearchParams(window.location.search).get('tooltip');
  if (!name) return;

  // the fade-in never runs in a background tab
  const style = document.createElement('style');
  style.textContent = '.tooltip-wrapper { opacity: 1 !important; }';
  document.head.appendChild(style);

  setTimeout(() => {
    const state = store.getState().inventory;
    for (const inventory of [state.rightInventory, state.leftInventory, state.backpackInventory]) {
      const item = inventory.items.find((slot) => slot.name === name);
      if (!item) continue;
      const element = [...document.querySelectorAll('.grid-item, .inventory-slot')].find((el) =>
        el.textContent?.includes(Items[name]?.label || name)
      );
      const rect = element?.getBoundingClientRect();
      if (rect) window.dispatchEvent(new MouseEvent('mousemove', { clientX: rect.right - 8, clientY: rect.top + 8 }));
      store.dispatch(openTooltip({ item: item as any, inventoryType: inventory.type }));
      return;
    }
  }, 1800);
};

// ?clothing=1: clothing items in the Clothing tab squares, plus two spare pieces for the pockets
const clothingPiece = (key: string, label: string, drawable: number, slot: number) => ({
  slot,
  name: 'clothing_item',
  weight: 250,
  count: 1,
  metadata: { slot: key, model: 'mp_m_freemode_01', collection: '', drawable, texture: 0, label: `${label} #${drawable} (Male)` },
});

const clothingFixture = (pocketSlots: number[]) => {
  const square = (key: string) => Utility.clothing.find((entry) => entry.key === key)?.slot ?? 0;
  return [
    clothingPiece('hat', 'Hat', 5, square('hat')),
    clothingPiece('glasses', 'Glasses', 7, square('glasses')),
    clothingPiece('watch', 'Watch', 3, square('watch')),
    clothingPiece('shirt', 'Shirt', 15, square('shirt')),
    clothingPiece('undershirt', 'Undershirt', 2, square('undershirt')),
    clothingPiece('pants', 'Pants', 24, square('pants')),
    clothingPiece('shoes', 'Shoes', 10, square('shoes')),
    clothingPiece('shirt', 'Shirt', 4, pocketSlots[0]),
    clothingPiece('mask', 'Mask', 51, pocketSlots[1]),
  ];
};

export const devGridSetup = () => {
  if (!import.meta.env.DEV) return;

  devTooltip();

  // rarities shown in both layouts
  add('WEAPON_PISTOL', 'Pistol', { stack: false, rarity: 'uncommon' });
  add('WEAPON_CARBINERIFLE', 'Carbine Rifle', { stack: false, rarity: 'rare' });
  add('WEAPON_ASSAULTRIFLE_MK2', 'Assault Rifle Mk II', { stack: false, rarity: 'epic' });
  add('WEAPON_HEAVYSNIPER_MK2', 'Heavy Sniper Mk II', { stack: false, rarity: 'legendary' });
  add('WEAPON_SMG', 'SMG', { stack: false, rarity: 'rare' });
  add('WEAPON_KNIFE', 'Knife', { stack: false });
  add('WEAPON_GRENADE', 'Grenade', { rarity: 'uncommon' });
  add('ammo-rifle', '5.56 Ammo');
  add('advancedlockpick', 'Advanced Lockpick', { rarity: 'uncommon' });
  add('laptop', 'Laptop', { stack: false, rarity: 'uncommon' });
  add('heavyarmor', 'Heavy Armor', { stack: false, rarity: 'rare' });
  add('backpack_large', 'Large Backpack', { stack: false, rarity: 'rare' });
  add('radio', 'Radio');
  add('money', 'Money');
  Items['lockpick'] = { ...Items['lockpick']!, rarity: 'common' };

  const clothing = Utility.clothing.length > 0;
  if (clothing) add('clothing_item', 'Clothing', { stack: false });

  if (!Grid.enabled) {
    if (clothing)
      debugData(
        [
          {
            action: 'setupInventory',
            data: {
              leftInventory: {
                id: 'test',
                type: 'player',
                slots: 50 + Utility.clothing.length,
                label: 'QuickOtter7579',
                weight: 3000,
                maxWeight: 75000,
                items: [
                  { slot: 1, name: 'WEAPON_PISTOL', weight: 1200, count: 1, metadata: { durability: 82, ammo: 12 } },
                  { slot: 3, name: 'tablet', weight: 20, count: 1 },
                  { slot: 6, name: 'bandage', weight: 3000, count: 15 },
                  { slot: 7, name: 'firstaid', weight: 6000, count: 6 },
                  { slot: 8, name: 'laptop', weight: 1500, count: 1 },
                  { slot: 9, name: 'lockpick', weight: 2250, count: 15 },
                  { slot: 10, name: 'money', weight: 0, count: 2350 },
                  { slot: 13, name: 'phone', weight: 190, count: 1 },
                  { slot: 47, name: 'backpack', weight: 4200, count: 1, metadata: { container: 'dev-backpack', size: [20, 40000] } },
                  { slot: 48, name: 'armour', weight: 3000, count: 1 },
                  ...clothingFixture([11, 12]),
                ],
              },
            },
          },
        ],
        1100
      );
    return;
  }

  const sizes: Record<string, [number, number]> = {
    WEAPON_PISTOL: [2, 1],
    WEAPON_CARBINERIFLE: [4, 2],
    WEAPON_ASSAULTRIFLE_MK2: [4, 2],
    WEAPON_HEAVYSNIPER_MK2: [5, 2],
    WEAPON_SMG: [3, 2],
    WEAPON_KNIFE: [2, 1],
    laptop: [2, 2],
    tablet: [2, 1],
    heavyarmor: [3, 3],
    backpack_large: [3, 4],
    parachute: [2, 2],
    radio: [1, 2],
  };

  for (const [name, size] of Object.entries(sizes)) add(name, Items[name]?.label || name, { size });

  // grid pockets: 5 hotbar slots + 8 x 8 cells, equipment after them (data/grid.lua playerRows = 8)
  const pocketSlots = Grid.hotbar + Grid.columns * Grid.playerRows;
  if (Utility.mode === 'utility')
    Utility.equipment = Utility.equipment.map((entry, index) => ({ ...entry, slot: pocketSlots + index + 1 }));
  if (clothing) {
    const base = pocketSlots + Utility.equipment.length;
    Utility.clothing = Utility.clothing.map((entry, index) => ({ ...entry, slot: base + index + 1 }));
  }
  const equipmentSlot = (kind: string) => Utility.equipment.find((entry) => entry.kind === kind)?.slot;
  const cell = (x: number, y: number) => Grid.hotbar + 1 + y * Grid.columns + x;

  const pockets = [
    { slot: 1, name: 'WEAPON_PISTOL', weight: 1200, count: 1, metadata: { durability: 82, ammo: 12 } },
    { slot: 3, name: 'tablet', weight: 20, count: 1 },
    { slot: cell(0, 0), name: 'WEAPON_CARBINERIFLE', weight: 3200, count: 1, metadata: { durability: 64, ammo: 30 } },
    { slot: cell(4, 0), name: 'laptop', weight: 1500, count: 1 },
    { slot: cell(6, 0), name: 'bandage', weight: 3000, count: 15 },
    { slot: cell(7, 0), name: 'ammo-rifle', weight: 900, count: 90 },
    { slot: cell(6, 1), name: 'radio', weight: 300, count: 1, rotated: true },
    { slot: cell(0, 2), name: 'WEAPON_SMG', weight: 2200, count: 1, metadata: { durability: 91 } },
    { slot: cell(3, 2), name: 'WEAPON_KNIFE', weight: 400, count: 1, metadata: { durability: 100 } },
    { slot: cell(5, 2), name: 'firstaid', weight: 6000, count: 6 },
    { slot: cell(3, 3), name: 'water', weight: 4500, count: 15 },
    { slot: cell(4, 3), name: 'lockpick', weight: 2250, count: 15 },
    { slot: cell(5, 3), name: 'advancedlockpick', weight: 600, count: 2 },
    { slot: cell(6, 3), name: 'money', weight: 0, count: 2350 },
    { slot: cell(0, 4), name: 'heavyarmor', weight: 5000, count: 1, metadata: { durability: 75 } },
    { slot: cell(3, 4), name: 'sandwich', weight: 60, count: 3, metadata: { durability: 35 } },
    { slot: cell(4, 4), name: 'phone', weight: 190, count: 1 },
    { slot: cell(7, 2), name: 'WEAPON_GRENADE', weight: 400, count: 2 },
  ];

  const backpack = equipmentSlot('backpack');
  const armor = equipmentSlot('armor');

  if (backpack)
    pockets.push({
      slot: backpack,
      name: 'backpack_large',
      weight: 4200,
      count: 1,
      metadata: { container: 'dev-backpack', size: [16, 40000] } as any,
    });
  if (clothing) pockets.push(...(clothingFixture([cell(5, 4), cell(6, 4)]) as any[]));
  if (armor) pockets.push({ slot: armor, name: 'heavyarmor', weight: 5000, count: 1, metadata: { durability: 100 } });

  const stashCell = (x: number, y: number) => 1 + y * Grid.columns + x;
  // ?right=shop / ?right=crafting keep their own right side
  const keepRight = new URLSearchParams(window.location.search).has('right');

  debugData(
    [
      {
        action: 'setupInventory',
        data: {
          leftInventory: {
            id: 'test',
            type: 'player',
            slots: pocketSlots + Utility.equipment.length + Utility.clothing.length,
            label: 'QuickOtter7579',
            weight: 3000,
            maxWeight: 75000,
            items: pockets,
          },
          rightInventory: keepRight ? undefined : {
            id: 'dev-stash',
            type: 'stash',
            slots: 48,
            label: 'Storage Locker',
            weight: 18000,
            maxWeight: 150000,
            items: [
              { slot: stashCell(0, 0), name: 'WEAPON_HEAVYSNIPER_MK2', weight: 14000, count: 1, metadata: { durability: 100 } },
              { slot: stashCell(5, 0), name: 'WEAPON_ASSAULTRIFLE_MK2', weight: 4000, count: 1, rotated: true, metadata: { durability: 55 } },
              { slot: stashCell(7, 0), name: 'ammo-rifle', weight: 1800, count: 180 },
              { slot: stashCell(0, 2), name: 'parachute', weight: 800, count: 1 },
              { slot: stashCell(2, 2), name: 'WEAPON_PISTOL', weight: 1200, count: 1, metadata: { durability: 40 } },
              { slot: stashCell(2, 3), name: 'burger', weight: 100, count: 4 },
              { slot: stashCell(0, 4), name: 'water', weight: 1000, count: 2 },
            ],
          },
          backpackInventory: {
            id: 'dev-backpack',
            type: 'container',
            slots: 16,
            label: 'Large Backpack',
            weight: 3200,
            maxWeight: 40000,
            items: [
              { slot: 1, name: 'water', weight: 1500, count: 3 },
              { slot: 2, name: 'bandage', weight: 1000, count: 5 },
              { slot: 3, name: 'laptop', weight: 1500, count: 1 },
            ],
          },
        },
      },
    ],
    1100
  );
};
