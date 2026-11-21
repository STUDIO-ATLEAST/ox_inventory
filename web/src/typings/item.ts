export type ItemData = {
  name: string;
  label: string;
  stack: boolean;
  usable: boolean;
  close: boolean;
  count: number;
  description?: string;
  buttons?: string[];
  ammoName?: string;
  image?: string;
  // data/rarity.lua tier id
  rarity?: string;
  // data/grid.lua cells, width x height
  size?: [number, number];
};
