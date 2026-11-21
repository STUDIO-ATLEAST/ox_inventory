import { createAsyncThunk } from '@reduxjs/toolkit';
import { fetchNui } from '../utils/fetchNui';

export const buyItem = createAsyncThunk(
  'inventory/buyItem',
  async (
    data: {
      fromSlot: number;
      fromType: string;
      toSlot: number;
      toType: string;
      count: number;
      payment?: 'cash' | 'card';
      // grid inventory: rotation at the target (the server finds another spot when it doesn't fit)
      rotate?: boolean;
    },
    { rejectWithValue }
  ) => {
    try {
      const response = await fetchNui<boolean>('buyItem', data);

      if (response === false) {
        return rejectWithValue(response);
      }
    } catch (error) {
      return rejectWithValue(false);
    }
  }
);
