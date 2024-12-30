package com.Aggregator.BookingApp.Repository;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.stereotype.Service;

@Service
public class ReservationRepositoryImpl implements ReservationRepository{

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private MongoTemplate mongoTemplate;


}
