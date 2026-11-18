// Payment method picked in the shop basket. Read by drag-to-buy (dnd/onBuy) too, so a dragged
// item is paid the same way as the basket.
export type PaymentMethod = 'cash' | 'card';

let payment: PaymentMethod = 'cash';

export const getPayment = () => payment;
export const setPayment = (method: PaymentMethod) => {
  payment = method;
};
