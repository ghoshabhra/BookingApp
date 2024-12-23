package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookingServiceImpl implements BookingService {
    @Override
    public void deleteBooking(String id) {

    }

    @Override
    public Booking createNewBooking(BookingDTO bookingDto) {
        return null;
    }

    @Override
    public Booking updateExistingBooking(Booking updatedBooking) {
        return null;
    }

    @Override
    public List<Booking> getAllBookingsByUserID(String userId) {
        return List.of();
    }
}
