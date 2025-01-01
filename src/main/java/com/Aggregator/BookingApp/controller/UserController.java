package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.Model.User;
import com.Aggregator.BookingApp.service.UserService;
import io.swagger.v3.oas.annotations.Parameter;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;

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

    @DeleteMapping
    public void deleteUser(String id){
        userService.deleteUser(id);
    }
}
