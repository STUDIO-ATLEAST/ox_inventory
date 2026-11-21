-- Optional item rarity.
--
-- With `enabled = true` items that have a rarity get a tinted slot and border in the tier colour and a
-- rarity badge in the tooltip. Items without a rarity look and behave exactly as before.
-- With `enabled = false` rarity is ignored everywhere.
--
-- An item's rarity comes from, in order:
--   1. its metadata (`metadata.rarity = 'epic'`), so a single drop or reward can be rarer than usual
--   2. `rarity = 'rare'` on the item itself (data/items.lua or data/weapons.lua)
--   3. the `items` table below
return {
    enabled = true,

    -- Tier id = label and colour (server theme, Mantine .4). Listed from lowest to highest.
    -- 'common' has no tint, so it looks like a plain slot apart from the tooltip badge.
    tiers = {
        { id = 'common', label = 'Common', color = '#909296', tint = false },
        { id = 'uncommon', label = 'Uncommon', color = '#69db7c' },
        { id = 'rare', label = 'Rare', color = '#4dabf7' },
        { id = 'epic', label = 'Epic', color = '#9775fa' },
        { id = 'legendary', label = 'Legendary', color = '#ffa94d' },
    },

    -- Default rarity per item name (lowercase). Item definitions and metadata override this.
    items = {
        advancedlockpick = 'uncommon',
        armor = 'rare',
        heavyarmor = 'rare',
        backpack_large = 'rare',
        laptop = 'uncommon',

        weapon_pistol_mk2 = 'rare',
        weapon_snspistol_mk2 = 'rare',
        weapon_revolver_mk2 = 'rare',
        weapon_smg_mk2 = 'epic',
        weapon_assaultrifle_mk2 = 'epic',
        weapon_carbinerifle_mk2 = 'epic',
        weapon_bullpuprifle_mk2 = 'epic',
        weapon_specialcarbine_mk2 = 'epic',
        weapon_pumpshotgun_mk2 = 'epic',
        weapon_combatmg_mk2 = 'epic',
        weapon_marksmanrifle_mk2 = 'epic',
        weapon_heavysniper_mk2 = 'legendary',
        weapon_rpg = 'legendary',
        weapon_minigun = 'legendary',
        weapon_railgun = 'legendary',
        weapon_railgunxm3 = 'legendary',
        weapon_hominglauncher = 'legendary',
        weapon_grenadelauncher = 'legendary',
    },
}
