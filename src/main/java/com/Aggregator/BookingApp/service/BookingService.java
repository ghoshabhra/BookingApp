package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;

import java.util.List;

public interface BookingService {
    public void deleteBooking(String id);
    public Booking createNewBooking(BookingDTO bookingDto);
    public Booking updateExistingBooking(Booking updatedBooking);
    public List<Booking> getAllBookingsByUserID(String userId);
}
