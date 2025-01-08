package com.Aggregator.BookingApp.DTO;

import com.Aggregator.BookingApp.Model.Offering;

import java.util.List;

public class ListOfOfferingDTO {

    private Integer total_count;
    private List<Offering> results;

    public Integer getTotal_count() {
        return total_count;
    }

    public void setTotal_count(Integer total_count) {
        this.total_count = total_count;
    }

    public List<Offering> getResults() {
        return results;
    }

    public void setResults(List<Offering> results) {
        this.results = results;
        this.total_count = results.size();
    }
}
