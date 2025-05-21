package com.ticketbooking.controller;

import com.ticketbooking.service.BookingService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

/**
 * Controller for home page and general navigation
 */
@Controller
public class HomeController {

    @Autowired
    private BookingService bookingService;

    /**
     * Home page
     */
    @GetMapping("/")
    public String home(Model model) {
        model.addAttribute("queueSize", bookingService.getQueueSize());
        model.addAttribute("totalProcessed", bookingService.getTotalProcessed());
        return "home";
    }
    
    /**
     * About page
     */
    @GetMapping("/about")
    public String about() {
        return "about";
    }
}
