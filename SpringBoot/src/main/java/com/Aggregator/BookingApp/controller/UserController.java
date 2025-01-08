package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.DTO.LoginDTO;
import com.Aggregator.BookingApp.Model.Address;
import com.Aggregator.BookingApp.Model.User;
import com.Aggregator.BookingApp.service.UserService;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/user")
public class UserController {

    @Autowired
    UserService userService;

    @GetMapping
    public User getUser(String id){
        return userService.findUser(id);
    }

    @PostMapping
    public User addUser(@RequestBody User usr){
        return userService.createUser(usr);
    }

    @PostMapping("/login")
    public User login(@RequestBody LoginDTO loginDTO){
        return userService.authenticateUser(loginDTO);
    }

    @DeleteMapping
    public void deleteUser(String id){
        userService.deleteUser(id);
    }

    @PostMapping("/address")
    public User addAddress(String id, @RequestBody Address address){
        return userService.addAddress(id, address);
    }

    @GetMapping("/address")
    public List<Address> getAllAddress(String id){
        return userService.getAllAddresses(id);
    }

}
