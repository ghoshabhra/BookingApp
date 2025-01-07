package com.Aggregator.BookingApp.service;


import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;
import com.Aggregator.BookingApp.Model.Offering;
import com.Aggregator.BookingApp.Model.Slots;
import com.Aggregator.BookingApp.Model.User;
import com.Aggregator.BookingApp.Repository.BookingRepository;
import com.Aggregator.BookingApp.Repository.ReservationRepository;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.time.LocalTime;
import java.time.temporal.ChronoUnit;
import java.util.*;

@Service
public class BookingServiceImpl implements BookingService {
    private static final Logger logger = LoggerFactory.getLogger(BookingServiceImpl.class);

    @Autowired
    BookingRepository bookingRepository;

    @Autowired
    UserService userService;

    @Autowired
    OfferingService offeringService;

    @Autowired
    SlotService slotService;

    @Autowired
    ReservationRepository reservationRepository;


    @Override
    public void deleteBooking(String id) {
        bookingRepository.deleteById(id);
    }

    @Override
    public Booking createNewBooking(BookingDTO bookingDto) {
        User usr = userService.findUser(bookingDto.getUserId());
        Offering offering = offeringService.getOfferingById(bookingDto.getOfferingID());
        LocalDateTime slotStartTime = normalizeDate(bookingDto.getStartDate(), offering.getHourlyBookingAllowed());
        LocalDateTime slotEndTime = normalizeDate(bookingDto.getEndDate(), offering.getHourlyBookingAllowed());
        Long numberOfRequiredSlots = calculateNumberOfRequiredSlots(slotStartTime, slotEndTime, offering.getHourlyBookingAllowed());

        List<Slots> listOfSlots = reservationRepository.fetchAvailableSlots(bookingDto.getOfferingID(),
                                                                                        slotStartTime,
                                                                                        slotEndTime);
        Map<String, List<Slots>> slotMap = createSlotMap(listOfSlots);
        String uniqueId = selectUniqueIdForBooking(slotMap, numberOfRequiredSlots);
        Booking booking = constructBookingObject(slotMap.get(uniqueId), usr, offering, bookingDto.getStartDate(), bookingDto.getEndDate());
        return bookingRepository.save(booking);
    }

    @Override
    public Booking updateExistingBooking(Booking updatedBooking) {
        return null;
    }

    @Override
    public List<Booking> getAllBookingsByUserID(String userId) {

        logger.info("Fetching list of bookings  made by user: {}", userId);
        return bookingRepository.findByUserId(userId);

    }

    private Map<String, List<Slots>> createSlotMap(List<Slots> listOfSLots){
        Map<String, List<Slots>> slotMap = new HashMap<>();
        listOfSLots.forEach(e ->{
            if(slotMap.containsKey(e.getUniqueId())){
                slotMap.get(e.getUniqueId()).add(e);
            }
            List<Slots> slotListWithSameUniqueId = new ArrayList<>();
            slotListWithSameUniqueId.add(e);
            slotMap.put(e.getUniqueId(), slotListWithSameUniqueId);
        });
        return slotMap;
    }

    private LocalDateTime normalizeDate(LocalDateTime date, Boolean hourlyBookingAllowed){
        if(hourlyBookingAllowed){
            return LocalDateTime.of(date.toLocalDate(), LocalTime.of(date.getHour(),0));
        }
        return LocalDateTime.of(date.toLocalDate(), LocalTime.of(11, 0));
    }

    private Long calculateNumberOfRequiredSlots(LocalDateTime startDate, LocalDateTime endDate, Boolean hourlyBookingAllowed){
        if(hourlyBookingAllowed){
            ChronoUnit.HOURS.between(startDate, endDate);
        }
        return ChronoUnit.DAYS.between(startDate, endDate);
    }

    private String selectUniqueIdForBooking(Map<String, List<Slots>> slotMap, Long numberOfRequiredSlots){
        List<String> uniqueIdList = new ArrayList<>(slotMap.keySet());
        for(int i = 0; i < uniqueIdList.size(); i++){
            if(slotMap.get( uniqueIdList.get(i)).size() >= numberOfRequiredSlots){
                return uniqueIdList.get(i);
            }
        }

        throw new RuntimeException("Not able find Slots for Booking");
    }

    private Booking constructBookingObject(List<Slots> listOfSlots, User usr, Offering offering, LocalDateTime startDate, LocalDateTime endDate){
        Booking booking = new Booking();

        booking.setUserId(usr.getId());
        booking.setUserEmail(usr.getEmail());
        booking.setUserFirstName(usr.getFirstName());
        booking.setUserLastName(usr.getLastName());
        booking.setOfferingId(offering.getId());
        booking.setOfferingName(offering.getName());
        booking.setOfferingDescription(offering.getDescription());
        booking.setOfferingImageUrl(offering.getImageUrl());
        booking.setActive(true);
        booking.setPaymentStatus(false);
        booking.setCreatedAt(LocalDateTime.now());
        booking.setStartDate(startDate);
        booking.setEndDate(endDate);
        booking.setTotalCost(listOfSlots.size() * offering.getCost());
        listOfSlots.forEach(e -> {
            e.getAvailability().setAvailable(false);
        });
        booking.setListOfBookedSlots(listOfSlots);

        return booking;

    }
}
