-- Optional clothing as items, with a Clothing tab next to Inventory ('utility' mode only).
--
-- With `enabled = false` (the default) nothing here is used and clothes stay with your appearance resource.
--
-- With `enabled = true` every piece of clothing is a `clothing_item` and the Clothing tab shows the character
-- with one square per piece. What sits in a square is what the character wears: drag a shirt in and it goes on,
-- drag it out and the character takes it off. Clothing items stay in the player inventory, so they are saved,
-- traded, stored and dropped like any other item.
--
-- The item format is the one rm-appearance uses for its physical clothing items, so items made by either
-- resource work in both: metadata = { slot = 'shirt', model = 'mp_m_freemode_01', collection = '', drawable = 15,
-- texture = 0, label = 'Shirt #15 (Male)' }. See the README for the illenium-appearance edits.
return {
    enabled = false,

    -- the item every clothing piece uses (add it to data/items.lua, see the README)
    item = 'clothing_item',

    -- which appearance resource to keep in sync after clothes change: 'auto', 'illenium-appearance',
    -- 'rm-appearance' or false. 'auto' picks the one that is running.
    appearance = 'auto',

    -- the first time a character loads with this turned on, the clothes they wear become items in the squares,
    -- so turning it on doesn't leave anyone without clothes
    storeOutfitOnFirstLoad = true,

    -- Squares on the Clothing tab, in order. side = which side of the character the square sits on.
    -- component = ped component id, prop = ped prop id. The keys match rm-appearance's slot names.
    slots = {
        { key = 'hat', label = 'Hat', prop = 0, side = 'left' },
        { key = 'glasses', label = 'Glasses', prop = 1, side = 'left' },
        { key = 'ears', label = 'Ears', prop = 2, side = 'left' },
        { key = 'mask', label = 'Mask', component = 1, side = 'left' },
        { key = 'chain', label = 'Chain', component = 7, side = 'left' },
        { key = 'watch', label = 'Watch', prop = 6, side = 'left' },
        { key = 'shirt', label = 'Shirt', component = 11, side = 'right' },
        { key = 'undershirt', label = 'Undershirt', component = 8, side = 'right' },
        { key = 'gloves', label = 'Gloves', component = 3, side = 'right' },
        { key = 'pants', label = 'Pants', component = 4, side = 'right' },
        { key = 'shoes', label = 'Shoes', component = 6, side = 'right' },
        { key = 'bracelet', label = 'Bracelet', prop = 7, side = 'right' },
    },

    -- What an empty square puts on, per freemode model and component id (props are just removed).
    -- Components not listed here go to drawable 0. These are the GTA "nothing on" pieces.
    naked = {
        mp_m_freemode_01 = {
            [1] = { drawable = 0, texture = 0 },
            [3] = { drawable = 15, texture = 0 },
            [4] = { drawable = 61, texture = 0 },
            [6] = { drawable = 34, texture = 0 },
            [7] = { drawable = 0, texture = 0 },
            [8] = { drawable = 15, texture = 0 },
            [11] = { drawable = 252, texture = 0 },
        },
        mp_f_freemode_01 = {
            [1] = { drawable = 0, texture = 0 },
            [3] = { drawable = 15, texture = 0 },
            [4] = { drawable = 14, texture = 0 },
            [6] = { drawable = 35, texture = 0 },
            [7] = { drawable = 0, texture = 0 },
            [8] = { drawable = 14, texture = 0 },
            [11] = { drawable = 15, texture = 0 },
        },
    },
}
