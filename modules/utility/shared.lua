local config = lib.load('data.utility') or {}

---@class UtilitySlot
---@field kind string
---@field label string
---@field slot number
---@field items string[]

local isUtilityMode = config.mode == 'utility'

local Utility = {
    mode = isUtilityMode and 'utility' or 'classic',
    backpackItems = config.backpackItems or { 'backpack' },
    -- Crafting and Health tabs; both are off in 'classic' mode, which has no top bar
    tabs = {
        crafting = isUtilityMode and config.tabs?.crafting ~= false,
        health = isUtilityMode and config.tabs?.health ~= false,
    },
    medical = config.medical or 'auto',
    -- classic mode has no restricted slots at all
    weaponSlots = isUtilityMode and config.weaponSlots or {},
    ---@type UtilitySlot[]
    equipment = {},
    ---@type table<string, { model: string, offset?: vector3, rotation?: vector3 }>
    backpackProps = config.backpackProps or {},
    backpackBone = config.backpackBone or 24818,
    vestArmor = config.vestArmor or {},
    backpackOffset = config.backpackOffset or vec3(-0.27, -0.17, 0.0),
    backpackRotation = config.backpackRotation or vec3(0.0, 90.0, 0.0),
}

local backpackNames = {}

for i = 1, #Utility.backpackItems do
    backpackNames[Utility.backpackItems[i]:lower()] = true
end

---@param itemName string
function Utility.isBackpack(itemName)
    return backpackNames[itemName:lower()] == true
end

---@type table<number, fun(itemName: string): boolean>
local rules = {}

local function isWeapon(itemName)
    return itemName:upper():find('^WEAPON_') ~= nil
end

for i = 1, #Utility.weaponSlots do
    rules[Utility.weaponSlots[i]] = isWeapon
end

local equipment = isUtilityMode and config.equipment or {}
local firstSlot = shared.playerslots - #equipment

for i = 1, #equipment do
    local entry = equipment[i]
    local slot = firstSlot + i
    local allowed = {}

    for j = 1, #entry.items do
        allowed[entry.items[j]:lower()] = true
    end

    Utility.equipment[i] = { kind = entry.kind, label = entry.label, slot = slot, items = entry.items }
    rules[slot] = function(itemName) return allowed[itemName:lower()] == true end
end

---Whether a player inventory slot may hold the given item.
---@param slot number
---@param itemName string
function Utility.canHold(slot, itemName)
    local rule = rules[slot]
    return not rule or rule(itemName)
end

---Whether a player inventory slot only accepts specific items.
---@param slot number
function Utility.isRestricted(slot)
    return rules[slot] ~= nil
end

---Armour a fresh vest of this item gives (its durability when it has none yet).
---@param itemName string
function Utility.vestMax(itemName)
    return Utility.vestArmor[itemName] or 100
end

---@param kind string
---@return number?
function Utility.getSlot(kind)
    for i = 1, #Utility.equipment do
        if Utility.equipment[i].kind == kind then
            return Utility.equipment[i].slot
        end
    end
end

return Utility
