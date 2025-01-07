package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Booking;
import org.springframework.data.mongodb.repository.MongoRepository;

import java.util.List;

public interface BookingRepository extends MongoRepository<Booking, String> {
    List<Booking> findByUserId(String userId);
    List<Booking> findByUserEmail(String userEmail);
}
