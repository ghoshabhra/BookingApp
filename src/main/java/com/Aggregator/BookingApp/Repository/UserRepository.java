package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

import java.util.List;

@Repository
public interface UserRepository extends MongoRepository<User, String> {
    List<User> findByEmail(String email);
    List<User> findByPhoneNumber(String phoneNumber);
}
