package com.Aggregator.BookingApp.Model;

import org.springframework.data.annotation.Id;
import org.springframework.data.mongodb.core.mapping.Document;

@Document(collation = "offerings")
public class Offering {
    @Id
    private String id;
    private String name;
    private String type;
    private String cost;
    private String image;
}
