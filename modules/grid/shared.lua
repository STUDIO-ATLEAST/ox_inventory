-- Tarkov-style grid placement (data/grid.lua). Loaded from init.lua before anything reads
-- shared.playerslots, because turning the grid on changes the player slot count.
--
-- An item's slot number is the top-left cell it is anchored to, and `item.rotated` swaps its width and
-- height. Player inventories keep slots 1-5 (hotbar) and the utility equipment slots outside the grid:
-- those are single slots that take an item of any size.

local config = lib.load('data.grid') or {}
local utilityConfig = lib.load('data.utility') or {}

---@class GridLayout
---@field first integer first slot that is a grid cell
---@field last integer last slot that is a grid cell
---@field cols integer
---@field rows integer

local Grid = {
    enabled = config.enabled == true,
    columns = math.max(1, math.floor(tonumber(config.columns) or 8)),
    playerRows = math.max(1, math.floor(tonumber(config.playerRows) or 8)),
    hotbar = 5,
}

-- inventories that are never laid out as a grid
local NO_GRID = { shop = true, crafting = true, inspect = true }

local equipmentCount = utilityConfig.mode == 'utility' and #(utilityConfig.equipment or {}) or 0

---@param slots number
---@return integer
function Grid.roundSlots(slots)
    return math.max(1, math.ceil((tonumber(slots) or 0) / Grid.columns)) * Grid.columns
end

if Grid.enabled then
    shared.playerslots = Grid.hotbar + Grid.columns * Grid.playerRows + equipmentCount
    shared.dropslots = Grid.roundSlots(shared.dropslots)
end

---@param invType string?
---@return boolean
function Grid.uses(invType)
    return Grid.enabled and invType ~= nil and not NO_GRID[invType]
end

---@param invType string
---@param slots number
---@return GridLayout
function Grid.layout(invType, slots)
    local cols = Grid.columns

    if invType == 'player' or invType == 'otherplayer' then
        local first = Grid.hotbar + 1

        return { first = first, last = first + cols * Grid.playerRows - 1, cols = cols, rows = Grid.playerRows }
    end

    local rows = math.ceil((slots or 0) / cols)

    return { first = 1, last = math.min(slots or 0, rows * cols), cols = cols, rows = rows }
end

---@param inv { type: string, slots: number }
---@return GridLayout?
function Grid.layoutOf(inv)
    if not inv or not Grid.uses(inv.type) then return end

    return Grid.layout(inv.type, inv.slots)
end

---@param layout GridLayout
---@param slot number
function Grid.isCellOf(layout, slot)
    return slot >= layout.first and slot <= layout.last
end

---Whether the slot is a grid cell of the inventory (false for hotbar / equipment slots and non-grid inventories).
---@param inv table
---@param slot number
function Grid.isCell(inv, slot)
    local layout = Grid.layoutOf(inv)

    return layout ~= nil and Grid.isCellOf(layout, slot)
end

---@param layout GridLayout
---@param slot number
---@return integer x, integer y
function Grid.coords(layout, slot)
    local index = slot - layout.first

    return index % layout.cols, index // layout.cols
end

local ItemList
local sizeCache = {}
local sizeOverrides = {}
local sizeRules = config.rules or {}

for name, size in pairs(config.sizes or {}) do
    sizeOverrides[name:lower()] = size
end

---@param size any
---@return integer?, integer?
local function readSize(size)
    if type(size) ~= 'table' then return end

    local w = tonumber(size[1] or size.w or size.width)
    local h = tonumber(size[2] or size.h or size.height)

    if w and h then return math.floor(w), math.floor(h) end
end

---Width and height of an item in cells, unrotated.
---@param name string
---@return integer w, integer h
function Grid.itemSize(name)
    if not name then return 1, 1 end

    local cached = sizeCache[name]

    if cached then return cached[1], cached[2] end

    ItemList = ItemList or require 'modules.items.shared'

    local lower = name:lower()
    local item = ItemList[name] or ItemList[lower]
    local w, h = readSize(item and item.size)

    -- items that already carry width / height fields (atleastv4 item lists)
    if not w and item and tonumber(item.width) and tonumber(item.height) then
        w, h = math.floor(item.width), math.floor(item.height)
    end

    if not w then w, h = readSize(sizeOverrides[lower]) end

    if not w then
        for i = 1, #sizeRules do
            local rule = sizeRules[i]

            if rule.match and lower:find(rule.match) then
                w, h = readSize(rule.size)
                if w then break end
            end
        end
    end

    w = math.max(1, math.min(w or 1, Grid.columns))
    h = math.max(1, h or 1)
    sizeCache[name] = { w, h }

    return w, h
end

---Width and height an item takes up with the given rotation.
---@param name string
---@param rotated boolean?
---@return integer w, integer h
function Grid.footprint(name, rotated)
    local w, h = Grid.itemSize(name)

    if rotated then return h, w end

    return w, h
end

---Cells taken by the items in the grid part of an inventory.
---@param items table<integer, table>
---@param layout GridLayout
---@param ignore? table<integer, true> slots to leave out (the item being moved)
---@return table<integer, integer> occupied cell slot -> slot of the item covering it
function Grid.occupancy(items, layout, ignore)
    local occupied = {}

    for slot, item in pairs(items) do
        if item and item.name and not (ignore and ignore[slot]) and Grid.isCellOf(layout, slot) then
            Grid.mark(occupied, layout, slot, item.name, item.rotated)
        end
    end

    return occupied
end

---@param occupied table<integer, integer>
---@param layout GridLayout
---@param slot integer
---@param name string
---@param rotated boolean?
function Grid.mark(occupied, layout, slot, name, rotated)
    local w, h = Grid.footprint(name, rotated)
    local x0, y0 = Grid.coords(layout, slot)

    for dy = 0, h - 1 do
        for dx = 0, w - 1 do
            local x, y = x0 + dx, y0 + dy

            if x < layout.cols and y < layout.rows then
                occupied[layout.first + y * layout.cols + x] = slot
            end
        end
    end
end

---Whether a w x h footprint anchored at the slot stays inside the grid and only covers free cells.
---@param layout GridLayout
---@param occupied table<integer, integer>
---@param slot integer
---@param w integer
---@param h integer
function Grid.fits(layout, occupied, slot, w, h)
    if not Grid.isCellOf(layout, slot) then return false end

    local x0, y0 = Grid.coords(layout, slot)

    if x0 + w > layout.cols or y0 + h > layout.rows then return false end

    for dy = 0, h - 1 do
        for dx = 0, w - 1 do
            local cell = layout.first + (y0 + dy) * layout.cols + x0 + dx

            if cell > layout.last or occupied[cell] then return false end
        end
    end

    return true
end

---Whether an item can be anchored at the slot. Non-grid slots (hotbar, equipment, non-grid inventories)
---always pass; the caller still checks whether the slot itself is free.
---@param inv table inventory with type, slots and items
---@param slot integer
---@param name string
---@param rotated boolean?
---@param ignore? table<integer, true>
function Grid.canPlace(inv, slot, name, rotated, ignore)
    local layout = Grid.layoutOf(inv)

    if not layout or not Grid.isCellOf(layout, slot) then return true end

    local w, h = Grid.footprint(name, rotated)

    return Grid.fits(layout, Grid.occupancy(inv.items, layout, ignore), slot, w, h)
end

---First free spot for an item, trying it upright before rotated.
---@param layout GridLayout
---@param occupied table<integer, integer>
---@param name string
---@return integer? slot, boolean? rotated
function Grid.findIn(layout, occupied, name)
    local w, h = Grid.itemSize(name)

    for slot = layout.first, layout.last do
        if not occupied[slot] then
            if Grid.fits(layout, occupied, slot, w, h) then return slot, false end
            if w ~= h and Grid.fits(layout, occupied, slot, h, w) then return slot, true end
        end
    end
end

---First free grid spot for an item in an inventory.
---@param inv table
---@param name string
---@param ignore? table<integer, true>
---@return integer? slot, boolean? rotated
function Grid.findSpot(inv, name, ignore)
    local layout = Grid.layoutOf(inv)

    if not layout then return end

    return Grid.findIn(layout, Grid.occupancy(inv.items, layout, ignore), name)
end

---Whether two whole items can trade places. `fromItem` lands on `toSlot` of `toInv` with the rotation
---`rotate`; `toItem` lands on `fromSlot` of `fromInv` and keeps its own rotation.
---@return boolean
function Grid.canSwap(fromInv, fromSlot, fromItem, toInv, toSlot, toItem, rotate)
    if fromInv == toInv then
        local layout = Grid.layoutOf(toInv)

        if not layout then return true end

        local occupied = Grid.occupancy(toInv.items, layout, { [fromSlot] = true, [toSlot] = true })

        if Grid.isCellOf(layout, toSlot) then
            local w, h = Grid.footprint(fromItem.name, rotate)
            if not Grid.fits(layout, occupied, toSlot, w, h) then return false end
            Grid.mark(occupied, layout, toSlot, fromItem.name, rotate)
        end

        if Grid.isCellOf(layout, fromSlot) then
            local w, h = Grid.footprint(toItem.name, toItem.rotated)
            if not Grid.fits(layout, occupied, fromSlot, w, h) then return false end
        end

        return true
    end

    return Grid.canPlace(toInv, toSlot, fromItem.name, rotate, { [toSlot] = true })
        and Grid.canPlace(fromInv, fromSlot, toItem.name, toItem.rotated, { [fromSlot] = true })
end

---How many separate placements of an item still fit (up to `max`).
---@param inv table
---@param name string
---@param max integer
---@return integer
function Grid.freeSpots(inv, name, max)
    local layout = Grid.layoutOf(inv)

    if not layout then return max end

    local occupied = Grid.occupancy(inv.items, layout)
    local found = 0

    while found < max do
        local slot, rotated = Grid.findIn(layout, occupied, name)

        if not slot then break end

        Grid.mark(occupied, layout, slot, name, rotated)
        found += 1
    end

    return found
end

---Makes a freshly loaded inventory valid: every grid item inside the grid without overlaps.
---Items that don't fit where they were saved move to the first free spot; if there is none they stay
---where they are and a warning is printed.
---@param inv table inventory with id, type, slots and items
---@return boolean changed
function Grid.normalize(inv)
    local layout = Grid.layoutOf(inv)

    if not layout or not inv.items then return false end

    local slots = {}

    for slot, item in pairs(inv.items) do
        if item and item.name and Grid.isCellOf(layout, slot) then
            slots[#slots + 1] = slot
        end
    end

    table.sort(slots)

    local occupied, misplaced = {}, {}

    for i = 1, #slots do
        local slot = slots[i]
        local item = inv.items[slot]
        local w, h = Grid.footprint(item.name, item.rotated)

        if Grid.fits(layout, occupied, slot, w, h) then
            Grid.mark(occupied, layout, slot, item.name, item.rotated)
        else
            misplaced[#misplaced + 1] = slot
        end
    end

    local changed = false

    for i = 1, #misplaced do
        local oldSlot = misplaced[i]
        local item = inv.items[oldSlot]
        local slot, rotated = Grid.findIn(layout, occupied, item.name)

        if slot then
            inv.items[oldSlot] = nil
            item.slot = slot
            item.rotated = rotated or nil
            inv.items[slot] = item
            Grid.mark(occupied, layout, slot, item.name, rotated)
            changed = true
        else
            warn(('grid: no room for %sx %s in inventory %s, it overlaps slot %s'):format(item.count, item.name, inv.id, oldSlot))
        end
    end

    return changed
end

return Grid
