package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Offering;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface OfferingRepository extends MongoRepository<Offering, String>{
}
