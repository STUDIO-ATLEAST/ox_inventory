-- Clothing as items (data/clothing.lua). Loaded from init.lua after the grid module, because the clothing
-- squares are extra player slots added after the equipment slots.

local config = lib.load('data.clothing') or {}
local utilityConfig = lib.load('data.utility') or {}

---@class ClothingSlot
---@field key string
---@field label string
---@field component? integer
---@field prop? integer
---@field side 'left' | 'right'
---@field slot integer

local Clothing = {
    -- the squares live on a tab, and tabs only exist in 'utility' mode
    enabled = config.enabled == true and utilityConfig.mode == 'utility',
    item = config.item or 'clothing_item',
    appearance = config.appearance == nil and 'auto' or config.appearance,
    storeOutfitOnFirstLoad = config.storeOutfitOnFirstLoad ~= false,
    naked = config.naked or {},
    ---@type ClothingSlot[]
    slots = {},
    ---@type table<string, ClothingSlot>
    byKey = {},
    ---@type table<integer, ClothingSlot>
    bySlot = {},
}

if config.enabled == true and not Clothing.enabled then
    warn("data/clothing.lua is enabled, but the Clothing tab needs mode = 'utility' in data/utility.lua")
end

if Clothing.enabled then
    -- slots before the clothing squares; the equipment slots are counted back from here
    shared.baseslots = shared.playerslots

    for i, entry in ipairs(config.slots or {}) do
        if entry.key and (entry.component or entry.prop) then
            local def = {
                key = entry.key,
                label = entry.label or entry.key,
                component = entry.component,
                prop = entry.prop,
                side = entry.side == 'right' and 'right' or 'left',
                slot = shared.baseslots + #Clothing.slots + 1,
                item = Clothing.item,
            }

            Clothing.slots[#Clothing.slots + 1] = def
            Clothing.byKey[def.key] = def
            Clothing.bySlot[def.slot] = def
        end
    end

    shared.playerslots = shared.baseslots + #Clothing.slots
end

---Whether a clothing square may hold the item: only a clothing item made for that square.
---@param slot integer
---@param itemName string
---@param metadata? table
function Clothing.canHold(slot, itemName, metadata)
    local def = Clothing.bySlot[slot]

    return def ~= nil and itemName == Clothing.item and type(metadata) == 'table' and metadata.slot == def.key
end

---What an empty square puts on for a component (props are cleared instead).
---@param model string
---@param component integer
---@return { drawable: integer, texture: integer }
function Clothing.nakedFor(model, component)
    local list = Clothing.naked[model]

    return list and list[component] or { drawable = 0, texture = 0 }
end

return Clothing
