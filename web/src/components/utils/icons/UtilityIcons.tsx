import React from 'react';
import { Backpack, Crosshair, Keyboard, LucideIcon, Package, Shield, Smartphone, Umbrella } from 'lucide-react';

const icons: Record<string, LucideIcon> = {
  backpack: Backpack,
  armor: Shield,
  phone: Smartphone,
  parachute: Umbrella,
  weapon: Crosshair,
  hotkey: Keyboard,
};

const UtilityIcon: React.FC<{ kind: string; className?: string }> = ({ kind, className }) => {
  const Icon = icons[kind] ?? Package;

  return <Icon className={className} strokeWidth={1.5} />;
};

export default UtilityIcon;
