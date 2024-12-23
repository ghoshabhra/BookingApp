package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.Model.User;
import org.springframework.stereotype.Service;

@Service
public class UserServiceImpl implements UserService{
    @Override
    public User createUser(User usr) {
        return new User();
    }

    @Override
    public User updateUser(User usr) {
        return new User();
    }

    @Override
    public void deleteUser(String id) {

    }

    @Override
    public User findUser(String id) {
        return new User();
    }
}
