package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.DTO.ListOfOfferingDTO;
import com.Aggregator.BookingApp.Model.Offering;
import com.Aggregator.BookingApp.Model.Slots;
import com.Aggregator.BookingApp.service.OfferingService;
import com.Aggregator.BookingApp.service.SlotService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/admin")
public class OfferingsController {

    @Autowired
    OfferingService offeringService;

    @Autowired
    SlotService slotService;

    @GetMapping("/offerings")
    public ListOfOfferingDTO getOfferings(){
        return offeringService.getAllOffering();
    }


    @PostMapping("/offerings")
    public Offering createOffering(@RequestBody Offering offering){
        return offeringService.createNewOffering(offering);
    }

    @DeleteMapping("/offerings/{id}")
    public void deleteOffering(@RequestParam String id){
        offeringService.deleteExisitngOffering(id);
    }

    @GetMapping("/offerings/{id}")
    public Offering getOfferingById(@RequestParam String id){
        return offeringService.getOfferingById(id);
    }

    @PostMapping("/offerings/slots")
    public Slots createSlots(@RequestBody Slots slots){
        return slotService.addSlots(slots);
    }

    @DeleteMapping("/offerings/slots/{id}")
    public void deleteSlots(@RequestParam String id){
        slotService.deleteSlots(id);
    }


}
