import React, { useCallback, useRef } from 'react';
import { DragSource, Inventory, InventoryType, Slot, SlotWithItem } from '../../typings';
import { useDrag, useDragDropManager, useDrop } from 'react-dnd';
import { useAppDispatch } from '../../store';
import WeightBar from '../utils/WeightBar';
import { onDrop } from '../../dnd/onDrop';
import { onBuy } from '../../dnd/onBuy';
import { Items } from '../../store/items';
import { canCraftItem, canPurchaseItem, getItemUrl, isSlotWithItem } from '../../helpers';
import { onUse } from '../../dnd/onUse';
import { Locale } from '../../store/locale';
import { onCraft } from '../../dnd/onCraft';
import useNuiEvent from '../../hooks/useNuiEvent';
import { ItemsPayload } from '../../reducers/refreshSlots';
import { closeTooltip, openTooltip } from '../../store/tooltip';
import { openContextMenu } from '../../store/contextMenu';
import { useMergeRefs } from '@floating-ui/react';
import { canHoldItem } from '../../store/utility';
import { getRarity } from '../../store/rarity';
import { canSwap, Grid } from '../../store/grid';
import { startGridDrag } from '../../store/gridDrag';
import { store } from '../../store';
import { canStack, getTargetInventory } from '../../helpers';

// Grid inventory: a single slot (hotbar, equipment) takes any size, but an item swapped out of it has to
// fit back into the grid cell the dragged item came from
const fitsGrid = (source: DragSource, target: Slot, targetType: Inventory['type']) => {
  if (!Grid.enabled || !isSlotWithItem(target)) return true;

  const state = store.getState().inventory;
  const { sourceInventory, targetInventory } = getTargetInventory(state, source.inventory, targetType);
  const from = sourceInventory.items[source.item.slot - 1];

  if (!isSlotWithItem(from)) return true;
  if (Items[from.name]?.stack && canStack(from, target)) return true;

  return canSwap(sourceInventory, from, targetInventory, target, from.rotated);
};

// Weapon / equipment slots only take their own items, in either direction of a swap
const fitsUtilitySlots = (source: DragSource, target: Slot, targetType: Inventory['type']) => {
  if (targetType === InventoryType.PLAYER && !canHoldItem(target.slot, source.item.name)) return false;

  if (source.inventory === InventoryType.PLAYER && isSlotWithItem(target) && target.name !== source.item.name)
    return canHoldItem(source.item.slot, target.name);

  return true;
};

export const formatWeight = (weight: number) =>
  weight > 0
    ? weight >= 1000
      ? `${(weight / 1000).toLocaleString('en-us', { maximumFractionDigits: 1 })}kg`
      : `${weight.toLocaleString('en-us', { minimumFractionDigits: 0 })}g`
    : '';

interface SlotProps {
  inventoryId: Inventory['id'];
  inventoryType: Inventory['type'];
  inventoryGroups: Inventory['groups'];
  item: Slot;
  placeholder?: React.ReactNode;
  className?: string;
}

const InventorySlot: React.ForwardRefRenderFunction<HTMLDivElement, SlotProps> = (
  { item, inventoryId, inventoryType, inventoryGroups, placeholder, className },
  ref
) => {
  const manager = useDragDropManager();
  const dispatch = useAppDispatch();
  const timerRef = useRef<number | null>(null);

  const canDrag = useCallback(() => {
    return canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) && canCraftItem(item, inventoryType);
  }, [item, inventoryType, inventoryGroups]);

  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({
        isDragging: monitor.isDragging(),
      }),
      item: () =>
        isSlotWithItem(item, inventoryType !== InventoryType.SHOP)
          ? {
              inventory: inventoryType,
              item: {
                name: item.name,
                slot: item.slot,
              },
              image: item?.name && `url(${getItemUrl(item) || 'none'}`,
            }
          : null,
      canDrag,
    }),
    [inventoryType, item]
  );

  const [{ isOver }, drop] = useDrop<DragSource, void, { isOver: boolean }>(
    () => ({
      accept: 'SLOT',
      collect: (monitor) => ({
        isOver: monitor.isOver(),
      }),
      drop: (source) => {
        dispatch(closeTooltip());
        switch (source.inventory) {
          case InventoryType.SHOP:
            onBuy(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          case InventoryType.CRAFTING:
            onCraft(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
          default:
            onDrop(source, { inventory: inventoryType, item: { slot: item.slot } });
            break;
        }
      },
      canDrop: (source) =>
        (source.item.slot !== item.slot || source.inventory !== inventoryType) &&
        inventoryType !== InventoryType.SHOP &&
        inventoryType !== InventoryType.CRAFTING &&
        fitsUtilitySlots(source, item, inventoryType) &&
        (source.inventory === InventoryType.SHOP ||
          source.inventory === InventoryType.CRAFTING ||
          fitsGrid(source, item, inventoryType)),
    }),
    [inventoryType, item]
  );

  useNuiEvent('refreshSlots', (data: { items?: ItemsPayload | ItemsPayload[] }) => {
    if (!isDragging && !data.items) return;
    if (!Array.isArray(data.items)) return;

    const itemSlot = data.items.find(
      (dataItem) => dataItem.item.slot === item.slot && dataItem.inventory === inventoryId
    );

    if (!itemSlot) return;

    manager.dispatch({ type: 'dnd-core/END_DRAG' });
  });

  const connectRef = (element: HTMLDivElement | null) => {
    if (!element) return;
    drag(drop(element));
  };

  const handleContext = (event: React.MouseEvent<HTMLDivElement>) => {
    event.preventDefault();
    if (inventoryType !== 'player' || !isSlotWithItem(item)) return;

    dispatch(openContextMenu({ item, coords: { x: event.clientX, y: event.clientY } }));
  };

  const handleClick = (event: React.MouseEvent<HTMLDivElement>) => {
    dispatch(closeTooltip());
    if (timerRef.current) clearTimeout(timerRef.current);
    if (event.ctrlKey && isSlotWithItem(item) && inventoryType !== 'shop' && inventoryType !== 'crafting') {
      onDrop({ item: item, inventory: inventoryType });
    } else if (event.altKey && isSlotWithItem(item) && inventoryType === 'player') {
      onUse(item);
    }
  };

  const refs = useMergeRefs([connectRef, ref]);

  const isHotslot = inventoryType === 'player' && item.slot <= 5;
  const locked =
    !canPurchaseItem(item, { type: inventoryType, groups: inventoryGroups }) || !canCraftItem(item, inventoryType);
  const rarity = isSlotWithItem(item) ? getRarity(item) : null;

  return (
    <div
      ref={refs}
      onContextMenu={handleContext}
      onClick={handleClick}
      // grid inventory: the drag starts with the item's own rotation, R turns it while dragging
      onMouseDown={() => isSlotWithItem(item) && startGridDrag(!!item.rotated)}
      className={`inventory-slot${className ? ` ${className}` : ''}${isOver ? ' is-over' : ''}${
        isSlotWithItem(item) ? ' has-item' : ''
      }${rarity?.tinted ? ' rarity' : ''}`}
      style={{
        ...rarity?.vars,
        filter: locked ? 'brightness(80%) grayscale(100%)' : undefined,
        opacity: isDragging ? 0.4 : 1.0,
        backgroundImage: `url(${item?.name ? getItemUrl(item as SlotWithItem) : 'none'}`,
      }}
    >
      {!isSlotWithItem(item) && placeholder}
      {isSlotWithItem(item) && (
        <div
          className="item-slot-wrapper"
          onMouseEnter={() => {
            timerRef.current = window.setTimeout(() => {
              dispatch(openTooltip({ item, inventoryType }));
            }, 500) as unknown as number;
          }}
          onMouseLeave={() => {
            dispatch(closeTooltip());
            if (timerRef.current) {
              clearTimeout(timerRef.current);
              timerRef.current = null;
            }
          }}
        >
          <div className="item-slot-header-wrapper">
            <div className="item-slot-header-left">
              {isHotslot && <div className="inventory-slot-number">{item.slot}</div>}
              {item.count ? <p className="item-slot-count">{item.count.toLocaleString('en-us')}x</p> : null}
            </div>
            <p className="item-slot-weight">{formatWeight(item.weight)}</p>
          </div>
          <div>
            {inventoryType === 'shop' && item?.price !== undefined && (
              <>
                {item?.currency !== 'money' && item.currency !== 'black_money' && item.price > 0 && item.currency ? (
                  <div className="item-slot-currency-wrapper">
                    <img
                      src={item.currency ? getItemUrl(item.currency) : 'none'}
                      alt="item-image"
                      style={{
                        imageRendering: '-webkit-optimize-contrast',
                        height: 'auto',
                        width: '2vh',
                        backfaceVisibility: 'hidden',
                        transform: 'translateZ(0)',
                      }}
                    />
                    <p>{item.price.toLocaleString('en-us')}</p>
                  </div>
                ) : (
                  <>
                    {item.price > 0 && (
                      <div
                        className="item-slot-price-wrapper"
                        style={{ color: item.currency === 'money' || !item.currency ? '#69db7c' : '#ff8787' }}
                      >
                        <p>
                          {Locale.$ || '$'}
                          {item.price.toLocaleString('en-us')}
                        </p>
                      </div>
                    )}
                  </>
                )}
              </>
            )}
            <div className="inventory-slot-label-box">
              <div className="inventory-slot-label-text">
                {item.metadata?.label ? item.metadata.label : Items[item.name]?.label || item.name}
              </div>
            </div>
            {inventoryType !== 'shop' && item?.durability !== undefined && (
              <WeightBar percent={item.durability} durability />
            )}
          </div>
        </div>
      )}
    </div>
  );
};

export default React.memo(React.forwardRef(InventorySlot));
