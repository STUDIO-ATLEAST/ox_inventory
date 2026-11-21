import React, { useCallback, useEffect, useMemo, useState } from 'react';
import { useDrag } from 'react-dnd';
import {
  Banknote,
  CreditCard,
  Lock,
  Minus,
  Plus,
  Search,
  ShoppingBasket,
  Store,
  Trash2,
  X,
} from 'lucide-react';
import { store, useAppDispatch, useAppSelector } from '../../store';
import { selectLeftInventory, selectRightInventory } from '../../store/inventory';
import { Items } from '../../store/items';
import { Locale } from '../../store/locale';
import { canPurchaseItem, getItemUrl, isSlotWithItem } from '../../helpers';
import { canHoldItem, getEquipmentSlot } from '../../store/utility';
import { findSpot, usesGrid } from '../../store/grid';
import { getRarity } from '../../store/rarity';
import { getPayment, PaymentMethod, setPayment } from '../../store/shop';
import { buyItem } from '../../thunks/buyItem';
import { fetchNui } from '../../utils/fetchNui';
import { isEnvBrowser } from '../../utils/misc';
import { DragSource, Inventory, SlotWithItem } from '../../typings';
import PanelHeading from './PanelHeading';

type BasketLine = { slot: number; count: number };

const MONEY = 'money';
const DEV_BANK = 48250;

const t = (key: string, fallback: string) => Locale[key] || fallback;
const labelOf = (item: SlotWithItem) => item.metadata?.label || Items[item.name]?.label || item.name;
const currencyOf = (item: SlotWithItem) => item.currency || MONEY;
const dollars = (value: number) => `$${Math.round(value).toLocaleString('en-US')}`;

// "$250" for cash items, "12 Black Money" for items bought with another item
const formatPrice = (value: number, currency: string) =>
  currency === MONEY ? dollars(value) : `${value.toLocaleString('en-US')} ${Items[currency]?.label || currency}`;

// how many of an item the pockets hold
const countOf = (inventory: Inventory, name: string) =>
  inventory.items.reduce((total, slot) => (isSlotWithItem(slot) && slot.name === name ? total + slot.count : total), 0);

const hasMetadata = (metadata?: Record<string, any>) => !!metadata && Object.keys(metadata).length > 0;

// Pocket slot a bought item goes to: an existing plain stack first, then the first free regular slot
// (hotbar and equipment slots are left alone unless nothing else is free)
const findTargetSlot = (name: string) => {
  const pockets = store.getState().inventory.leftInventory;

  if (Items[name]?.stack !== false) {
    const stack = pockets.items.find(
      (slot) => isSlotWithItem(slot) && slot.name === name && !hasMetadata(slot.metadata) && canHoldItem(slot.slot, name)
    );
    if (stack) return stack.slot;
  }

  // grid inventory: a spot the whole item fits in (the server double-checks and picks another if needed)
  if (usesGrid(pockets.type)) {
    const spot = findSpot(pockets, name);
    if (spot) return spot.slot;
  }

  const free = (regularOnly: boolean) =>
    pockets.items.find(
      (slot) =>
        !isSlotWithItem(slot) &&
        canHoldItem(slot.slot, name) &&
        (!regularOnly || (slot.slot > 5 && !getEquipmentSlot(slot.slot)))
    );

  return (free(true) ?? free(false))?.slot;
};

const ProductCard: React.FC<{
  item: SlotWithItem;
  shop: Inventory;
  inBasket: number;
  onAdd: () => void;
}> = ({ item, shop, inBasket, onAdd }) => {
  const allowed = canPurchaseItem(item, { type: shop.type, groups: shop.groups });
  const soldOut = item.count !== undefined && item.count <= 0;
  const left = item.count !== undefined ? item.count - inBasket : undefined;
  const disabled = !allowed || soldOut || (left !== undefined && left <= 0);
  const rarity = getRarity(item);

  // products can still be dragged straight onto a pocket slot, like the ox shop grid
  const [{ isDragging }, drag] = useDrag<DragSource, void, { isDragging: boolean }>(
    () => ({
      type: 'SLOT',
      collect: (monitor) => ({ isDragging: monitor.isDragging() }),
      item: () => ({
        inventory: shop.type,
        item: { name: item.name, slot: item.slot },
        image: `url(${getItemUrl(item) || 'none'})`,
      }),
      canDrag: () => allowed && !soldOut,
    }),
    [item, shop.type, allowed, soldOut]
  );

  return (
    <button
      ref={(element) => { drag(element); }}
      className={`product-card${disabled ? ' disabled' : ''}${inBasket ? ' picked' : ''}${rarity?.tinted ? ' rarity' : ''}`}
      style={{ ...rarity?.vars, opacity: isDragging ? 0.4 : undefined }}
      onClick={() => !disabled && onAdd()}
    >
      <span className="product-top">
        {soldOut ? (
          <span className="product-tag sold">{t('ui_sold_out', 'Sold out')}</span>
        ) : item.count !== undefined ? (
          <span className="product-tag">{item.count}x</span>
        ) : (
          <span />
        )}
        {!allowed && !soldOut ? (
          <Lock className="product-lock" />
        ) : inBasket ? (
          <span className="product-tag in-basket">{inBasket}</span>
        ) : null}
      </span>
      <span className="product-image" style={{ backgroundImage: `url(${getItemUrl(item)})` }} />
      <span className="product-name">{labelOf(item)}</span>
      <span className="product-price">
        <span>{formatPrice(item.price || 0, currencyOf(item))}</span>
        <Plus />
      </span>
    </button>
  );
};

const ShopView: React.FC = () => {
  const dispatch = useAppDispatch();
  const shop = useAppSelector(selectRightInventory);
  const pockets = useAppSelector(selectLeftInventory);
  const [query, setQuery] = useState('');
  const [basket, setBasket] = useState<BasketLine[]>([]);
  const [payment, setPaymentState] = useState<PaymentMethod>(getPayment());
  const [bank, setBank] = useState<number | null>(null);
  const [paying, setPaying] = useState(false);

  const refreshBank = useCallback(() => {
    if (isEnvBrowser()) return setBank((value) => value ?? DEV_BANK);
    fetchNui<number>('getBankBalance')
      .then((value) => setBank(typeof value === 'number' ? value : 0))
      .catch(() => setBank(null));
  }, []);

  // a new shop starts with an empty basket
  useEffect(() => {
    // ?demo in the browser preview starts with a filled basket for screenshots
    const demo = isEnvBrowser() && window.location.search.includes('demo');
    setBasket(demo ? [{ slot: 1, count: 2 }, { slot: 6, count: 1 }, { slot: 11, count: 1 }] : []);
    if (demo) {
      setPayment('card');
      setPaymentState('card');
    }
    setQuery('');
    refreshBank();
  }, [shop.id, refreshBank]);

  const choosePayment = (method: PaymentMethod) => {
    setPayment(method);
    setPaymentState(method);
  };

  const products = useMemo(
    () => shop.items.filter((slot): slot is SlotWithItem => isSlotWithItem(slot)),
    [shop.items]
  );

  const visible = useMemo(() => {
    const needle = query.trim().toLowerCase();
    if (!needle) return products;
    return products.filter((item) => labelOf(item).toLowerCase().includes(needle));
  }, [products, query]);

  const productAt = (slot: number) => products.find((item) => item.slot === slot);
  const stockOf = (slot: number) => productAt(slot)?.count;

  const add = (slot: number, amount = 1) =>
    setBasket((lines) => {
      const stock = stockOf(slot);
      const line = lines.find((entry) => entry.slot === slot);
      const next = Math.max(0, (line?.count || 0) + amount);
      const capped = stock !== undefined ? Math.min(next, stock) : Math.min(next, 999);
      if (!line) return capped > 0 ? [...lines, { slot, count: capped }] : lines;
      return capped > 0
        ? lines.map((entry) => (entry.slot === slot ? { ...entry, count: capped } : entry))
        : lines.filter((entry) => entry.slot !== slot);
    });

  const remove = (slot: number) => setBasket((lines) => lines.filter((entry) => entry.slot !== slot));

  // drop lines whose product went away or sold out while browsing
  useEffect(() => {
    setBasket((lines) => {
      const next = lines
        .map((line) => {
          const stock = stockOf(line.slot);
          return productAt(line.slot) ? { ...line, count: stock !== undefined ? Math.min(line.count, stock) : line.count } : null;
        })
        .filter((line): line is BasketLine => !!line && line.count > 0);
      return next.length === lines.length && next.every((line, i) => line.count === lines[i].count) ? lines : next;
    });
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [products]);

  const cash = countOf(pockets, MONEY);

  // totals per currency; card only covers the dollar lines
  const totals = useMemo(() => {
    const sums: Record<string, number> = {};
    for (const line of basket) {
      const item = productAt(line.slot);
      if (!item) continue;
      const currency = currencyOf(item);
      sums[currency] = (sums[currency] || 0) + (item.price || 0) * line.count;
    }
    return sums;
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [basket, products]);

  const dollarTotal = totals[MONEY] || 0;
  const otherTotals = Object.entries(totals).filter(([currency]) => currency !== MONEY);
  const funds = payment === 'card' ? bank ?? 0 : cash;
  const shortOther = otherTotals.find(([currency, amount]) => countOf(pockets, currency) < amount);
  const short = dollarTotal > funds || !!shortOther;
  const itemCount = basket.reduce((total, line) => total + line.count, 0);

  const pay = async () => {
    if (paying || basket.length === 0 || short) return;
    setPaying(true);

    const failed: BasketLine[] = [];

    for (const line of basket) {
      const item = productAt(line.slot);
      if (!item) continue;

      if (isEnvBrowser()) {
        await new Promise((resolve) => setTimeout(resolve, 250));
        if (payment === 'card' && currencyOf(item) === MONEY) setBank((value) => (value ?? 0) - (item.price || 0) * line.count);
        continue;
      }

      const toSlot = findTargetSlot(item.name);

      if (!toSlot) {
        failed.push(line);
        continue;
      }

      const result = await dispatch(
        buyItem({ fromSlot: item.slot, fromType: shop.type, toSlot, toType: 'player', count: line.count, payment })
      );

      if (!buyItem.fulfilled.match(result)) failed.push(line);
    }

    setBasket(failed);
    setPaying(false);
    refreshBank();
  };

  return (
    <div className="shop-view">
      <div className="panel-header">
        <PanelHeading
          icon={Store}
          title={shop.label || t('ui_shop', 'Shop')}
          subtitle={t('ui_store', 'Store')}
          aside={
            <div className="wallet">
              <span className="wallet-chip">
                <Banknote />
                {dollars(cash)}
              </span>
              <span className="wallet-chip">
                <CreditCard />
                {bank === null ? '...' : dollars(bank)}
              </span>
            </div>
          }
        />
      </div>

      <div className="shop-body">
        <section className="shop-catalogue">
          <label className="shop-search">
            <Search />
            <input
              value={query}
              placeholder={t('ui_search', 'Search')}
              onChange={(event) => setQuery(event.target.value)}
            />
            {query && (
              <button onClick={() => setQuery('')}>
                <X />
              </button>
            )}
          </label>

          <div className="product-grid">
            {visible.map((item) => (
              <ProductCard
                key={item.slot}
                item={item}
                shop={shop}
                inBasket={basket.find((line) => line.slot === item.slot)?.count || 0}
                onAdd={() => add(item.slot)}
              />
            ))}
            {visible.length === 0 && <p className="empty-note">{t('ui_no_results', 'Nothing found')}</p>}
          </div>
        </section>

        <aside className="shop-basket">
          <p className="basket-title">
            <ShoppingBasket />
            {t('ui_basket', 'Basket')}
            <span>{itemCount}</span>
            {basket.length > 0 && (
              <button className="basket-clear" onClick={() => setBasket([])} title="Clear">
                <Trash2 />
              </button>
            )}
          </p>

          <div className="basket-lines">
            {basket.length === 0 && (
              <div className="basket-empty">
                <ShoppingBasket />
                <p>{t('ui_basket_empty', 'Basket is empty')}</p>
              </div>
            )}
            {basket.map((line) => {
              const item = productAt(line.slot);
              if (!item) return null;
              const stock = item.count;
              return (
                <div key={line.slot} className="basket-line">
                  <span className="basket-thumb" style={{ backgroundImage: `url(${getItemUrl(item)})` }} />
                  <div className="basket-text">
                    <p className="basket-name">{labelOf(item)}</p>
                    <p className="basket-unit">{formatPrice(item.price || 0, currencyOf(item))}</p>
                  </div>
                  <div className="basket-stepper">
                    <button onClick={() => add(line.slot, -1)}>
                      <Minus />
                    </button>
                    <span>{line.count}</span>
                    <button onClick={() => add(line.slot, 1)} disabled={stock !== undefined && line.count >= stock}>
                      <Plus />
                    </button>
                  </div>
                  <p className="basket-sum">{formatPrice((item.price || 0) * line.count, currencyOf(item))}</p>
                  <button className="basket-remove" onClick={() => remove(line.slot)}>
                    <X />
                  </button>
                </div>
              );
            })}
          </div>

          <div className="basket-footer">
            <div className="pay-methods">
              {(
                [
                  ['cash', Banknote, t('ui_pay_cash', 'Cash'), cash],
                  ['card', CreditCard, t('ui_pay_card', 'Card'), bank],
                ] as const
              ).map(([method, Icon, label, balance]) => (
                <button
                  key={method}
                  className={`pay-method${payment === method ? ' active' : ''}`}
                  onClick={() => choosePayment(method)}
                >
                  <Icon />
                  <span className="pay-method-label">{label}</span>
                  <span className="pay-method-balance">{balance === null ? '...' : dollars(balance)}</span>
                </button>
              ))}
            </div>

            <div className="basket-total">
              <span>{t('ui_total', 'Total')}</span>
              <b>{dollars(dollarTotal)}</b>
            </div>
            {otherTotals.map(([currency, amount]) => (
              <div key={currency} className="basket-total other">
                <span>{Items[currency]?.label || currency}</span>
                <b>{amount.toLocaleString('en-US')}</b>
              </div>
            ))}

            <button className={`pay-button${paying ? ' busy' : ''}`} disabled={paying || basket.length === 0 || short} onClick={pay}>
              {payment === 'card' ? <CreditCard /> : <Banknote />}
              {short && basket.length > 0
                ? t('ui_not_enough', 'Not enough funds')
                : `${t('ui_pay', 'Pay')} ${dollarTotal > 0 ? dollars(dollarTotal) : ''}`}
            </button>
          </div>
        </aside>
      </div>
    </div>
  );
};

export default ShopView;
