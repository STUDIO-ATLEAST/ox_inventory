-- Inventory layout configuration (also sent to the UI on load).
return {
    -- 'classic': normal inventory, hotbar = slots 1-5, no reserved slots and no Utility tab.
    -- 'utility': adds the Utility tab with a character panel, weapon slots and equipment slots (settings below).
    mode = 'utility',

    -- Container items treated as a worn backpack. In 'classic' mode the first one carried anywhere in the pockets
    -- opens next to the ground on TAB; in 'utility' mode it has to sit in the backpack equipment slot.
    backpackItems = { 'backpack_small', 'backpack_medium', 'backpack_large' },

    -- Prop shown on the player's back while a bag is worn (atleastv4 props, streamed by [assets]/rm-backpacks).
    -- Offsets are the ones atleastv4 used for these props (rm-smallresources weapons/carry), relative to SKEL_Spine3.
    backpackProps = {
        backpack = { model = 'mic_atleast_backpack2', offset = vec3(-0.27, -0.17, 0.0), rotation = vec3(0.0, 90.0, 0.0) },
        backpack_small = { model = 'mic_atleast_backpack', offset = vec3(-0.20, -0.15, 0.0), rotation = vec3(0.0, 90.0, -90.0) },
        backpack_medium = { model = 'mic_atleast_backpack2', offset = vec3(-0.27, -0.17, 0.0), rotation = vec3(0.0, 90.0, 0.0) },
        backpack_large = { model = 'mic_atleast_backpack3', offset = vec3(-0.29, -0.19, 0.0), rotation = vec3(0.0, 90.0, 0.0) },
    },
    backpackBone = 24818,

    -- Armour a fresh vest gives in the armor slot (atleastv4 values); hits wear it down from there.
    vestArmor = { lightarmor = 50, heavyarmor = 75, armor = 100 },
    -- fallback for bags without their own offset / rotation
    backpackOffset = vec3(-0.27, -0.17, 0.0),
    backpackRotation = vec3(0.0, 90.0, 0.0),

    -- 'utility' mode only ---------------------------------------------------------------------------------------

    -- Hotbar slots shown as "Weapon Slot" boxes; they only accept weapons (WEAPON_*).
    -- Set to {} to let any item go into them like the other hotbar slots.
    weaponSlots = { 1, 2 },

    -- Equipment slots are real player slots reserved at the end of the inventory (inventory:slots convar).
    -- They are filled in order, so the last entry uses the very last slot. Only the listed items fit.
    equipment = {
        { kind = 'backpack', label = 'Backpack', items = { 'backpack_small', 'backpack_medium', 'backpack_large' } },
        { kind = 'armor', label = 'Armor', items = { 'lightarmor', 'heavyarmor', 'armor' } },
        { kind = 'phone', label = 'Phone', items = { 'phone' } },
        { kind = 'parachute', label = 'Parachute', items = { 'parachute' } },
    },
}
