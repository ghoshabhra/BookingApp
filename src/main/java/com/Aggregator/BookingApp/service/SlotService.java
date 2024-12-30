package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.Model.Slots;

public interface SlotService {
    public Slots addSlots(Slots slots);
    public void deleteSlots(String id);
}
