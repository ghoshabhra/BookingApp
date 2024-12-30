package com.Aggregator.BookingApp.service;

import com.Aggregator.BookingApp.Model.User;
import com.Aggregator.BookingApp.Repository.UserRepository;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.util.StringUtils;

import java.util.List;
import java.util.Optional;

@Service
public class UserServiceImpl implements UserService{

    @Autowired
    private UserRepository userRepository;

    @Override
    public User createUser(User user) {
        if(StringUtils.isEmpty(user.getRole())){
            user.setRole("USER");
        }
        return userRepository.save(user);
    }

    @Override
    public User updateUser(User updatedUser) {
        Optional<User> existingUser = userRepository.findById(updatedUser.getId());
        if (existingUser.isPresent()) {
            User user = existingUser.get();
            user.setFirstName(updatedUser.getFirstName());
            user.setLastName(updatedUser.getLastName());
            user.setEmail(updatedUser.getEmail());
            user.setPhoneNumber(updatedUser.getPhoneNumber());
            return userRepository.save(user);
        } else {
            throw new RuntimeException("User not found with ID: " + updatedUser.getId());
        }
    }

    @Override
    public void deleteUser(String id) {
        userRepository.deleteById(id);
    }

    @Override
    public User findUser(String id) {
        return userRepository.findById(id).orElse(null);
    }

    @Override
    public List<User> getaAllUsers() {
        return userRepository.findAll();
    }
}
