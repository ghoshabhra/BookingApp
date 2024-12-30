package com.Aggregator.BookingApp.Model;


import java.util.Date;

public class Availability {
    private Date date;
    private boolean isAvailable;

    // Constructor
    public Availability(Date date, boolean isAvailable) {
        this.date = date;
        this.isAvailable = isAvailable;
    }

    // Default constructor
    public Availability() {}

    // Getters and Setters
    public Date getDate() {
        return date;
    }

    public void setDate(Date date) {
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
