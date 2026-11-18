import { Items } from '../store/items';
import type { Inventory, SlotWithItem } from '../typings';

// Browser preview only: a world crafting bench opened as the right inventory (App.tsx, ?right=crafting).
// Recipes are shaped like data/crafting.lua items after modules/crafting/client.lua adds slot + weight.

const DEV_ITEMS: Record<string, string> = {
  lightarmor: 'Light Armor',
  repair_kit: 'Repair Kit',
  weaponrepairkit: 'Weapon Repair Kit',
  WEAPON_WRENCH: 'Wrench',
  WEAPON_HAMMER: 'Hammer',
  electronickit: 'Electronic Kit',
  small_drill: 'Small Drill',
};

const benchItems: SlotWithItem[] = [
  {
    slot: 1,
    name: 'lockpick',
    count: 2,
    weight: 160,
    ingredients: { scrap_metal: 2, metal_parts: 1 },
    duration: 5000,
  },
  {
    slot: 2,
    name: 'advancedlockpick',
    count: 1,
    weight: 160,
    ingredients: { lockpick: 1, metal_parts: 2, plastic: 1 },
    duration: 7000,
  },
  { slot: 3, name: 'bandage', count: 3, weight: 115, ingredients: { fabric: 2 }, duration: 3000 },
  {
    slot: 4,
    name: 'repair_kit',
    count: 1,
    weight: 2500,
    ingredients: { scrap_metal: 2, plastic: 1, lockpick: 0.1 },
    duration: 6000,
    metadata: { description: 'Patches up a vehicle body enough to get it to a mechanic.' },
  },
  {
    slot: 5,
    name: 'lightarmor',
    count: 1,
    weight: 3000,
    ingredients: { fabric: 4, scrap_metal: 3, metal_parts: 1 },
    duration: 9000,
    metadata: {
      label: 'Reinforced light armor vest with extra plating',
      description:
        'Layered fabric over scrap plates. Stops a few pistol rounds before it needs replacing, and is light enough to run in.',
    },
  },
  {
    slot: 6,
    name: 'radio',
    count: 1,
    weight: 300,
    ingredients: { electronic_parts: 2, plastic: 2, copper_coil: 1 },
    duration: 8000,
  },
  {
    slot: 7,
    name: 'weaponrepairkit',
    count: 1,
    weight: 1200,
    ingredients: { metal_parts: 3, rubber: 1, WEAPON_WRENCH: 0.05 },
    duration: 10000,
  },
  {
    slot: 8,
    name: 'electronickit',
    count: 1,
    weight: 500,
    ingredients: { electronic_parts: 3, copper_coil: 2, plastic: 1 },
    duration: 12000,
  },
  {
    slot: 9,
    name: 'small_drill',
    count: 1,
    weight: 1800,
    ingredients: { metal_parts: 4, scrap_metal: 6, WEAPON_HAMMER: 0.1 },
    duration: 15000,
  },
];

export const devCraftingBench: Inventory = {
  id: 'dev-workbench',
  type: 'crafting',
  label: 'Workshop bench',
  slots: benchItems.length,
  items: benchItems,
};

// labels for the bench items the regular dev fixtures in store/items.ts do not have
export const addDevCraftingItems = () => {
  for (const [name, label] of Object.entries(DEV_ITEMS)) {
    Items[name] ??= { name, label, stack: true, usable: false, close: false, count: 0 };
  }
};
