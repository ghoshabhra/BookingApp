package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Slots;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface SlotRepository extends MongoRepository<Slots, String> {
}
