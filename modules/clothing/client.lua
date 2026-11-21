-- Clothing as items, client side (data/clothing.lua).
-- What sits in a clothing square is what the character wears. This only reacts to the squares changing,
-- so clothing shops and wardrobes can still change the ped while they are open; see the README for the
-- appearance resource hooks.
local Clothing = require 'modules.clothing.shared'

---@param data table item data
---@param slot { slot: number, metadata?: table }
exports('useClothingItem', function(data, slot)
    if Clothing.enabled then
        if lib.callback.await('ox_inventory:wearClothing', false, slot.slot) then return end
        return lib.notify({ type = 'error', description = 'You can\'t put that on now' })
    end

    -- clothing tab off: rm-appearance's own physical items put the piece on and use up the item
    local metadata = slot.metadata

    if GetResourceState('rm-appearance') == 'started' and type(metadata) == 'table' and metadata.slot then
        TriggerEvent('qbx_appearance:client:equipClothingItem', metadata.slot, slot.slot, metadata)
    end
end)

local function noop() end

if not Clothing.enabled then
    exports('syncClothingFromPed', noop)
    exports('applyClothing', noop)
    exports('pauseClothing', noop)
    return
end

local FREEMODE = { [`mp_m_freemode_01`] = 'mp_m_freemode_01', [`mp_f_freemode_01`] = 'mp_f_freemode_01' }

local ready = false
local paused = false
---@type table<string, string>
local applied = {}
local lastModel = 0
local warnedModel = false

local function modelName(ped)
    return FREEMODE[GetEntityModel(ped)]
end

---@param ped number
---@param def ClothingSlot
---@return { model: string?, collection: string, drawable: integer, texture: integer }?
local function readPiece(ped, def)
    local model = modelName(ped)

    if def.prop then
        local index = GetPedPropIndex(ped, def.prop)
        if index < 0 then return end

        local piece = { model = model, collection = '', drawable = index, texture = GetPedPropTextureIndex(ped, def.prop) }

        if GetPedCollectionNameFromProp then
            local collection = GetPedCollectionNameFromProp(ped, def.prop, index)

            if collection and collection ~= '' then
                piece.collection = collection
                piece.drawable = GetPedCollectionLocalIndexFromProp(ped, def.prop, index)
            end
        end

        return piece
    end

    local drawable = GetPedDrawableVariation(ped, def.component)
    local naked = Clothing.nakedFor(model or '', def.component)

    if drawable == naked.drawable then return end

    local piece = { model = model, collection = '', drawable = drawable, texture = GetPedTextureVariation(ped, def.component) }

    if GetPedCollectionNameFromDrawable then
        local collection = GetPedCollectionNameFromDrawable(ped, def.component, drawable)

        if collection and collection ~= '' then
            piece.collection = collection
            piece.drawable = GetPedCollectionLocalIndexFromDrawable(ped, def.component, drawable)
        end
    end

    return piece
end

---Puts one square on the ped: its item, or nothing.
---@param ped number
---@param def ClothingSlot
---@param metadata table?
local function putOn(ped, def, metadata)
    local model = modelName(ped)

    if metadata and metadata.model and model and metadata.model ~= model then
        if not warnedModel then
            warnedModel = true
            lib.notify({ type = 'error', description = ('%s does not fit this character'):format(metadata.label or def.label) })
        end
        metadata = nil
    end

    local collection = metadata and metadata.collection ~= '' and metadata.collection or nil

    if def.prop then
        if not metadata then return ClearPedProp(ped, def.prop) end

        if collection and SetPedCollectionPropIndex then
            SetPedCollectionPropIndex(ped, def.prop, collection, metadata.drawable, metadata.texture or 0, true)
        else
            SetPedPropIndex(ped, def.prop, metadata.drawable, metadata.texture or 0, true)
        end

        return
    end

    if not metadata then
        local naked = Clothing.nakedFor(model or '', def.component)
        return SetPedComponentVariation(ped, def.component, naked.drawable, naked.texture or 0, 0)
    end

    if collection and SetPedCollectionComponentVariation then
        SetPedCollectionComponentVariation(ped, def.component, collection, metadata.drawable, metadata.texture or 0, 0)
    else
        SetPedComponentVariation(ped, def.component, metadata.drawable, metadata.texture or 0, 0)
    end
end

local function signature(item)
    local metadata = item and item.metadata

    if not metadata then return 'none' end

    return ('%s:%s:%s:%s'):format(metadata.model or '', metadata.collection or '', metadata.drawable or '', metadata.texture or '')
end

local function appearanceResource()
    local wanted = Clothing.appearance

    if wanted == false then return end
    if wanted ~= 'auto' then return GetResourceState(wanted) == 'started' and wanted or nil end
    if GetResourceState('rm-appearance') == 'started' then return 'rm-appearance' end
    if GetResourceState('illenium-appearance') == 'started' then return 'illenium-appearance' end
end

local function editorOpen()
    if GetResourceState('rm-appearance') == 'started' then
        local ok, open = pcall(function() return exports['rm-appearance']:isEditorOpen() end)
        if ok and open then return true end
    end

    return false
end

local persistAt

---Saves the new look with the appearance resource, so the next login loads the same clothes.
local function persist()
    persistAt = GetGameTimer() + 1000

    SetTimeout(1100, function()
        if not persistAt or GetGameTimer() < persistAt then return end
        persistAt = nil

        local resource = appearanceResource()

        if resource == 'rm-appearance' then
            local ok, data = pcall(function() return exports['rm-appearance']:getPedAppearance() end)
            if ok and data then TriggerServerEvent('qbx_appearance:server:saveAppearance', data) end
        elseif resource == 'illenium-appearance' then
            local ok, data = pcall(function() return exports['illenium-appearance']:getPedAppearance(cache.ped) end)
            if ok and data then TriggerServerEvent('illenium-appearance:server:saveAppearance', data) end
        end
    end)
end

---@param all boolean? put every square on again, not just the ones that changed
local function apply(all)
    local ped = cache.ped
    local changed = false

    for i = 1, #Clothing.slots do
        local def = Clothing.slots[i]
        local item = PlayerData.inventory and PlayerData.inventory[def.slot]
        local sig = signature(item)

        if all or applied[def.key] ~= sig then
            putOn(ped, def, item and item.metadata)
            changed = changed or applied[def.key] ~= nil
            applied[def.key] = sig
        end
    end

    return changed
end

---Puts the squares back on the ped, for appearance resources that just loaded a saved skin or outfit.
local function applyAll()
    if not ready or paused then return end
    warnedModel = false
    apply(true)
end

---Turns what the character wears now into the items in the squares. The replaced items go to the pockets.
---Call it after a clothing shop purchase.
---@return boolean
local function syncFromPed()
    local ped = cache.ped
    local pieces = {}

    for i = 1, #Clothing.slots do
        local def = Clothing.slots[i]
        pieces[def.key] = readPiece(ped, def)
    end

    local ok = lib.callback.await('ox_inventory:syncClothing', false, pieces)

    -- the squares now match the ped; don't put the old items back on in between
    for i = 1, #Clothing.slots do
        local def = Clothing.slots[i]
        local piece = pieces[def.key]
        applied[def.key] = piece and ('%s:%s:%s:%s'):format(piece.model or '', piece.collection or '', piece.drawable, piece.texture) or 'none'
    end

    return ok == true
end

exports('syncClothingFromPed', syncFromPed)
exports('applyClothing', applyAll)
---Stops putting the squares on the ped, for a clothing menu or a job uniform. Turning it back on puts the
---squares on again.
---@param state boolean
exports('pauseClothing', function(state)
    local wasPaused = paused
    paused = state == true
    if wasPaused and not paused then applyAll() end
end)

-- appearance resources that load a saved skin or outfit: the squares win again afterwards
local function reapplySoon()
    SetTimeout(1500, applyAll)
end

for _, event in ipairs({
    'illenium-appearance:client:reloadSkin',
    'illenium-appearance:client:changeOutfit',
    'qbx_appearance:client:reloadSkin',
    'qbx_appearance:client:loadAppearance',
}) do
    AddEventHandler(event, reapplySoon)
end

-- runs again for every character the player loads
local function onLoaded()
    ready = false
    table.wipe(applied)

    -- give the appearance resource time to put the saved skin on first
    Wait(4000)

    -- a new character is still in the creator: wait until their first outfit is picked
    while PlayerData.loaded and (paused or editorOpen()) do Wait(500) end

    if not PlayerData.loaded then return end

    if Clothing.storeOutfitOnFirstLoad and not lib.callback.await('ox_inventory:clothingStored', false) then
        syncFromPed()
    end

    ready = true
    lastModel = GetEntityModel(cache.ped)
    apply(true)
end

CreateThread(function()
    local wasLoaded = false

    while true do
        Wait(400)

        if (PlayerData.loaded == true) ~= wasLoaded then
            wasLoaded = PlayerData.loaded == true
            if wasLoaded then onLoaded() else ready = false end
        elseif ready and PlayerData.loaded and not paused and not editorOpen() then
            local model = GetEntityModel(cache.ped)

            if model ~= lastModel then
                lastModel = model
                applyAll()
            elseif apply(false) then
                persist()
            end
        end
    end
end)
