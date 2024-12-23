package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.Model.Offering;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.ArrayList;
import java.util.List;

@RestController("/admin/offerings")
public class OfferingsController {
    @GetMapping
    public List<Offering> getOfferings(){
        return new ArrayList<>();
    }

    @PostMapping
    public Offering createOffering(Offering offering){
        return new Offering();
    }

    @DeleteMapping
    public void deleteOffering(String id){
        
    }
}
