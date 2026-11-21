// Optional item rarity (data/rarity.lua). Slots get a solid tinted fill and border pre-mixed from the
// tier colour, so nothing turns see-through over the game.
import type React from 'react';
import { Items } from './items';

export interface RarityTier {
  id: string;
  label: string;
  color: string;
  // false: no slot tint (common), only the tooltip badge
  tint?: boolean;
}

export interface RarityConfig {
  enabled: boolean;
  tiers: RarityTier[];
}

const devParams = typeof window !== 'undefined' ? new URLSearchParams(window.location.search) : null;

// browser preview defaults match data/rarity.lua; ?rarity=0 turns it off
export const Rarity: RarityConfig = {
  enabled: devParams?.get('rarity') !== '0',
  tiers: [
    { id: 'common', label: 'Common', color: '#909296', tint: false },
    { id: 'uncommon', label: 'Uncommon', color: '#69db7c' },
    { id: 'rare', label: 'Rare', color: '#4dabf7' },
    { id: 'epic', label: 'Epic', color: '#9775fa' },
    { id: 'legendary', label: 'Legendary', color: '#ffa94d' },
  ],
};

export const setRarity = (config?: Partial<RarityConfig>) => {
  if (!config) return;
  Rarity.enabled = config.enabled === true;
  // lua sends an empty table as an object
  if (Array.isArray(config.tiers)) Rarity.tiers = config.tiers;
};

const hex = (color: string) => {
  const value = color.replace('#', '');
  const full = value.length === 3 ? value.replace(/./g, (c) => c + c) : value;
  return [0, 2, 4].map((i) => parseInt(full.slice(i, i + 2), 16) || 0);
};

// solid colour: `amount` of `color` over `base`
const mix = (color: string, base: string, amount: number) => {
  const a = hex(color);
  const b = hex(base);
  return `#${a.map((v, i) => Math.round(v * amount + b[i] * (1 - amount)).toString(16).padStart(2, '0')).join('')}`;
};

// filled slot colour in index.scss ($headerBg)
const SLOT_BG = '#26272c';
const TOOLTIP_BG = '#2c2e33';

export interface RarityStyle {
  tier: RarityTier;
  // CSS custom properties read by .rarity in index.scss
  vars: React.CSSProperties;
  tinted: boolean;
}

const cache = new Map<string, RarityStyle>();

const styleOf = (tier: RarityTier): RarityStyle => {
  let style = cache.get(tier.id + tier.color);

  if (!style) {
    style = {
      tier,
      tinted: tier.tint !== false,
      vars: {
        '--rarity': tier.color,
        '--rarity-bg': mix(tier.color, SLOT_BG, 0.12),
        '--rarity-bg-hover': mix(tier.color, SLOT_BG, 0.18),
        '--rarity-border': mix(tier.color, SLOT_BG, 0.45),
        '--rarity-badge-bg': mix(tier.color, TOOLTIP_BG, 0.14),
        '--rarity-badge-border': mix(tier.color, TOOLTIP_BG, 0.35),
      } as React.CSSProperties,
    };
    cache.set(tier.id + tier.color, style);
  }

  return style;
};

// metadata.rarity beats the item's own rarity
export const getRarity = (item?: { name?: string; metadata?: Record<string, any> }): RarityStyle | null => {
  if (!Rarity.enabled || !item?.name) return null;

  const id = item.metadata?.rarity ?? Items[item.name]?.rarity;

  if (!id || typeof id !== 'string') return null;

  const tier = Rarity.tiers.find((entry) => entry.id === id.toLowerCase());

  return tier ? styleOf(tier) : null;
};
