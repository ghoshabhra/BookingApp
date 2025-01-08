package com.Aggregator.BookingApp.DTO;


import java.time.LocalDateTime;
import java.util.Date;

public class BookingDTO {
    private String userId;
    private String offeringID;
    private LocalDateTime startDate;
    private LocalDateTime endDate;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOfferingID() {
        return offeringID;
    }

    public void setOfferingID(String offeringID) {
        this.offeringID = offeringID;
    }

    public LocalDateTime getStartDate() {
        return startDate;
    }

    public void setStartDate(LocalDateTime startDate) {
        this.startDate = startDate;
    }

    public LocalDateTime getEndDate() {
        return endDate;
    }

    public void setEndDate(LocalDateTime endDate) {
        this.endDate = endDate;
    }
}
