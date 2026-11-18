-- Worn vest, server side: the client reports hits, the server only ever lowers the vest's durability
-- and deletes the vest once it reaches 0. Using a vest from the pockets moves it into the armor slot.

local Utility = require 'modules.utility.shared'
local Inventory = require 'modules.inventory.server'

local armorSlot = Utility.getSlot('armor')
if not armorSlot then return end

---@param inv OxInventory
---@return SlotWithItem?
local function wornVest(inv)
    local item = inv.items[armorSlot]
    if item and Utility.canHold(armorSlot, item.name) then return item end
end

RegisterNetEvent('ox_inventory:vestDamaged', function(armour)
    local inv = Inventory(source)
    if not inv or type(armour) ~= 'number' or armour ~= armour then return end

    local vest = wornVest(inv)
    if not vest then return end

    local max = Utility.vestMax(vest.name)
    armour = math.floor(math.max(0, math.min(armour, max)))
    local durability = math.min(vest.metadata.durability or max, max)

    if armour >= durability then return end

    if armour <= 0 then
        -- vests stack: the worn one breaks and the next one in the stack is fresh
        local stacked = vest.count > 1
        Inventory.RemoveItem(inv, vest.name, 1, nil, armorSlot)
        if stacked and inv.items[armorSlot] then Inventory.SetDurability(inv, armorSlot, max) end
    else
        Inventory.SetDurability(inv, armorSlot, armour)
    end
end)

RegisterNetEvent('ox_inventory:equipVest', function(slot)
    local inv = Inventory(source)
    if not inv or type(slot) ~= 'number' or slot == armorSlot then return end

    local item = inv.items[slot]
    if not item or not Utility.canHold(armorSlot, item.name) then return end

    Inventory.SwapSlots(inv, inv, slot, armorSlot)
    inv:syncSlotsWithClients({
        { item = inv.items[slot] or { slot = slot }, inventory = inv.id },
        { item = inv.items[armorSlot], inventory = inv.id },
    }, true)

    if server.syncInventory then server.syncInventory(inv) end
end)
