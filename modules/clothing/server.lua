-- Clothing as items, server side (data/clothing.lua).
local Clothing = require 'modules.clothing.shared'

if not Clothing.enabled then return end

local Inventory = require 'modules.inventory.server'
local Items = require 'modules.items.server'
local Grid = require 'modules.grid.shared'

if not Items(Clothing.item) then
    warn(("data/clothing.lua: item '%s' is missing from data/items.lua, clothing items can't be made"):format(Clothing.item))
end

local cooldowns = {}

local COMPONENT_FOLDERS = { [1] = 'masks', [3] = 'arms', [4] = 'pants', [5] = 'bags', [6] = 'shoes', [7] = 'accessories', [8] = 'undershirts', [11] = 'tops' }
local PROP_FOLDERS = { [0] = 'hats', [1] = 'glasses', [2] = 'ears', [6] = 'watches', [7] = 'bracelets' }

---Item metadata for one piece, in the rm-appearance clothing_item format.
---@param def ClothingSlot
---@param piece { model: string, collection?: string, drawable: number, texture?: number }
local function makeMetadata(def, piece)
    local model = type(piece.model) == 'string' and piece.model or 'mp_m_freemode_01'
    local collection = type(piece.collection) == 'string' and piece.collection or ''
    local drawable = math.floor(tonumber(piece.drawable) or 0)
    local gender = model == 'mp_f_freemode_01' and 'Female' or model == 'mp_m_freemode_01' and 'Male' or model

    local metadata = {
        slot = def.key,
        model = model,
        collection = collection,
        drawable = drawable,
        texture = math.floor(tonumber(piece.texture) or 0),
        global = collection == '' or nil,
        label = ('%s #%d (%s)'):format(def.label, drawable, gender),
    }

    -- rm-appearance renders a thumbnail for every piece, use it when it is there
    if GetResourceState('rm-appearance') == 'started' then
        local folder = def.prop and PROP_FOLDERS[def.prop] or COMPONENT_FOLDERS[def.component] or 'tops'
        local thumb = ('%s/%s_%s_%d'):format(folder, model, collection == '' and 'base' or collection, drawable):gsub('[^%w_/-]', '_')
        metadata.imageurl = ('nui://rm-appearance/screenshots/clothing/%s.webp'):format(thumb)
    end

    return metadata
end

local function samePiece(metadata, piece)
    return type(metadata) == 'table'
        and metadata.drawable == math.floor(tonumber(piece.drawable) or -1)
        and (metadata.texture or 0) == math.floor(tonumber(piece.texture) or 0)
        and (metadata.collection or '') == (piece.collection or '')
        and (not metadata.model or metadata.model == piece.model)
end

local function sync(inv, slots)
    inv:syncSlotsWithClients(slots, true)
    if server.syncInventory then server.syncInventory(inv) end
end

local function kvpKey(inv)
    return ('clothing:%s'):format(inv.owner or inv.id)
end

lib.callback.register('ox_inventory:clothingStored', function(source)
    local inv = Inventory(source)
    if not inv then return true end

    return GetResourceKvpInt(kvpKey(inv)) == 1
end)

---Makes the squares match what the character wears. `pieces` holds the worn pieces by square key; a square
---missing from it is worn as nothing. Items that get replaced move to the pockets.
---Used on the first load and after a clothing shop (exports.ox_inventory:syncClothingFromPed).
lib.callback.register('ox_inventory:syncClothing', function(source, pieces)
    local inv = Inventory(source)
    if not inv or type(pieces) ~= 'table' then return false end

    local now = GetGameTimer()
    if cooldowns[source] and now - cooldowns[source] < 2000 then return false end
    cooldowns[source] = now

    local item = Items(Clothing.item)
    if not item then return false end

    local changed = {}

    for i = 1, #Clothing.slots do
        local def = Clothing.slots[i]
        local piece = pieces[def.key]
        local current = inv.items[def.slot]

        if type(piece) == 'table' and type(piece.drawable) ~= 'number' then piece = nil end

        local keep = (piece and current and samePiece(current.metadata, piece)) or (not piece and not current)

        if not keep then
            local free = true

            -- the old piece goes to the pockets; if it doesn't fit there it stays on
            if current then
                free = Inventory.AddItem(inv, current.name, 1, current.metadata) and true or false

                if free then
                    inv.weight -= current.weight
                    inv.items[def.slot] = nil
                end
            end

            if free and piece then
                Inventory.SetSlot(inv, item, 1, makeMetadata(def, piece), def.slot)
            end

            if free then
                inv.changed = true
                changed[#changed + 1] = { item = inv.items[def.slot] or { slot = def.slot }, inventory = inv.id }
            end
        end
    end

    SetResourceKvpInt(kvpKey(inv), 1)

    if #changed > 0 then sync(inv, changed) end

    return true
end)

---Using a clothing item puts it on: it goes into its square and whatever was there takes its place.
lib.callback.register('ox_inventory:wearClothing', function(source, slot)
    local inv = Inventory(source)
    if not inv or type(slot) ~= 'number' then return false end

    local data = inv.items[slot]
    local def = data and data.name == Clothing.item and type(data.metadata) == 'table' and Clothing.byKey[data.metadata.slot]

    if not def or slot == def.slot then return false end

    local worn = inv.items[def.slot]

    if worn and not Grid.canSwap(inv, slot, data, inv, def.slot, worn, data.rotated) then return false end

    Inventory.SwapSlots(inv, inv, slot, def.slot)
    sync(inv, {
        { item = inv.items[slot] or { slot = slot }, inventory = inv.id },
        { item = inv.items[def.slot], inventory = inv.id },
    })

    return true
end)

AddEventHandler('playerDropped', function()
    cooldowns[source] = nil
end)
