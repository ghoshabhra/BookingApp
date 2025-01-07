package com.Aggregator.BookingApp.Model;


import java.time.LocalDateTime;
import java.util.Date;

public class Availability {
    private LocalDateTime date;
    private boolean isAvailable;

    // Constructor
    public Availability(LocalDateTime date, boolean isAvailable) {
        this.date = date;
        this.isAvailable = isAvailable;
    }

    // Default constructor
    public Availability() {}

    // Getters and Setters
    public LocalDateTime getDate() {
        return date;
    }

    public void setDate(LocalDateTime date) {
        this.date = date;
    }

    public boolean isAvailable() {
        return isAvailable;
    }

    public void setAvailable(boolean available) {
        isAvailable = available;
    }

    // toString method
    @Override
    public String toString() {
        return "Availability{" +
                "date='" + date.toString() + '\'' +
                ", isAvailable=" + isAvailable +
                '}';
    }
}
