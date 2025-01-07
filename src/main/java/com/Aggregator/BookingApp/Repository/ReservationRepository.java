package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Slots;

import java.time.LocalDateTime;
import java.util.List;

public interface ReservationRepository {
    public List<Slots> fetchAvailableSlots(String offeringId, LocalDateTime startTime, LocalDateTime endTime);
}
