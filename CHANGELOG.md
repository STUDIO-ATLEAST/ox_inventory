# Changelog

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
