package com.Aggregator.BookingApp.Repository;

import com.Aggregator.BookingApp.Model.User;
import org.springframework.data.mongodb.repository.MongoRepository;
import org.springframework.stereotype.Repository;

@Repository
public interface UserRepository extends MongoRepository<User, String> {
    // Define custom query methods if needed
//    User findByUsername(String username);
}
