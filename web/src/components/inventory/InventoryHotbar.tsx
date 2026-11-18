import React, { useState } from 'react';
import { getItemUrl, isSlotWithItem } from '../../helpers';
import useNuiEvent from '../../hooks/useNuiEvent';
import { Items } from '../../store/items';
import WeightBar from '../utils/WeightBar';
import { useAppSelector } from '../../store';
import { selectLeftInventory } from '../../store/inventory';
import { SlotWithItem } from '../../typings';
import SlideUp from '../utils/transitions/SlideUp';
import { formatWeight } from './InventorySlot';

const InventoryHotbar: React.FC = () => {
  const [hotbarVisible, setHotbarVisible] = useState(false);
  const items = useAppSelector(selectLeftInventory).items.slice(0, 5);

  //stupid fix for timeout
  const [handle, setHandle] = useState<ReturnType<typeof setTimeout>>();
  useNuiEvent('toggleHotbar', () => {
    if (hotbarVisible) {
      setHotbarVisible(false);
    } else {
      if (handle) clearTimeout(handle);
      setHotbarVisible(true);
      setHandle(setTimeout(() => setHotbarVisible(false), 3000));
    }
  });

  return (
    <SlideUp in={hotbarVisible}>
      <div className="hotbar-container">
        {items.map((item) => (
          <div
            className="hotbar-item-slot inventory-slot"
            style={{
              backgroundImage: `url(${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`,
            }}
            key={`hotbar-${item.slot}`}
          >
            {isSlotWithItem(item) && (
              <div className="item-slot-wrapper">
                <div className="item-slot-header-wrapper">
                  <div className="item-slot-header-left">
                    <div className="inventory-slot-number">{item.slot}</div>
                    {item.count ? <p className="item-slot-count">{item.count.toLocaleString('en-us')}x</p> : null}
                  </div>
                  <p className="item-slot-weight">{formatWeight(item.weight)}</p>
                </div>
                <div>
                  <div className="inventory-slot-label-box">
                    <div className="inventory-slot-label-text">
                      {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
                    </div>
                  </div>
                  {item?.durability !== undefined && <WeightBar percent={item.durability} durability />}
                </div>
              </div>
            )}
          </div>
        ))}
      </div>
    </SlideUp>
  );
};

export default InventoryHotbar;
