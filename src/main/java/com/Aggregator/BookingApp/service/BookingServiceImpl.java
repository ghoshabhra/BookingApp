package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;
import com.Aggregator.BookingApp.Repository.BookingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class BookingServiceImpl implements BookingService {

    @Autowired
    BookingRepository bookingRepository;

    @Override
    public void deleteBooking(String id) {
        bookingRepository.deleteById(id);
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
