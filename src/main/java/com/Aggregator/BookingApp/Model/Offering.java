package com.Aggregator.BookingApp.Model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

import java.sql.Time;
import java.util.List;

@Document(collection = "offering")
public class Offering {
    @Id
    private String id;
    private String name;
    private String type;
    private String description;
    private Float cost;
    private String imageUrl;
    private Boolean hourlyBookingAllowed;
    private Time serviceStart; // these 2 fields are for grooming, walking pet taxi etc which are not available for 24*7
    private Time serviceEnd;
    private List<String> features;


    public String getId() {
        return id;
    }

    public void setId(String id) {
        this.id = id;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public Float getCost() {
        return cost;
    }

    public void setCost(Float cost) {
        this.cost = cost;
    }

    public String getImageUrl() {
        return imageUrl;
    }

    public void setImageUrl(String imageUrl) {
        this.imageUrl = imageUrl;
    }

    public Boolean getHourlyBookingAllowed() {
        return hourlyBookingAllowed;
    }

    public void setHourlyBookingAllowed(Boolean hourlyBookingAllowed) {
        this.hourlyBookingAllowed = hourlyBookingAllowed;
    }

    public Time getServiceStart() {
        return serviceStart;
    }

    public void setServiceStart(Time serviceStart) {
        this.serviceStart = serviceStart;
    }

    public Time getServiceEnd() {
        return serviceEnd;
    }

    public void setServiceEnd(Time serviceEnd) {
        this.serviceEnd = serviceEnd;
    }

    public List<String> getFeatures() {
        return features;
    }

    public void setFeatures(List<String> features) {
        this.features = features;
    }
}
