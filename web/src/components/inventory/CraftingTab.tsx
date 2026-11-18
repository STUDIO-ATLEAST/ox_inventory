import React, { useEffect, useState } from 'react';
import { Clock, Hammer } from 'lucide-react';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { isEnvBrowser } from '../../utils/misc';
import PanelHeading from './PanelHeading';
import {
  CraftActions,
  craftable,
  IngredientRows,
  MAX_BATCH,
  Recipe,
  recipeLabel,
  seconds,
  useCraftProgress,
  usePocketCounts,
} from './craftingShared';

export type { Recipe } from './craftingShared';

// browser preview only, the game sends data/crafting.lua's 'personal' bench
const DEV_RECIPES: Recipe[] = [
  { slot: 1, name: 'bandage', count: 2, ingredients: { fabric: 2 }, duration: 3000 },
  { slot: 2, name: 'gauze', count: 2, ingredients: { fabric: 3 }, duration: 3500 },
  { slot: 3, name: 'tourniquet', count: 1, ingredients: { fabric: 1, rubber: 1 }, duration: 4000 },
  { slot: 4, name: 'splint', count: 1, ingredients: { wood_planks: 2, duct_tape: 1 }, duration: 5000 },
  { slot: 5, name: 'lockpick', count: 2, ingredients: { scrap_metal: 2, metal_parts: 1 }, duration: 5000 },
  {
    slot: 6,
    name: 'advancedlockpick',
    count: 1,
    ingredients: { lockpick: 1, metal_parts: 2, plastic: 1 },
    duration: 7000,
  },
  {
    slot: 7,
    name: 'radio',
    count: 1,
    ingredients: { electronic_parts: 2, plastic: 2, copper_coil: 1 },
    duration: 8000,
  },
];

const CraftingTab: React.FC = () => {
  const [recipes, setRecipes] = useState<Recipe[]>([]);
  const [selected, setSelected] = useState(1);
  const [amount, setAmount] = useState(1);
  const { busy, progress, current, itemPercent, run } = useCraftProgress();
  const counts = usePocketCounts();

  useEffect(() => {
    if (isEnvBrowser()) return setRecipes(DEV_RECIPES);
    fetchNui<Recipe[]>('getCrafting')
      .then((list) => setRecipes(Array.isArray(list) ? list : []))
      .catch(() => setRecipes([]));
  }, []);

  const recipe = recipes.find((entry) => entry.slot === selected) ?? recipes[0];
  const max = recipe ? craftable(recipe, counts) : 0;

  useEffect(() => setAmount(1), [selected]);

  const craft = () => {
    if (!recipe || busy || max < 1) return;
    const count = Math.min(amount, max, MAX_BATCH);
    run(recipe, count, () =>
      isEnvBrowser()
        ? new Promise((resolve) => setTimeout(resolve, recipe.duration * count))
        : fetchNui('craftPersonal', { recipe: recipe.slot, count })
    );
  };

  return (
    <div className="tab-panel">
      <div className="panel-header">
        <PanelHeading
          icon={Hammer}
          title={Locale.ui_crafting || 'Crafting'}
          subtitle={Locale.ui_crafting_subtitle || 'Made from what is in your pockets'}
        />
      </div>

      <div className="recipe-grid">
        {recipes.map((entry) => {
          const ready = craftable(entry, counts) > 0;
          return (
            <button
              key={entry.slot}
              className={`recipe-tile${entry.slot === recipe?.slot ? ' active' : ''}${ready ? ' ready' : ''}`}
              style={{ backgroundImage: `url(${getItemUrl(entry.name)})` }}
              onClick={() => setSelected(entry.slot)}
            >
              <span className="recipe-tile-top">
                <span>{entry.count}x</span>
                <i />
              </span>
              <span className="recipe-tile-label">{recipeLabel(entry)}</span>
            </button>
          );
        })}
        {recipes.length === 0 && <p className="empty-note">{Locale.ui_no_recipes || 'No recipes'}</p>}
      </div>

      {recipe && (
        <div className="recipe-detail">
          <div className="recipe-hero">
            <div className="recipe-hero-image" style={{ backgroundImage: `url(${getItemUrl(recipe.name)})` }} />
            <div className="recipe-hero-text">
              <p className="recipe-hero-name">{recipeLabel(recipe)}</p>
              <p className="recipe-hero-yield">
                {Locale.ui_makes || 'Makes'} <b>{recipe.count}x</b>
              </p>
              <p className="recipe-hero-time">
                <Clock />
                {seconds(recipe.duration)}
              </p>
            </div>
          </div>

          <div className="ingredient-list">
            <IngredientRows recipe={recipe} counts={counts} amount={amount} max={max} />
          </div>

          <CraftActions
            amount={amount}
            setAmount={setAmount}
            max={max}
            busy={busy}
            progress={progress}
            current={current}
            itemPercent={itemPercent}
            onCraft={craft}
          />
        </div>
      )}
    </div>
  );
};

export default CraftingTab;
