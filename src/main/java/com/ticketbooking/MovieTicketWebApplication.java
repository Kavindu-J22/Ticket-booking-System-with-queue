package com.ticketbooking;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class MovieTicketWebApplication {

    public static void main(String[] args) {
        SpringApplication.run(MovieTicketWebApplication.class, args);
    }
}
