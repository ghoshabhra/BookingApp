package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.Slots;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.mongodb.core.MongoTemplate;
import org.springframework.data.mongodb.core.aggregation.Aggregation;
import org.springframework.data.mongodb.core.aggregation.AggregationOperation;
import org.springframework.data.mongodb.core.aggregation.AggregationResults;
import org.springframework.data.mongodb.core.query.Criteria;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;

@Service
public class ReservationRepositoryImpl implements ReservationRepository{

    @Autowired
    private BookingRepository bookingRepository;

    @Autowired
    private MongoTemplate mongoTemplate;

    @Autowired
    private SlotRepository slotRepository;

    @Override
    public List<Slots> fetchAvailableSlots(String offeringId, LocalDateTime startTime, LocalDateTime endTime) {
        // Match Stage 1: Match offeringId
        AggregationOperation matchOfferingId = Aggregation.match(
                Criteria.where("offeringId").is(offeringId)
        );

        // Match Stage 2: Match availability filters
        AggregationOperation matchAvailability = Aggregation.match(
                Criteria.where("availability.isAvailable").is(true)
        );

        AggregationOperation matchStartTime = Aggregation.match(
                Criteria.where("availability.date").gte(startTime)
        );
        AggregationOperation matchEndTime = Aggregation.match(
                Criteria.where("availability.date").lte(endTime)
        );

        Aggregation aggregation = Aggregation.newAggregation(
                matchOfferingId,
                matchAvailability,
                matchStartTime,
                matchEndTime
        );

        AggregationResults<Slots> results = mongoTemplate.aggregate(
                aggregation, "slots", Slots.class
        );

        return results.getMappedResults();
    }




}
