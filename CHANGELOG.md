# Changelog

## 1.3.0 (2026-11-21)

### Added

- Optional clothing as items in `data/clothing.lua`, off by default. The new Clothing tab next to Inventory shows the character with squares for the hat, glasses, ears, mask, chain, watch, shirt, undershirt, gloves, pants, shoes and bracelet. Whatever is in a square is what the character wears.
- `clothing_item` in `data/items.lua`, using the rm-appearance item format, so clothing items from either resource work in both.
- Client exports `syncClothingFromPed`, `applyClothing` and `pauseClothing`, plus a README guide with the illenium-appearance edits.
- The clothes a character is wearing become items the first time they load with clothing turned on.

### Changed

- Grid sizes also read `width` and `height` fields on item definitions.

## 1.2.0 (2026-11-21)

### Added

- Optional Tarkov-style grid inventory in `data/grid.lua`, off by default. Items take up width x height cells, can be dropped anywhere they fit and turn with R while dragging or while hovering. Positions and rotation are saved on the server and checked on every move, swap, stack, split, purchase and craft.
- Default grid sizes for every weapon group, armour, bags and a few large items, which you can change per item with `size = { w, h }` or in `data/grid.lua`.
- Optional item rarity in `data/rarity.lua`, on by default. Tiers come from item metadata, the item definition or a central table, and show as a tinted slot, a coloured name and a tier badge.
- `GetEmptySlot` takes an optional item name and returns whether the item has to be turned to fit.

### Changed

- New hover tooltip: a header with the item picture, name and type, tier and size tags, the description, and a stat list with a durability bar.

## 1.1.0 (2026-11-18)

### Added

- Health tab support for qbx_medical, the medical resource that ships with Qbox. The tab now works on a plain Qbox server without any extra resource.
- `tabs` option in `data/utility.lua` to turn the Crafting tab, the Health tab or both off. With both off, the top bar is hidden and the inventory opens straight to the three columns.
- `medical` option in `data/utility.lua` to pick where the Health tab reads injuries from: `'auto'`, `'qbx_medical'` or `'rm-medical'`.
- Server check that refuses personal bench crafting when the Crafting tab is turned off.

### Changed

- The Health tab shows a player in last stand or dead under qbx_medical as Unresponsive.
- Q and E only step through the tabs that are turned on.
- README thumbnail at the top of the page.

## 1.0.0 (2026-11-18)

First release of the redesigned ox_inventory for Qbox, based on ox_inventory 2.48.1.

### Added

- Three-column layout with Inventory, Crafting and Health tabs, switched with Q and E.
- Equipment slots for a backpack, armour, phone and parachute, plus weapon-only hotkey slots.
- Worn backpacks with a prop on the player.
- Vest armour stored as item durability.
- Personal crafting from the Crafting tab and a new crafting station view for world benches.
- Shop view with a basket and Cash or Card payment through the qbx_core bank.
