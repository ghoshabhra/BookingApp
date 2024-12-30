package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Booking;
import com.Aggregator.BookingApp.Model.Slots;
import org.springframework.data.mongodb.repository.MongoRepository;

public interface BookingRepository extends MongoRepository<Booking, String> {
}
