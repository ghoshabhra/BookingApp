package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.Model.User;
import org.springframework.stereotype.Service;

import java.util.List;

public interface UserService {
    public User createUser(User usr);
    public User updateUser(User usr);
    public void deleteUser(String id);
    public User findUser(String  id);
    public List<User> getaAllUsers();
}
