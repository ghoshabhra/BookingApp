package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.DTO.LoginDTO;
import com.Aggregator.BookingApp.Model.Address;
import com.Aggregator.BookingApp.Model.User;
import org.springframework.data.mongodb.core.aggregation.ArithmeticOperators;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {
    public User createUser(User usr);
    public User updateUser(User usr);
    public void deleteUser(String id);
    public User findUser(String  id);
    public List<User> getaAllUsers();
    public User findUserByEmail(String email);
    public User findUserByPhoneNo(String phoneNo);
    public User authenticateUser(LoginDTO loginDTO);
    public User addAddress(String id, Address address);
    public List<Address> getAllAddresses(String id);
}
