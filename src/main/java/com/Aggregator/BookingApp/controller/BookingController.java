package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;
import com.Aggregator.BookingApp.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController("/Booking")
public class BookingController {

    @Autowired
    public BookingService bookingService;

    @GetMapping("/user/{id")
    public List<Booking> getBookingsById(@PathVariable("id") String id){
        return bookingService.getAllBookingsByUserID(id);
    }

    @PostMapping
    public Booking addNewBooking(@RequestBody BookingDTO bookingDTO){
        return bookingService.createNewBooking(bookingDTO);
    }

    @PutMapping
    public Booking updateBooking(@RequestBody Booking booking){
        return bookingService.updateExistingBooking(booking);
    }

    @DeleteMapping("/{id}")
    public void cancelBooking(@PathVariable("id") String id){
        bookingService.deleteBooking(id);
    }

}
