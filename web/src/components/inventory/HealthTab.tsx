import React, { useEffect, useState } from 'react';
import { HeartPulse, ShieldCheck } from 'lucide-react';
import BodySvg from '../utils/BodySvg';
import PanelHeading from './PanelHeading';
import { Locale } from '../../store/locale';
import { getItemUrl } from '../../helpers';
import { fetchNui } from '../../utils/fetchNui';
import { isEnvBrowser } from '../../utils/misc';

interface Injury {
  id: string;
  label: string;
  severity: number;
  kind?: string;
  wound?: string;
  bleeding?: boolean;
  after?: string;
  item?: string;
  itemLabel?: string;
}

interface Health {
  health: number;
  armour: number;
  hunger: number;
  thirst: number;
  stress: number;
  down: boolean;
  // false when rm-medical is not running
  injuries: Injury[] | false;
}

// browser preview only
const DEV_HEALTH: Health = {
  health: 64,
  armour: 38,
  hunger: 72,
  thirst: 41,
  stress: 18,
  down: false,
  injuries: [
    { id: 'head', label: 'Head', severity: 1, kind: 'trauma', wound: 'Bruising / impact injury', item: 'firstaid', itemLabel: 'First aid kit' },
    { id: 'chest', label: 'Chest', severity: 0 },
    { id: 'abdomen', label: 'Abdomen', severity: 0 },
    { id: 'left_arm', label: 'Left arm', severity: 3, kind: 'bleeding', wound: 'Heavy bleeding (limb)', bleeding: true, after: 'Gunshot wound', item: 'tourniquet', itemLabel: 'Tourniquet' },
    { id: 'right_arm', label: 'Right arm', severity: 0 },
    { id: 'left_leg', label: 'Left leg', severity: 0 },
    { id: 'right_leg', label: 'Right leg', severity: 2, kind: 'fracture', wound: 'Broken bone', item: 'splint', itemLabel: 'Splint' },
  ],
};

// marker spots on BodySvg, in its viewBox units; the figure faces the viewer, so "left" sits on the right
const SPOTS: Record<string, [number, number]> = {
  head: [103, 9],
  chest: [103, 46],
  abdomen: [103, 76],
  right_arm: [71, 78],
  left_arm: [135, 78],
  right_leg: [92, 160],
  left_leg: [114, 160],
};

const SEVERITY = ['', 'Minor', 'Moderate', 'Severe'];

// callout side per part; the rest go by which half of the figure they sit on
const SIDE: Record<string, 'left' | 'right'> = { head: 'left', chest: 'right', abdomen: 'left' };
const LABEL_X = { left: 44, right: 162 };
const LABEL_GAP = 17;

interface Callout {
  part: Injury;
  spot: [number, number];
  side: 'left' | 'right';
  y: number;
}

// one label per injured part beside the figure, pushed apart so they never overlap
const layoutCallouts = (parts: Injury[]): Callout[] => {
  const result: Callout[] = [];
  for (const side of ['left', 'right'] as const) {
    let last = -Infinity;
    parts
      .filter((part) => part.severity > 0 && SPOTS[part.id])
      .filter((part) => (SIDE[part.id] ?? (SPOTS[part.id][0] < 103 ? 'left' : 'right')) === side)
      .sort((a, b) => SPOTS[a.id][1] - SPOTS[b.id][1])
      .forEach((part) => {
        const spot = SPOTS[part.id];
        const y = Math.max(spot[1], last + LABEL_GAP);
        last = y;
        result.push({ part, spot, side, y });
      });
  }
  return result;
};

const HealthTab: React.FC = () => {
  const [data, setData] = useState<Health | null>(null);
  const [hover, setHover] = useState<string | null>(null);

  useEffect(() => {
    let alive = true;
    const load = () => {
      if (isEnvBrowser()) return setData(DEV_HEALTH);
      fetchNui<Health>('getHealth')
        .then((result) => alive && result && setData(result))
        .catch(() => {});
    };
    load();
    const timer = setInterval(load, 2000);
    return () => {
      alive = false;
      clearInterval(timer);
    };
  }, []);

  const parts = data && Array.isArray(data.injuries) ? data.injuries : [];
  const injured = parts.filter((part) => part.severity > 0).sort((a, b) => b.severity - a.severity);
  const status = !data
    ? ''
    : data.down
      ? Locale.ui_health_down || 'Unresponsive'
      : injured.length
        ? `${injured.length} ${injured.length === 1 ? Locale.ui_injury || 'injury' : Locale.ui_injuries || 'injuries'}`
        : Locale.ui_health_stable || 'Stable';

  return (
    <div className="tab-panel">
      <div className="panel-header">
        <PanelHeading icon={HeartPulse} title={Locale.ui_health || 'Health'} subtitle={status} />
      </div>

      <div className="health-stage">
        <div className="character-grid" />
        <BodySvg className="health-body">
          {parts.map((part) => {
            const spot = SPOTS[part.id];
            if (!spot) return null;
            const size = part.severity > 0 ? 9 : 5;
            const tone = part.bleeding ? 'bleed' : `sev-${part.severity}`;
            return (
              <g
                key={part.id}
                className={`body-marker ${tone}${hover === part.id ? ' hover' : ''}`}
                onMouseEnter={() => setHover(part.id)}
                onMouseLeave={() => setHover(null)}
              >
                {part.bleeding && (
                  <rect className="body-marker-pulse" x={spot[0] - 8} y={spot[1] - 8} width={16} height={16} rx={1.5} />
                )}
                <rect x={spot[0] - size / 2} y={spot[1] - size / 2} width={size} height={size} rx={1} />
              </g>
            );
          })}
          {layoutCallouts(parts).map(({ part, spot, side, y }) => {
            const x = LABEL_X[side];
            const tone = part.bleeding ? 'bleed' : `sev-${part.severity}`;
            const anchor = side === 'left' ? 'end' : 'start';
            const edge = side === 'left' ? x + 3 : x - 3;
            return (
              <g key={`callout-${part.id}`} className={`body-callout ${tone}${hover === part.id ? ' hover' : ''}`}>
                <polyline points={`${spot[0]},${spot[1]} ${edge},${y} ${edge + (side === 'left' ? -1 : 1)},${y}`} />
                <text x={x} y={y - 1} textAnchor={anchor} className="callout-part">
                  {part.label}
                </text>
                <text x={x} y={y + 5.5} textAnchor={anchor} className="callout-wound">
                  {part.bleeding ? Locale.ui_bleeding || 'Bleeding' : SEVERITY[part.severity]}
                </text>
              </g>
            );
          })}
        </BodySvg>
        {hover && (
          <div className="health-hover">
            {parts.find((part) => part.id === hover)?.label}
            <span>{parts.find((part) => part.id === hover)?.wound || Locale.ui_no_injury || 'No injury'}</span>
          </div>
        )}
        <div className="health-legend">
          {[1, 2, 3].map((level) => (
            <span key={level} className={`legend sev-${level}`}>
              <i />
              {SEVERITY[level]}
            </span>
          ))}
          <span className="legend bleed">
            <i />
            {Locale.ui_bleeding || 'Bleeding'}
          </span>
        </div>
      </div>

      <div className="injury-list">
        {data && data.injuries === false && (
          <p className="empty-note">{Locale.ui_no_medical || 'Injury tracking is not available'}</p>
        )}
        {data && data.injuries !== false && injured.length === 0 && (
          <div className="injury-empty">
            <ShieldCheck />
            {Locale.ui_no_injuries || 'No injuries recorded'}
          </div>
        )}
        {injured.map((part) => (
          <div
            key={part.id}
            className={`injury-row ${part.bleeding ? 'bleed' : `sev-${part.severity}`}${hover === part.id ? ' hover' : ''}`}
            onMouseEnter={() => setHover(part.id)}
            onMouseLeave={() => setHover(null)}
          >
            <div className="injury-top">
              <span className="injury-part">{part.label}</span>
              <span className="injury-tag">{part.bleeding ? Locale.ui_bleeding || 'Bleeding' : SEVERITY[part.severity]}</span>
            </div>
            <div className="injury-bottom">
              <p className="injury-wound">
                {part.wound}
                {part.after && <span> {Locale.ui_then || 'then'} {part.after.toLowerCase()}</span>}
              </p>
              {part.item && (
                <div className="injury-treat" title={`${Locale.ui_treat_with || 'Treat with'} ${part.itemLabel || part.item}`}>
                  <span className="injury-treat-thumb" style={{ backgroundImage: `url(${getItemUrl(part.item)})` }} />
                  <b>{part.itemLabel || part.item}</b>
                </div>
              )}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
};

export default HealthTab;
