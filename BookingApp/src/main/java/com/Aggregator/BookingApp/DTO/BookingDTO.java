package com.Aggregator.BookingApp.DTO;


import java.time.LocalDateTime;
import java.util.Date;

public class BookingDTO {
    private String userId;
    private String offeringId;
    private LocalDateTime startDateTime;
    private LocalDateTime endDateTime;
    private Double totalAmount;
    private Integer durationUnits;
    private Boolean HourlyBooking;

    public String getUserId() {
        return userId;
    }

    public void setUserId(String userId) {
        this.userId = userId;
    }

    public String getOfferingId() {
        return offeringId;
    }

    public void setOfferingId(String offeringID) {
        this.offeringId = offeringID;
    }

    public LocalDateTime getStartDateTime() {
        return startDateTime;
    }

    public void setStartDateTime(LocalDateTime startDateTime) {
        this.startDateTime = startDateTime;
    }

    public LocalDateTime getEndDateTime() {
        return endDateTime;
    }

    public void setEndDateTime(LocalDateTime endDateTime) {
        this.endDateTime = endDateTime;
    }

    public Double getTotalAmount() {
        return totalAmount;
    }

    public void setTotalAmount(Double totalAmount) {
        this.totalAmount = totalAmount;
    }

    public Integer getDurationUnits() {
        return durationUnits;
    }

    public void setDurationUnits(Integer durationUnits) {
        this.durationUnits = durationUnits;
    }

    public Boolean getHourlyBooking() {
        return HourlyBooking;
    }

    public void setHourlyBooking(Boolean hourlyBooking) {
        HourlyBooking = hourlyBooking;
    }
}
