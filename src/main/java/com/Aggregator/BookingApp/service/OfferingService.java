package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.ListOfOfferingDTO;
import com.Aggregator.BookingApp.Model.Offering;


public interface OfferingService {
    public Offering createNewOffering(Offering offering);
    public void deleteExisitngOffering(String id);
    public Offering getOfferingById(String id);
    public ListOfOfferingDTO getAllOffering();
    public Offering updateExisitngOffering(Offering offering);
}
