import React from 'react';
import {
  Archive,
  Backpack,
  Car,
  Hammer,
  LayoutGrid,
  LucideIcon,
  MapPin,
  Package,
  ShieldCheck,
  Store,
  Trash2,
  User,
  Warehouse,
} from 'lucide-react';

// header icon per inventory type, like the atleastv4 panel icon tiles
const TYPE_ICONS: Record<string, LucideIcon> = {
  player: LayoutGrid,
  otherplayer: User,
  container: Backpack,
  drop: MapPin,
  newdrop: MapPin,
  trunk: Car,
  glovebox: Archive,
  stash: Warehouse,
  shop: Store,
  crafting: Hammer,
  policeevidence: ShieldCheck,
  dumpster: Trash2,
};

export const iconForType = (type: string): LucideIcon => TYPE_ICONS[type] ?? Package;

interface Props {
  icon: LucideIcon;
  title: React.ReactNode;
  subtitle?: React.ReactNode;
  // right-aligned extra, e.g. the weight readout
  aside?: React.ReactNode;
}

const PanelHeading: React.FC<Props> = ({ icon: Icon, title, subtitle, aside }) => (
  <div className="panel-heading">
    <div className="panel-icon">
      <Icon size={18} strokeWidth={1.75} />
    </div>
    <div className="panel-heading-text">
      <p className="panel-title">{title}</p>
      {subtitle ? <p className="panel-subtitle">{subtitle}</p> : null}
    </div>
    {aside}
  </div>
);

export default PanelHeading;
