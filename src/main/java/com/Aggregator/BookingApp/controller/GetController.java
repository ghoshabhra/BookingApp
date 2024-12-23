package com.Aggregator.BookingApp.controller;

import com.Aggregator.BookingApp.Model.OrderModel;
import com.zerodhatech.kiteconnect.KiteConnect;
import com.zerodhatech.kiteconnect.kitehttp.SessionExpiryHook;
import com.zerodhatech.kiteconnect.kitehttp.exceptions.KiteException;
import com.zerodhatech.kiteconnect.utils.Constants;
import com.zerodhatech.models.Margin;
import com.zerodhatech.models.Order;
import com.zerodhatech.models.OrderParams;
import com.zerodhatech.models.User;
import org.springframework.web.bind.annotation.*;

import java.io.IOException;

@RestController
public class GetController {

    private String apikey = "o43amffpyl2hq267";
    private String apiSecret = "xo7d6chvf4suptx966q2zzsp4clidc2w";
    private String userId = "ZY1411";
    KiteConnect kiteSdk;
    Integer orderValue = 10000;
//iVpdTwuhYEgJZXnk48Z12yjVYGT80TD1


    @GetMapping("/hello")
    public String hello(){
        return "hello world";
    }

    @GetMapping("/Authorize")
    public String authorize(){
        kiteSdk = new KiteConnect(apikey);
        kiteSdk.setUserId(userId);
        return kiteSdk.getLoginURL();
    }

    @GetMapping("/generateSession")
    public String generateSession(@RequestParam String request_token) throws IOException, KiteException {
        User user = kiteSdk.generateSession(request_token, apiSecret);
        kiteSdk.setAccessToken(user.accessToken);
        kiteSdk.setPublicToken(user.publicToken);

        kiteSdk.setSessionExpiryHook(new SessionExpiryHook() {
            @Override
            public void sessionExpired() {
                System.out.println("session expired");
            }
        });
        return "Session token generate";
    }

    @GetMapping("/getAvailablecash")
    public String getAvailableCash() throws IOException, KiteException {
        Margin margins = kiteSdk.getMargins("equity");

        return margins.available.cash;
    }

    @PostMapping("/placeOrder")
    public String placeOrder(@RequestBody OrderModel userOrder) throws IOException, KiteException {
        OrderParams orderParams = new OrderParams();
        orderParams.quantity = (int) (orderValue/userOrder.getPrice());
        orderParams.orderType = Constants.ORDER_TYPE_LIMIT;
        orderParams.tradingsymbol = userOrder.getTradingsymbol();
        orderParams.product = Constants.PRODUCT_CNC;
        orderParams.exchange = Constants.EXCHANGE_NSE;
        orderParams.transactionType = userOrder.getTransactionType();
        orderParams.validity = Constants.VALIDITY_DAY;
        orderParams.price = userOrder.getPrice();
        orderParams.triggerPrice = 0.0;
        orderParams.tag = userOrder.getTag(); //tag is optional and it cannot be more than 8 characters and only alphanumeric is allowed

        Order order = kiteSdk.placeOrder(orderParams, Constants.VARIETY_REGULAR);
        return order.orderId;
    }


}

