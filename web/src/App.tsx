import InventoryComponent from './components/inventory';
import useNuiEvent from './hooks/useNuiEvent';
import { Items } from './store/items';
import { Locale } from './store/locale';
import { setImagePath } from './store/imagepath';
import { setupInventory } from './store/inventory';
import { Inventory } from './typings';
import { useAppDispatch } from './store';
import { debugData } from './utils/debugData';
import { addDevCraftingItems, devCraftingBench } from './utils/devCrafting';
import DragPreview from './components/utils/DragPreview';
import { fetchNui } from './utils/fetchNui';
import { useDragDropManager } from 'react-dnd';
import KeyPress from './components/utils/KeyPress';
import { setUtility, UtilityConfig } from './store/utility';
import { GridConfig, setGrid } from './store/grid';
import { RarityConfig, setRarity } from './store/rarity';
import { devGridSetup } from './utils/devGrid';

debugData([
  {
    action: 'setupInventory',
    data: {
      leftInventory: {
        id: 'test',
        type: 'player',
        slots: 50,
        label: 'QuickOtter7579',
        weight: 3000,
        maxWeight: 75000,
        items: [
          { slot: 1, name: 'WEAPON_PISTOL', weight: 1200, count: 1, metadata: { durability: 82, ammo: 12 } },
          { slot: 3, name: 'tablet', weight: 20, count: 1 },
          { slot: 4, name: 'laptop', weight: 20, count: 1 },
          { slot: 6, name: 'bandage', weight: 3000, count: 15 },
          { slot: 7, name: 'ammo-9', weight: 518, count: 74 },
          { slot: 8, name: 'firstaid', weight: 6000, count: 6 },
          { slot: 9, name: 'painkillers', weight: 600, count: 12 },
          { slot: 10, name: 'water', weight: 4500, count: 15 },
          { slot: 11, name: 'sandwich', weight: 60, count: 3, metadata: { durability: 35 } },
          { slot: 12, name: 'sprunk', weight: 2000, count: 4, metadata: { durability: 12 } },
          { slot: 13, name: 'lockpick', weight: 2250, count: 15 },
          { slot: 16, name: 'veh_engine', weight: 50, count: 1 },
          { slot: 17, name: 'veh_turbo', weight: 22, count: 1 },
          { slot: 18, name: 'veh_suspension', weight: 5, count: 1 },
          {
            slot: 20,
            name: 'burger',
            weight: 100,
            count: 1,
            metadata: { description: 'Generic item description' },
          },
          { slot: 21, name: 'phone', weight: 190, count: 1 },
          { slot: 22, name: 'fabric', weight: 500, count: 7 },
          { slot: 23, name: 'rubber', weight: 200, count: 2 },
          { slot: 24, name: 'scrap_metal', weight: 900, count: 5 },
          { slot: 25, name: 'metal_parts', weight: 300, count: 1 },
          { slot: 26, name: 'plastic', weight: 100, count: 3 },
          { slot: 27, name: 'money', weight: 0, count: 2350 },
          {
            slot: 47,
            name: 'backpack',
            weight: 4200,
            count: 1,
            metadata: { container: 'dev-backpack', size: [20, 40000] },
          },
          { slot: 48, name: 'armour', weight: 3000, count: 1 },
          { slot: 50, name: 'parachute', weight: 800, count: 1 },
        ],
      },
      rightInventory: {
        id: 'glovebox',
        type: 'glovebox',
        slots: 5,
        label: 'Glovebox',
        weight: 1000,
        maxWeight: 10000,
        items: [{ slot: 2, name: 'water', weight: 1000, count: 2 }],
      },
      backpackInventory: {
        id: 'dev-backpack',
        type: 'container',
        slots: 20,
        label: 'Backpack',
        weight: 3200,
        maxWeight: 40000,
        items: [
          { slot: 1, name: 'water', weight: 1500, count: 3 },
          { slot: 2, name: 'bandage', weight: 1000, count: 5 },
          { slot: 3, name: 'lockpick', weight: 700, count: 2 },
        ],
      },
    },
  },
]);

// browser preview: ?right=shop opens a dev shop on the right
if (typeof window !== 'undefined' && new URLSearchParams(window.location.search).get('right') === 'shop') {
  const labels: Record<string, string> = {
    chicken_taco: 'Chicken Taco',
    chocolate_muffin: 'Muffin',
    bootbeer_can: 'Root Beer',
    tortilla_chips: 'Tortilla Chips',
    lighter: 'Lighter',
    repair_kit: 'Repair Kit',
    black_money: 'Marked Bills',
  };
  for (const [name, label] of Object.entries(labels))
    Items[name] = { name, label, stack: true, usable: false, close: true, count: 0 };
  debugData([
    {
      action: 'setupInventory',
      data: {
        rightInventory: {
          id: 'dev-shop',
          type: 'shop',
          slots: 12,
          label: '24/7 Supermarket',
          items: [
            { slot: 1, name: 'chicken_taco', weight: 220, count: 24, price: 15 },
            { slot: 2, name: 'chocolate_muffin', weight: 200, price: 12 },
            { slot: 3, name: 'bootbeer_can', weight: 350, price: 8 },
            { slot: 4, name: 'tortilla_chips', weight: 150, count: 6, price: 6 },
            { slot: 5, name: 'bandage', weight: 115, price: 45 },
            { slot: 6, name: 'firstaid', weight: 600, count: 3, price: 350 },
            { slot: 7, name: 'lighter', weight: 50, price: 20 },
            { slot: 8, name: 'lockpick', weight: 160, count: 0, price: 250 },
            { slot: 9, name: 'phone', weight: 190, price: 850 },
            { slot: 10, name: 'radio', weight: 300, price: 1250 },
            { slot: 11, name: 'parachute', weight: 800, price: 2400 },
            { slot: 12, name: 'repair_kit', weight: 1500, price: 40, currency: 'black_money' },
          ],
        },
      },
    },
  ]);
}

// browser preview: ?right=crafting opens a dev crafting bench (CraftingStation) on the right
if (import.meta.env.DEV && new URLSearchParams(window.location.search).get('right') === 'crafting') {
  addDevCraftingItems();
  debugData([{ action: 'setupInventory', data: { rightInventory: devCraftingBench } }]);
}

// browser preview: rarity examples, and ?grid=1 for the grid inventory
devGridSetup();

const App: React.FC = () => {
  const dispatch = useAppDispatch();
  const manager = useDragDropManager();

  useNuiEvent<{
    locale: { [key: string]: string };
    items: typeof Items;
    leftInventory: Inventory;
    imagepath: string;
    utility?: Partial<UtilityConfig>;
    grid?: Partial<GridConfig>;
    rarity?: Partial<RarityConfig>;
  }>('init', ({ locale, items, leftInventory, imagepath, utility, grid, rarity }) => {
    for (const name in locale) Locale[name] = locale[name];
    for (const name in items) Items[name] = items[name];

    setUtility(utility);
    setGrid(grid);
    setRarity(rarity);

    setImagePath(imagepath);
    dispatch(setupInventory({ leftInventory }));
  });

  fetchNui('uiLoaded', {});

  useNuiEvent('closeInventory', () => {
    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  return (
    <div className="app-wrapper">
      <InventoryComponent />
      <DragPreview />
      <KeyPress />
    </div>
  );
};

addEventListener('dragstart', function (event) {
  event.preventDefault();
});

export default App;
