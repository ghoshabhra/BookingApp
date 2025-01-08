package com.Aggregator.BookingApp.Model;

public class Address {

    // Fields
    private String houseNumber;
    private String street;
    private String city;
    private String state;
    private String country;
    private String postalCode;
    private String googleMapLocationUrl;
    private String tag; // e.g., "Home", "Office", etc.

    // Constructor
    public Address(String houseNumber, String street, String city, String state, String country,
                   String postalCode, String googleMapLocationUrl, String tag) {
        this.houseNumber = houseNumber;
        this.street = street;
        this.city = city;
        this.state = state;
        this.country = country;
        this.postalCode = postalCode;
        this.googleMapLocationUrl = googleMapLocationUrl;
        this.tag = tag;
    }

    // Default constructor
    public Address() {
    }

    // Getters and Setters
    public String getHouseNumber() {
        return houseNumber;
    }

    public void setHouseNumber(String houseNumber) {
        this.houseNumber = houseNumber;
    }

    public String getStreet() {
        return street;
    }

    public void setStreet(String street) {
        this.street = street;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getState() {
        return state;
    }

    public void setState(String state) {
        this.state = state;
    }

    public String getCountry() {
        return country;
    }

    public void setCountry(String country) {
        this.country = country;
    }

    public String getPostalCode() {
        return postalCode;
    }

    public void setPostalCode(String postalCode) {
        this.postalCode = postalCode;
    }

    public String getGoogleMapLocationUrl() {
        return googleMapLocationUrl;
    }

    public void setGoogleMapLocationUrl(String googleMapLocationUrl) {
        this.googleMapLocationUrl = googleMapLocationUrl;
    }

    public String getTag() {
        return tag;
    }

    public void setTag(String tag) {
        this.tag = tag;
    }

    // toString method for easy display
    @Override
    public String toString() {
        return "Address{" +
                "houseNumber='" + houseNumber + '\'' +
                ", street='" + street + '\'' +
                ", city='" + city + '\'' +
                ", state='" + state + '\'' +
                ", country='" + country + '\'' +
                ", postalCode='" + postalCode + '\'' +
                ", googleMapLocationUrl='" + googleMapLocationUrl + '\'' +
                ", tag='" + tag + '\'' +
                '}';
    }

    // Equals and HashCode (optional, but recommended)
    @Override
    public boolean equals(Object o) {
        if (this == o) return true;
        if (o == null || getClass() != o.getClass()) return false;

        Address address = (Address) o;

        if (!houseNumber.equals(address.houseNumber)) return false;
        if (!street.equals(address.street)) return false;
        if (!city.equals(address.city)) return false;
        if (!state.equals(address.state)) return false;
        if (!country.equals(address.country)) return false;
        if (!postalCode.equals(address.postalCode)) return false;
        if (!googleMapLocationUrl.equals(address.googleMapLocationUrl)) return false;
        return tag.equals(address.tag);
    }

}

