package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.Model.Offering;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.List;

@RestController
@RequestMapping("/admin")
public class OfferingsController {
    @GetMapping("/offerings")
    public List<Offering> getOfferings(){
        return new ArrayList<>();
    }

    @PostMapping("/offerings")
    public Offering createOffering(){
        return new Offering();
    }

    @DeleteMapping("/offerings")
    public void deleteOffering(){

    }
}
