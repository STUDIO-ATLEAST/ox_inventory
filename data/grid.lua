-- Optional Tarkov-style grid inventory.
--
-- With `enabled = false` (the default) the inventory is the normal slot inventory and nothing below is used.
--
-- With `enabled = true` every storage inventory (pockets, stashes, trunks, gloveboxes, drops, bags,
-- evidence lockers, dumpsters) becomes a grid of cells. Items take up width x height cells, can be dropped
-- anywhere they fit and can be rotated with R while dragging (or R while hovering an item).
-- Shops and crafting benches keep their own views. The hotbar (slots 1-5) and the utility equipment slots
-- stay single slots that take an item of any size.
--
-- Positions are stored server-side: an item's slot number is its top-left cell, and `rotated` is saved
-- with it in the database next to name/count/metadata.
--
-- Turning the grid on changes the player slot count to 5 + columns * playerRows (+ equipment slots in
-- 'utility' mode), so worn equipment may need to be put back once. Items that no longer fit where they
-- were saved are moved to the first free spot when the inventory loads.
return {
    enabled = false,

    -- Cells per row in every grid. The UI is laid out for 8 (each cell is 1/8 of the panel width).
    columns = 8,

    -- Height of the player's pocket grid. Other inventories get ceil(slots / columns) rows, and their
    -- slot count is rounded up to whole rows (a 50 slot stash becomes 8 x 7 = 56 cells).
    playerRows = 8,

    -- Item sizes, in cells. The first match wins:
    --   1. `size = { 2, 1 }` on the item itself (data/items.lua or data/weapons.lua)
    --   2. this `sizes` table
    --   3. the first entry in `rules` whose Lua pattern matches the lowercased item name
    --   4. 1 x 1
    -- Sizes are clamped to the column count.
    sizes = {
        backpack = { 3, 3 },
        backpack_small = { 2, 2 },
        backpack_medium = { 3, 3 },
        backpack_large = { 3, 4 },
        lightarmor = { 2, 2 },
        heavyarmor = { 3, 3 },
        armor = { 3, 3 },
        armour = { 3, 3 },
        laptop = { 2, 2 },
        tablet = { 2, 1 },
        parachute = { 2, 2 },
        radio = { 1, 2 },
        weapon_petrolcan = { 2, 2 },
        weapon_hazardcan = { 2, 2 },
        weapon_fertilizercan = { 2, 2 },
        weapon_fireextinguisher = { 1, 3 },
        weapon_metaldetector = { 1, 4 },
        weapon_knuckle = { 1, 1 },
        weapon_flashlight = { 2, 1 },
        weapon_gusenberg = { 4, 2 },
        weapon_compactrifle = { 3, 2 },
        weapon_sawnoffshotgun = { 3, 1 },
        weapon_dbshotgun = { 3, 1 },
        weapon_microsmg = { 2, 2 },
        weapon_minismg = { 2, 2 },
        weapon_machinepistol = { 2, 2 },
    },

    rules = {
        -- throwables and small handhelds
        { match = '^weapon_.*grenade$', size = { 1, 1 } },
        { match = '^weapon_molotov$', size = { 1, 1 } },
        { match = '^weapon_pipebomb$', size = { 1, 1 } },
        { match = '^weapon_stickybomb$', size = { 1, 1 } },
        { match = '^weapon_proxmine$', size = { 1, 1 } },
        { match = '^weapon_bzgas$', size = { 1, 1 } },
        { match = '^weapon_teargas$', size = { 1, 1 } },
        { match = '^weapon_flare$', size = { 1, 1 } },
        { match = '^weapon_ball$', size = { 1, 1 } },
        { match = '^weapon_snowball$', size = { 1, 1 } },
        { match = '^weapon_stone_hatchet$', size = { 3, 1 } },

        -- heavy weapons and long rifles
        { match = '^weapon_.*sniper', size = { 5, 2 } },
        { match = '^weapon_marksmanrifle', size = { 5, 2 } },
        { match = '^weapon_precisionrifle$', size = { 5, 2 } },
        { match = '^weapon_musket$', size = { 5, 2 } },
        { match = '^weapon_rpg$', size = { 5, 2 } },
        { match = 'launcher$', size = { 5, 2 } },
        { match = 'minigun$', size = { 5, 2 } },
        { match = '^weapon_railgun', size = { 5, 2 } },
        { match = '^weapon_firework$', size = { 5, 2 } },
        { match = '^weapon_mg$', size = { 5, 2 } },
        { match = '^weapon_combatmg', size = { 5, 2 } },

        -- rifles and shotguns
        { match = '^weapon_.*rifle', size = { 4, 2 } },
        { match = '^weapon_.*carbine', size = { 4, 2 } },
        { match = '^weapon_.*shotgun', size = { 4, 2 } },

        -- smgs
        { match = '^weapon_.*smg', size = { 3, 2 } },
        { match = '^weapon_combatpdw$', size = { 3, 2 } },

        -- handguns
        { match = '^weapon_.*pistol', size = { 2, 1 } },
        { match = '^weapon_.*revolver', size = { 2, 1 } },
        { match = '^weapon_doubleaction$', size = { 2, 1 } },
        { match = '^weapon_stungun$', size = { 2, 1 } },
        { match = '^weapon_flaregun$', size = { 2, 1 } },

        -- melee
        { match = '^weapon_bat$', size = { 4, 1 } },
        { match = '^weapon_poolcue$', size = { 4, 1 } },
        { match = '^weapon_golfclub$', size = { 4, 1 } },
        { match = '^weapon_candycane$', size = { 4, 1 } },
        { match = '^weapon_battleaxe$', size = { 3, 1 } },
        { match = '^weapon_machete$', size = { 3, 1 } },
        { match = '^weapon_crowbar$', size = { 3, 1 } },
        { match = '^weapon_nightstick$', size = { 3, 1 } },
        { match = '^weapon_hatchet$', size = { 3, 1 } },
        { match = '^weapon_hammer$', size = { 2, 1 } },
        { match = '^weapon_wrench$', size = { 2, 1 } },
        { match = '^weapon_bottle$', size = { 2, 1 } },
        { match = '^weapon_knife$', size = { 2, 1 } },
        { match = '^weapon_dagger$', size = { 2, 1 } },
        { match = '^weapon_switchblade$', size = { 2, 1 } },
    },
}
