package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.Model.Slots;
import com.Aggregator.BookingApp.Repository.SlotRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class SlotServiceImpl implements SlotService{

    @Autowired
    private SlotRepository slotRepository;

    @Override
    public Slots addSlots(Slots slots) {
        return slotRepository.save(slots);
    }

    @Override
    public void deleteSlots(String id) {
        slotRepository.deleteById(id);
    }
}
