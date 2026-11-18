import React, { useEffect, useMemo, useState } from 'react';
import { Check, Hammer, Minus, Plus, X } from 'lucide-react';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { getItemUrl, isSlotWithItem } from '../../helpers';
import type { Slot } from '../../typings';

// Shared by the personal Crafting tab and the world bench station view

export interface Recipe {
  slot: number;
  name: string;
  count: number;
  ingredients: Record<string, number>;
  duration: number;
  weight?: number;
  metadata?: { label?: string; description?: string; [key: string]: any };
}

// the client crafts at most this many in one go (client.lua clamps count to 50)
export const MAX_BATCH = 50;

export const labelOf = (name: string) => Items[name]?.label || name;
export const recipeLabel = (recipe: Recipe) => recipe.metadata?.label || labelOf(recipe.name);
export const seconds = (ms: number) => `${(ms / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })}s`;
export const kilos = (grams: number) => `${(grams / 1000).toLocaleString('en-us', { maximumFractionDigits: 2 })}kg`;

// a bench slot sent by the client (data/crafting.lua item) as a recipe, or null for an empty slot
export const slotToRecipe = (slot: Slot, index: number): Recipe | null => {
  const entry = slot as Slot & Partial<Recipe>;
  if (!entry.name || !entry.ingredients) return null;

  return {
    slot: entry.slot ?? index + 1,
    name: entry.name,
    count: typeof entry.count === 'number' && entry.count > 0 ? entry.count : 1,
    ingredients: entry.ingredients,
    duration: typeof entry.duration === 'number' ? entry.duration : 3000,
    weight: entry.weight,
    metadata: entry.metadata,
  };
};

// how many of each item the pockets hold (the server only takes ingredients from the pockets)
export const usePocketCounts = () => {
  const pockets = useAppSelector(selectLeftInventory);

  return useMemo(() => {
    const counts: Record<string, number> = {};
    for (const slot of pockets.items) {
      if (!isSlotWithItem(slot)) continue;
      counts[slot.name] = (counts[slot.name] || 0) + (slot.count || 1);
    }
    return counts;
  }, [pockets.items]);
};

// times the recipe can be made from what is carried; tools (need < 1) only have to be present
export const craftable = (recipe: Recipe, counts: Record<string, number>) => {
  let max = Infinity;
  for (const [name, need] of Object.entries(recipe.ingredients)) {
    const have = counts[name] || 0;
    if (need < 1) {
      if (have < 1) return 0;
      continue;
    }
    max = Math.min(max, Math.floor(have / need));
  }
  return max === Infinity ? 1 : max;
};

// Runs a batch and tracks which item of it is being made and how far along it is, for the craft button
export const useCraftProgress = () => {
  const [progress, setProgress] = useState<{ start: number; duration: number; count: number; slot: number } | null>(
    null
  );
  const [now, setNow] = useState(0);

  useEffect(() => {
    if (!progress) return;
    const timer = setInterval(() => setNow(Date.now()), 50);
    return () => clearInterval(timer);
  }, [progress]);

  const run = async (recipe: Recipe, count: number, request: () => Promise<unknown>) => {
    if (progress) return;
    setNow(Date.now());
    setProgress({ start: Date.now(), duration: recipe.duration, count, slot: recipe.slot });
    try {
      await request();
    } finally {
      setProgress(null);
    }
  };

  const elapsed = progress ? Math.max(0, now - progress.start) : 0;
  const current = progress ? Math.min(progress.count, Math.floor(elapsed / progress.duration) + 1) : 0;
  const itemPercent = progress
    ? current >= progress.count && elapsed >= progress.duration * progress.count
      ? 100
      : ((elapsed % progress.duration) / progress.duration) * 100
    : 0;

  return { busy: !!progress, progress, current, itemPercent, run };
};

export const IngredientRows: React.FC<{
  recipe: Recipe;
  counts: Record<string, number>;
  amount: number;
  max: number;
}> = ({ recipe, counts, amount, max }) => (
  <>
    {Object.entries(recipe.ingredients).map(([name, need]) => {
      const have = counts[name] || 0;
      const tool = need < 1;
      const total = tool ? 1 : need * Math.max(1, Math.min(amount, Math.max(max, 1)));
      const enough = tool ? have > 0 : have >= total;
      return (
        <div key={name} className={`ingredient-row${enough ? '' : ' short'}`}>
          <span className="ingredient-thumb" style={{ backgroundImage: `url(${getItemUrl(name)})` }} />
          <span className="ingredient-name">{labelOf(name)}</span>
          <span className="ingredient-count">
            {tool ? (
              Locale.ui_tool || 'Tool'
            ) : (
              <>
                <b>{have}</b>/{total}
              </>
            )}
          </span>
          <span className="ingredient-state">{enough ? <Check /> : <X />}</span>
        </div>
      );
    })}
  </>
);

export const CraftActions: React.FC<{
  amount: number;
  setAmount: React.Dispatch<React.SetStateAction<number>>;
  max: number;
  busy: boolean;
  progress: { count: number } | null;
  current: number;
  itemPercent: number;
  onCraft: () => void;
}> = ({ amount, setAmount, max, busy, progress, current, itemPercent, onCraft }) => {
  const limit = Math.min(Math.max(max, 1), MAX_BATCH);

  return (
    <div className="craft-actions">
      <div className="stepper">
        <button onClick={() => setAmount((n) => Math.max(1, n - 1))} disabled={amount <= 1}>
          <Minus />
        </button>
        <span>{amount}</span>
        <button onClick={() => setAmount((n) => Math.min(limit, n + 1))} disabled={amount >= Math.min(max, MAX_BATCH)}>
          <Plus />
        </button>
      </div>
      <button className={`craft-button${busy ? ' busy' : ''}`} disabled={busy || max < 1} onClick={onCraft}>
        {busy && <span className="craft-fill" style={{ width: `${itemPercent}%` }} />}
        <span className="craft-label">
          <Hammer />
          {busy ? Locale.ui_crafting_busy || 'Crafting' : Locale.ui_craft || 'Craft'}
          {busy && progress && progress.count > 1 && (
            <em>
              {current}/{progress.count}
            </em>
          )}
          {busy && <b>{Math.floor(itemPercent)}%</b>}
        </span>
      </button>
    </div>
  );
};
