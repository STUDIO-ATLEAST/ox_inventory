local Utility = require 'modules.utility.shared'

---@param slot number?
---@return table?
local function slotItem(slot)
    return slot and PlayerData.inventory and PlayerData.inventory[slot] or nil
end

-----------------------------------------------------------------------------------------------
-- Worn vest: whatever sits in the armor equipment slot is the player's armour.
-- Its durability is the armour value; hits wear it down and an empty vest is destroyed (server side).
-----------------------------------------------------------------------------------------------

local armorSlot = Utility.getSlot('armor')

if armorSlot then
    -- after a hit the armour may sit below the vest durability until the server confirms the new value
    local HIT_GRACE = 3000

    local lastHit = 0
    local lastReported
    local applied = false
    -- true once the ped armour has matched the vest at least once, so a hit right after putting the vest on
    -- (before SetPedArmour lands) can't be read as the vest being shot to pieces
    local synced = false
    local lastDurability

    AddEventHandler('gameEventTriggered', function(name, args)
        if name == 'CEventNetworkEntityDamage' and args[1] == cache.ped then
            lastHit = GetGameTimer()
        end
    end)

    CreateThread(function()
        while true do
            Wait(250)

            if PlayerData.loaded then
                local ped = cache.ped
                local vest = slotItem(armorSlot)
                if vest and not Utility.canHold(armorSlot, vest.name) then vest = nil end
                local armour = GetPedArmour(ped)

                if vest then
                    local durability = math.floor(math.min(vest.metadata?.durability or Utility.vestMax(vest.name), Utility.vestMax(vest.name)))

                    -- a fresher vest was swapped in: its armour has to be applied before hits count against it
                    if lastDurability and durability > lastDurability then synced = false end
                    lastDurability = durability

                    if armour == durability then
                        synced = true
                    elseif synced and armour < durability and GetGameTimer() - lastHit < HIT_GRACE then
                        -- shot: wear the vest down to what is left
                        if armour ~= lastReported then
                            lastReported = armour
                            TriggerServerEvent('ox_inventory:vestDamaged', armour)
                        end
                    elseif armour ~= durability and not IsEntityDead(ped) then
                        -- just put on, respawned, or something else changed the armour
                        lastReported = nil
                        synced = false
                        SetPlayerMaxArmour(cache.playerId, 100)
                        SetPedArmour(ped, durability)
                    end

                    applied = true
                elseif applied then
                    -- vest taken off, dropped or destroyed
                    applied = false
                    synced = false
                    lastDurability = nil
                    lastReported = nil
                    SetPedArmour(ped, 0)
                end
            end
        end
    end)
end

-----------------------------------------------------------------------------------------------
-- Worn backpack: a bag prop on the player's back while a bag is worn
-- ('utility' mode: the bag in the backpack slot, 'classic' mode: the first bag carried).
-----------------------------------------------------------------------------------------------

local backpackSlot = Utility.getSlot('backpack')

---@return string? itemName
local function wornBag()
    if Utility.mode == 'utility' then
        local item = slotItem(backpackSlot)
        return item and Utility.isBackpack(item.name) and item.name or nil
    end

    local found, name

    for slot, item in pairs(PlayerData.inventory or {}) do
        if Utility.isBackpack(item.name) and (not found or slot < found) then
            found, name = slot, item.name
        end
    end

    return name
end

local bagObject, bagModel, bagPed

local function removeBag()
    if bagObject and DoesEntityExist(bagObject) then
        DeleteEntity(bagObject)
    end

    bagObject, bagModel, bagPed = nil, nil, nil
end

---@param model string
---@param prop table
local function attachBag(model, prop)
    local ped = cache.ped
    -- remember the attempt even if it fails, so a missing model isn't re-requested every tick
    bagModel, bagPed = model, ped

    local ok, hash = pcall(lib.requestModel, model, 5000)
    if not ok or not hash then
        return lib.print.warn(('backpack prop %s could not be loaded, is rm-backpacks started?'):format(model))
    end

    local coords = GetEntityCoords(ped)
    local object = CreateObject(hash, coords.x, coords.y, coords.z - 2.0, true, true, false)
    SetModelAsNoLongerNeeded(hash)

    if object == 0 then return end

    local offset = prop.offset or Utility.backpackOffset
    local rotation = prop.rotation or Utility.backpackRotation

    SetEntityCollision(object, false, false)
    AttachEntityToEntity(object, ped, GetPedBoneIndex(ped, Utility.backpackBone),
        offset.x, offset.y, offset.z, rotation.x, rotation.y, rotation.z,
        true, true, false, false, 2, true)

    bagObject = object
end

CreateThread(function()
    while true do
        Wait(500)

        local name = PlayerData.loaded and wornBag()
        local prop = name and Utility.backpackProps[name]
        local model = prop and prop.model

        if model ~= bagModel or bagPed ~= cache.ped or (bagObject and not DoesEntityExist(bagObject)) then
            removeBag()
            if model then attachBag(model, prop) end
        end
    end
end)

AddEventHandler('onResourceStop', function(resource)
    if resource == cache.resource then removeBag() end
end)
