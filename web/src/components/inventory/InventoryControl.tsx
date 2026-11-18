import React, { useState, useRef, useEffect } from 'react';
import { useDrop } from 'react-dnd';
import { useAppDispatch, useAppSelector } from '../../store';
import { selectItemAmount, setItemAmount } from '../../store/inventory';
import { DragSource } from '../../typings';
import { onUse } from '../../dnd/onUse';
import { onGive } from '../../dnd/onGive';
import { fetchNui } from '../../utils/fetchNui';
import { Locale } from '../../store/locale';
import { HandHelping, MousePointerClick } from 'lucide-react';

const formatAmount = (n: number) => (n > 0 ? n.toLocaleString('en-US') : '');
const digitsOnly = (s: string) => s.replace(/\D/g, '');
const countDigitsBefore = (s: string, index: number) => digitsOnly(s.substring(0, index)).length;

// inline: one row under the hotbar in the character panel instead of the floating column
const InventoryControl: React.FC<{ inline?: boolean }> = ({ inline }) => {
  const itemAmount = useAppSelector(selectItemAmount);
  const dispatch = useAppDispatch();

  const [value, setValue] = useState(formatAmount(itemAmount));
  const inputRef = useRef<HTMLInputElement>(null);
  const cursorRef = useRef<number | null>(null);

  const [, use] = useDrop<DragSource, void, any>(() => ({
    accept: 'SLOT',
    drop: (source) => {
      source.inventory === 'player' && onUse(source.item);
    },
  }));

  const [, give] = useDrop<DragSource, void, any>(() => ({
    accept: 'SLOT',
    drop: (source) => {
      source.inventory === 'player' && onGive(source.item);
    },
  }));

  const commitValue = (raw: string, cursorIndex: number) => {
    const digitsBefore = countDigitsBefore(raw, cursorIndex);
    const num = parseInt(digitsOnly(raw), 10) || 0;

    setValue(formatAmount(num));
    dispatch(setItemAmount(num));
    cursorRef.current = digitsBefore;
  };

  const handleChange = (event: React.ChangeEvent<HTMLInputElement>) =>
    commitValue(event.target.value, event.target.selectionStart ?? 0);

  const handleKeyDown = (event: React.KeyboardEvent<HTMLInputElement>) => {
    const el = event.currentTarget;
    const pos = el.selectionStart ?? 0;

    if (pos !== el.selectionEnd) return;

    if (event.key === 'Backspace' && el.value[pos - 1] === ',') {
      event.preventDefault();
      commitValue(el.value.slice(0, pos - 2) + el.value.slice(pos), pos - 2);
    } else if (event.key === 'Delete' && el.value[pos] === ',') {
      event.preventDefault();
      commitValue(el.value.slice(0, pos) + el.value.slice(pos + 2), pos);
    }
  };

  useEffect(() => {
    if (!inputRef.current || cursorRef.current === null) return;
    let newPos = 0;
    let count = 0;

    for (let i = 0; i < value.length && count < cursorRef.current; i++) {
      if (/\d/.test(value[i])) count++;
      newPos++;
    }

    inputRef.current.setSelectionRange(newPos, newPos);
    cursorRef.current = null;
  }, [value]);

  return (
    <>
      {inline ? (
        // centre column: Use | amount | Give in one row (Esc / TAB close the inventory)
        <div className="inventory-actions">
          <button
            className="action-button"
            ref={(el) => {
              use(el);
            }}
          >
            <MousePointerClick />
            {Locale.ui_use || 'Use'}
          </button>
          <input
            className="amount-field"
            type="text"
            ref={inputRef}
            value={value}
            onChange={handleChange}
            onKeyDown={handleKeyDown}
            placeholder={Locale.ui_amount || 'Amount'}
            title={Locale.ui_amount || 'Amount'}
          />
          <button
            className="action-button"
            ref={(el) => {
              give(el);
            }}
          >
            <HandHelping />
            {Locale.ui_give || 'Give'}
          </button>
        </div>
      ) : (
        <div className="inventory-control">
          <div className="inventory-control-wrapper">
            <input
              className="inventory-control-input"
              type="text"
              ref={inputRef}
              value={value}
              onChange={handleChange}
              onKeyDown={handleKeyDown}
              min={0}
            />
            <button
              className="inventory-control-button"
              ref={(el) => {
                use(el);
              }}
            >
              {Locale.ui_use || 'Use'}
            </button>
            <button
              className="inventory-control-button"
              ref={(el) => {
                give(el);
              }}
            >
              {Locale.ui_give || 'Give'}
            </button>
            <button className="inventory-control-button subtle" onClick={() => fetchNui('exit')}>
              {Locale.ui_close || 'Close'}
            </button>
          </div>
        </div>
      )}
    </>
  );
};

export default InventoryControl;
