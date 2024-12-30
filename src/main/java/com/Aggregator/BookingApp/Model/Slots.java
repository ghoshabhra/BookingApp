package com.Aggregator.BookingApp.Model;

import org.springframework.data.mongodb.core.mapping.Document;

import java.util.List;

@Document(collection = "slots")
public class Slots {
    // Fields
    private String id; // _id in JSON
    private String offeringId; // hotel_id in JSON
    private String type; // room_type in JSON
    private boolean hourlyBookingAllowed;
    private List<String> features;
    private List<Availability> availability;

    // Constructor
    public Slots(String id, String offeringId, String type, boolean hourlyBookingAllowed, List<String> features, List<Availability> availability) {
        this.id = id;
        this.offeringId = offeringId;
        this.type = type;
        this.hourlyBookingAllowed = hourlyBookingAllowed;
        this.features = features;
        this.availability = availability;
    }

    // Default constructor
    public Slots() {}

    // Getters and Setters
    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getOfferingId() {
        return offeringId;
    }

    public void setOfferingId(String offeringId) {
        this.offeringId = offeringId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public boolean isHourlyBookingAllowed() {
        return hourlyBookingAllowed;
    }

    public void setHourlyBookingAllowed(boolean hourlyBookingAllowed) {
        this.hourlyBookingAllowed = hourlyBookingAllowed;
    }

    public List<String> getFeatures() {
        return features;
    }

    public void setFeatures(List<String> features) {
        this.features = features;
    }

    public List<Availability> getAvailability() {
        return availability;
    }

    public void setAvailability(List<Availability> availability) {
        this.availability = availability;
    }

    // toString method
    @Override
    public String toString() {
        return "Room{" +
                "id='" + id + '\'' +
                ", hotelId='" + offeringId + '\'' +
                ", roomType='" + type + '\'' +
                ", hourlyBookingAllowed=" + hourlyBookingAllowed +
                ", features=" + features +
                ", availability=" + availability +
                '}';
    }

}
