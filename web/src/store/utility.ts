// Utility panel slot rules, sent by the client on init (data/utility.lua).
// Mirrors modules/utility/shared.lua so invalid drops are refused before reaching the server.

export interface EquipmentSlot {
  kind: string;
  label: string;
  slot: number;
  items: string[];
}

export interface UtilityConfig {
  // 'classic': plain inventory; 'utility': Utility tab with character panel + reserved slots
  mode: 'classic' | 'utility';
  backpackItems: string[];
  weaponSlots: number[];
  equipment: EquipmentSlot[];
  // Crafting / Health tabs next to Inventory (data/utility.lua tabs); with both off there is no top bar
  tabs: { crafting: boolean; health: boolean };
}

// browser dev defaults for a 50 slot inventory, overwritten by the init event in game
// (matches data/utility.lua, which runs 'utility' in game; add ?mode=classic to the dev URL for the plain layout)
const devUtility = typeof window !== 'undefined' && new URLSearchParams(window.location.search).get('mode') !== 'classic';

// browser preview: ?notabs=crafting, ?notabs=health or ?notabs=crafting,health
const devNoTabs = typeof window !== 'undefined' ? new URLSearchParams(window.location.search).get('notabs') || '' : '';

export const Utility: UtilityConfig = {
  mode: devUtility ? 'utility' : 'classic',
  tabs: { crafting: devUtility && !devNoTabs.includes('crafting'), health: devUtility && !devNoTabs.includes('health') },
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
  };
};

const isWeapon = (name: string) => name.toUpperCase().startsWith('WEAPON_');

export const getEquipmentSlot = (slot: number) => Utility.equipment.find((entry) => entry.slot === slot);

export const isRestrictedSlot = (slot: number) => Utility.weaponSlots.includes(slot) || !!getEquipmentSlot(slot);

// Whether a player inventory slot may hold the given item
export const canHoldItem = (slot: number, name: string) => {
  if (Utility.weaponSlots.includes(slot)) return isWeapon(name);

  const equipment = getEquipmentSlot(slot);

  return !equipment || equipment.items.some((item) => item.toLowerCase() === name.toLowerCase());
};
