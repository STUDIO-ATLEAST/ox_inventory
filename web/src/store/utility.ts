// Utility panel slot rules, sent by the client on init (data/utility.lua).
// Mirrors modules/utility/shared.lua so invalid drops are refused before reaching the server.

export interface EquipmentSlot {
  kind: string;
  label: string;
  slot: number;
  items: string[];
}

// Clothing square on the Clothing tab (data/clothing.lua)
export interface ClothingSlot {
  key: string;
  label: string;
  component?: number;
  prop?: number;
  side: 'left' | 'right';
  slot: number;
  // clothing item name (data/clothing.lua item)
  item?: string;
}

export interface UtilityConfig {
  // 'classic': plain inventory; 'utility': Utility tab with character panel + reserved slots
  mode: 'classic' | 'utility';
  backpackItems: string[];
  weaponSlots: number[];
  equipment: EquipmentSlot[];
  // Crafting / Health tabs next to Inventory (data/utility.lua tabs); with both off there is no top bar
  tabs: { crafting: boolean; health: boolean; clothing: boolean };
  // clothing squares, after the equipment slots; empty when data/clothing.lua is off
  clothing: ClothingSlot[];
}

// browser dev defaults for a 50 slot inventory, overwritten by the init event in game
// (matches data/utility.lua, which runs 'utility' in game; add ?mode=classic to the dev URL for the plain layout)
const devUtility = typeof window !== 'undefined' && new URLSearchParams(window.location.search).get('mode') !== 'classic';

// browser preview: ?notabs=crafting, ?notabs=health or ?notabs=crafting,health
// browser preview: ?clothing=1 adds the Clothing tab
const devClothing = typeof window !== 'undefined' && new URLSearchParams(window.location.search).get('clothing') === '1';

const DEV_CLOTHING: Omit<ClothingSlot, 'slot'>[] = [
  { key: 'hat', label: 'Hat', prop: 0, side: 'left' },
  { key: 'glasses', label: 'Glasses', prop: 1, side: 'left' },
  { key: 'ears', label: 'Ears', prop: 2, side: 'left' },
  { key: 'mask', label: 'Mask', component: 1, side: 'left' },
  { key: 'chain', label: 'Chain', component: 7, side: 'left' },
  { key: 'watch', label: 'Watch', prop: 6, side: 'left' },
  { key: 'shirt', label: 'Shirt', component: 11, side: 'right' },
  { key: 'undershirt', label: 'Undershirt', component: 8, side: 'right' },
  { key: 'gloves', label: 'Gloves', component: 3, side: 'right' },
  { key: 'pants', label: 'Pants', component: 4, side: 'right' },
  { key: 'shoes', label: 'Shoes', component: 6, side: 'right' },
  { key: 'bracelet', label: 'Bracelet', prop: 7, side: 'right' },
];

const devNoTabs = typeof window !== 'undefined' ? new URLSearchParams(window.location.search).get('notabs') || '' : '';

export const Utility: UtilityConfig = {
  mode: devUtility ? 'utility' : 'classic',
  tabs: {
    crafting: devUtility && !devNoTabs.includes('crafting'),
    health: devUtility && !devNoTabs.includes('health'),
    clothing: devUtility && devClothing,
  },
  clothing: devUtility && devClothing ? DEV_CLOTHING.map((entry, index) => ({ ...entry, slot: 51 + index })) : [],
  backpackItems: ['backpack'],
  weaponSlots: devUtility ? [1, 2] : [],
  equipment: devUtility
    ? [
        { kind: 'backpack', label: 'Backpack', slot: 47, items: ['backpack_small', 'backpack_medium', 'backpack_large'] },
        { kind: 'armor', label: 'Armor', slot: 48, items: ['lightarmor', 'heavyarmor', 'armor'] },
        { kind: 'phone', label: 'Phone', slot: 49, items: ['phone'] },
        { kind: 'parachute', label: 'Parachute', slot: 50, items: ['parachute'] },
      ]
    : [],
};

export const isUtilityMode = () => Utility.mode === 'utility';

export const setUtility = (config?: Partial<UtilityConfig>) => {
  if (!config) return;
  Utility.mode = config.mode === 'utility' ? 'utility' : 'classic';
  if (Array.isArray(config.backpackItems)) Utility.backpackItems = config.backpackItems;
  // lua sends empty tables as objects
  if (Array.isArray(config.weaponSlots)) Utility.weaponSlots = config.weaponSlots;
  else if (config.weaponSlots) Utility.weaponSlots = [];
  if (Array.isArray(config.equipment)) Utility.equipment = config.equipment;
  else if (config.equipment) Utility.equipment = [];
  const utility = Utility.mode === 'utility';
  Utility.tabs = {
    crafting: utility && config.tabs?.crafting !== false,
    health: utility && config.tabs?.health !== false,
    clothing: utility && config.tabs?.clothing === true,
  };
  if (Array.isArray(config.clothing)) Utility.clothing = config.clothing;
  else if (config.clothing) Utility.clothing = [];
};

export const CLOTHING_ITEM = 'clothing_item';

const isWeapon = (name: string) => name.toUpperCase().startsWith('WEAPON_');

export const getEquipmentSlot = (slot: number) => Utility.equipment.find((entry) => entry.slot === slot);

export const getClothingSlot = (slot: number) => Utility.clothing.find((entry) => entry.slot === slot);

export const isRestrictedSlot = (slot: number) =>
  Utility.weaponSlots.includes(slot) || !!getEquipmentSlot(slot) || !!getClothingSlot(slot);

// Whether a player inventory slot may hold the given item
// Clothing squares need the item's metadata (metadata.slot names the square), like modules/clothing/shared.lua
export const canHoldItem = (slot: number, name: string, metadata?: Record<string, any>) => {
  if (Utility.weaponSlots.includes(slot)) return isWeapon(name);

  const clothing = getClothingSlot(slot);

  if (clothing) return name === (clothing.item || CLOTHING_ITEM) && metadata?.slot === clothing.key;

  const equipment = getEquipmentSlot(slot);

  return !equipment || equipment.items.some((item) => item.toLowerCase() === name.toLowerCase());
};
