import React, { useEffect, useMemo, useState } from 'react';
import { Clock, Hammer, Package, Search, X } from 'lucide-react';
import { useAppSelector } from '../../store';
import { selectRightInventory } from '../../store/inventory';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { isEnvBrowser } from '../../utils/misc';
import PanelHeading from './PanelHeading';
import {
  CraftActions,
  craftable,
  IngredientRows,
  kilos,
  MAX_BATCH,
  recipeLabel,
  seconds,
  slotToRecipe,
  useCraftProgress,
  usePocketCounts,
} from './craftingShared';

// World crafting bench (right inventory type 'crafting'): a recipe list beside the picked recipe, spanning
// the centre and right columns. Crafting goes through the 'craftBench' NUI callback in client.lua.
const CraftingStation: React.FC = () => {
  const bench = useAppSelector(selectRightInventory);
  const counts = usePocketCounts();
  const [query, setQuery] = useState('');
  const [selected, setSelected] = useState<number | null>(null);
  const [amount, setAmount] = useState(1);
  const { busy, progress, current, itemPercent, run } = useCraftProgress();

  const recipes = useMemo(
    () =>
      bench.type === 'crafting'
        ? bench.items.map(slotToRecipe).filter((recipe): recipe is NonNullable<typeof recipe> => !!recipe)
        : [],
    [bench.type, bench.items]
  );

  const shown = useMemo(() => {
    const term = query.trim().toLowerCase();
    if (!term) return recipes;
    return recipes.filter(
      (recipe) => recipeLabel(recipe).toLowerCase().includes(term) || recipe.name.toLowerCase().includes(term)
    );
  }, [recipes, query]);

  const readyCount = recipes.filter((recipe) => craftable(recipe, counts) > 0).length;
  // a search that hides the picked recipe moves to the first match; no match keeps the pick
  const recipe =
    shown.find((entry) => entry.slot === selected) ??
    shown[0] ??
    recipes.find((entry) => entry.slot === selected) ??
    recipes[0];
  const max = recipe ? craftable(recipe, counts) : 0;

  // a different bench starts on its first recipe
  useEffect(() => {
    setSelected(null);
    setQuery('');
  }, [bench.id]);

  useEffect(() => setAmount(1), [recipe?.slot]);

  if (bench.type !== 'crafting') return null;

  const craft = () => {
    if (!recipe || busy || max < 1) return;
    const count = Math.min(amount, max, MAX_BATCH);
    run(recipe, count, () =>
      isEnvBrowser()
        ? new Promise((resolve) => setTimeout(resolve, recipe.duration * count))
        : fetchNui<number | false>('craftBench', { recipe: recipe.slot, count })
    );
  };

  const description = recipe?.metadata?.description;

  return (
    <div className="crafting-station">
      <div className="panel-header">
        <PanelHeading
          icon={Hammer}
          title={bench.label || Locale.ui_crafting_bench || 'Crafting bench'}
          subtitle={Locale.ui_crafting_bench || 'Crafting bench'}
          aside={
            recipes.length > 0 && (
              <span className="station-ready">
                <b>{readyCount}</b>/{recipes.length} {Locale.ui_ready || 'Ready'}
              </span>
            )
          }
        />
      </div>

      <div className="station-body">
        <section className="station-list">
          <label className="station-search">
            <Search />
            <input
              value={query}
              onChange={(event) => setQuery(event.target.value)}
              placeholder={Locale.ui_search || 'Search'}
              spellCheck={false}
            />
            {query && (
              <button onClick={() => setQuery('')} aria-label="Clear">
                <X />
              </button>
            )}
          </label>

          <div className="station-recipes">
            {shown.map((entry) => {
              const ready = craftable(entry, counts) > 0;
              const crafting = progress?.slot === entry.slot;
              return (
                <button
                  key={entry.slot}
                  className={`station-recipe${entry.slot === recipe?.slot ? ' active' : ''}${ready ? ' ready' : ''}`}
                  onClick={() => setSelected(entry.slot)}
                >
                  <span className="station-thumb" style={{ backgroundImage: `url(${getItemUrl(entry.name)})` }} />
                  <span className="station-recipe-text">
                    <span className="station-recipe-name">{recipeLabel(entry)}</span>
                    <span className="station-recipe-meta">
                      <span>
                        <Package />
                        {entry.count}x
                      </span>
                      <span>
                        <Clock />
                        {seconds(entry.duration)}
                      </span>
                    </span>
                  </span>
                  <span className={`state-tag ${ready ? 'ok' : 'missing'}`}>
                    {ready ? Locale.ui_ready || 'Ready' : Locale.ui_missing || 'Missing'}
                  </span>
                  {crafting && <span className="station-recipe-bar" style={{ width: `${itemPercent}%` }} />}
                </button>
              );
            })}
            {recipes.length === 0 && <p className="empty-note">{Locale.ui_no_recipes || 'No recipes'}</p>}
            {recipes.length > 0 && shown.length === 0 && (
              <p className="empty-note">{Locale.ui_no_match || 'Nothing found'}</p>
            )}
          </div>
        </section>

        {recipe ? (
          <section className="station-detail">
            <div className="station-hero">
              <div className="station-hero-image" style={{ backgroundImage: `url(${getItemUrl(recipe.name)})` }} />
              <div className="station-hero-text">
                <p className="station-hero-name">{recipeLabel(recipe)}</p>
                <div className="station-stats">
                  <div className="station-stat">
                    <span>{Locale.ui_makes || 'Makes'}</span>
                    <b>{recipe.count}x</b>
                  </div>
                  <div className="station-stat">
                    <span>{Locale.ui_time || 'Time'}</span>
                    <b>{seconds(recipe.duration)}</b>
                  </div>
                  {typeof recipe.weight === 'number' && recipe.weight > 0 && (
                    <div className="station-stat">
                      <span>{Locale.ui_weight || 'Weight'}</span>
                      <b>{kilos(recipe.weight * recipe.count)}</b>
                    </div>
                  )}
                </div>
              </div>
            </div>

            {description && <p className="station-desc">{description}</p>}

            <p className="section-label station-label">
              {Locale.ui_ingredients || 'Ingredients'}
              <span>{max > 0 ? `${Locale.ui_can_make || 'Can make'} ${max}` : Locale.ui_missing || 'Missing'}</span>
            </p>

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
          </section>
        ) : (
          <section className="station-detail station-empty">
            <Hammer />
            <p>{Locale.ui_no_recipes || 'No recipes'}</p>
          </section>
        )}
      </div>
    </div>
  );
};

export default CraftingStation;
