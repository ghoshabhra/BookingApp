package com.Aggregator.BookingApp.service;


import com.Aggregator.BookingApp.DTO.BookingDTO;
import com.Aggregator.BookingApp.Model.Booking;
import com.Aggregator.BookingApp.Model.Offering;
import com.Aggregator.BookingApp.Model.Slots;
import com.Aggregator.BookingApp.Model.User;
import com.Aggregator.BookingApp.Repository.BookingRepository;
import com.Aggregator.BookingApp.Repository.ReservationRepository;
import com.Aggregator.BookingApp.Repository.SlotRepository;
import org.slf4j.LoggerFactory;
import org.slf4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

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
        Booking booking = bookingRepository.findById(id).orElse(null);
        booking.getListOfBookedSlots().forEach(e->{
            e.getAvailability().setAvailable(true);
            slotService.addSlots(e);
        });
        booking.setActive(false);
        bookingRepository.save(booking);
    }

    @Override
    public Booking createNewBooking(BookingDTO bookingDto) {
        Booking booking = initializeBooking(bookingDto);

        Offering offering = offeringService.getOfferingById(bookingDto.getOfferingId());

        LocalDateTime slotStartTime = normalizeDate(bookingDto.getStartDateTime(), offering.getHourlyBookingAllowed());
        LocalDateTime slotEndTime = normalizeDate(bookingDto.getEndDateTime(), offering.getHourlyBookingAllowed());
        Long numberOfRequiredSlots = calculateNumberOfRequiredSlots(slotStartTime, slotEndTime, offering.getHourlyBookingAllowed());

        booking.setListOfBookedSlots(getRequiredSlots(bookingDto, slotStartTime, slotEndTime, numberOfRequiredSlots));
        booking.setTotalCost(booking.getListOfBookedSlots().size() * offering.getCost());

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
            }else {
                List<Slots> slotListWithSameUniqueId = new ArrayList<>();
                slotListWithSameUniqueId.add(e);
                slotMap.put(e.getUniqueId(), slotListWithSameUniqueId);
            }
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
            return ChronoUnit.HOURS.between(startDate, endDate);
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


    private Booking initializeBooking(BookingDTO bookingDTO){
        Booking booking = new Booking();
        booking.setActive(true);
        booking.setPaymentStatus(false);
        booking.setCreatedAt(LocalDateTime.now());
        booking.setStartDate(bookingDTO.getStartDateTime());
        booking.setEndDate(bookingDTO.getEndDateTime());

        booking.setUserDetails( userService.findUser(bookingDTO.getUserId()));
        booking.setOfferingDetail( offeringService.getOfferingById(bookingDTO.getOfferingId()));
        return booking;
    }


    @Transactional
    private List<Slots> getRequiredSlots(BookingDTO bookingDto, LocalDateTime slotStartTime, LocalDateTime slotEndTime, Long  numberOfRequiredSlots){
        List<Slots> listOfSlots = reservationRepository.fetchAvailableSlots(bookingDto.getOfferingId(),
                slotStartTime,
                slotEndTime);
        Map<String, List<Slots>> slotMap = createSlotMap(listOfSlots);
        String uniqueId = selectUniqueIdForBooking(slotMap, numberOfRequiredSlots);
        slotMap.get(uniqueId).forEach(e->{
            e.getAvailability().setAvailable(false);
            slotService.addSlots(e);
        });
        return slotMap.get(uniqueId);
    }
}
