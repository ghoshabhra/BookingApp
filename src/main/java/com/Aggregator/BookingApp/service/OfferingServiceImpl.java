package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.ListOfOfferingDTO;
import com.Aggregator.BookingApp.Model.Offering;
import com.Aggregator.BookingApp.Repository.OfferingRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

@Service
public class OfferingServiceImpl implements OfferingService {
    @Autowired
    private OfferingRepository offeringRepository;

    @Override
    public Offering createNewOffering(Offering offering) {
        return offeringRepository.save(offering);
    }

    @Override
    public void deleteExisitngOffering(String id) {
        offeringRepository.deleteById(id);
    }

    @Override
    public Offering getOfferingById(String id) {
        return offeringRepository.findById(id).orElse(null);
    }

    @Override
    public ListOfOfferingDTO getAllOffering() {
        ListOfOfferingDTO listOfOfferingDTO = new ListOfOfferingDTO();
        listOfOfferingDTO.setResults(offeringRepository.findAll());

        return listOfOfferingDTO;
    }

    @Override           //TODO
    public Offering updateExisitngOffering(Offering offering) {
        return new Offering();
    }
}
