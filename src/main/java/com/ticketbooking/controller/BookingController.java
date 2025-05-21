package com.ticketbooking.controller;

import com.ticketbooking.model.Booking;
import com.ticketbooking.model.Movie;
import com.ticketbooking.service.BookingService;
import com.ticketbooking.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

/**
 * Controller for booking-related operations
 */
@Controller
@RequestMapping("/bookings")
public class BookingController {

    @Autowired
    private BookingService bookingService;
    
    @Autowired
    private MovieService movieService;

    /**
     * List all bookings
     */
    @GetMapping
    public String getAllBookings(Model model) {
        model.addAttribute("bookings", bookingService.getAllBookings());
        model.addAttribute("queueSize", bookingService.getQueueSize());
        return "bookings/list";
    }
    
    /**
     * Show booking form
     */
    @GetMapping("/create")
    public String showBookingForm(Model model) {
        model.addAttribute("booking", new Booking());
        model.addAttribute("movies", movieService.getAllMovies());
        return "bookings/form";
    }
    
    /**
     * Create a new booking
     */
    @PostMapping("/create")
    public String createBooking(@ModelAttribute Booking booking, RedirectAttributes redirectAttributes) {
        try {
            Booking createdBooking = bookingService.createBooking(booking);
            redirectAttributes.addFlashAttribute("message", "Booking request added to queue. Booking ID: " + createdBooking.getId());
            return "redirect:/bookings/confirmation/" + createdBooking.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to create booking: " + e.getMessage());
            return "redirect:/bookings/create";
        }
    }
    
    /**
     * Show booking confirmation
     */
    @GetMapping("/confirmation/{id}")
    public String showConfirmation(@PathVariable String id, Model model) {
        model.addAttribute("booking", new Booking());  // Empty booking for now
        model.addAttribute("bookingId", id);
        model.addAttribute("queueSize", bookingService.getQueueSize());
        model.addAttribute("queuePosition", bookingService.getQueueSize());  // Simplified
        return "bookings/confirmation";
    }
    
    /**
     * View booking details
     */
    @GetMapping("/{id}")
    public String getBookingDetails(@PathVariable String id, Model model) {
        Optional<Booking> booking = bookingService.getBookingById(id);
        if (booking.isPresent()) {
            model.addAttribute("booking", booking.get());
            return "bookings/details";
        } else {
            return "redirect:/bookings";
        }
    }
    
    /**
     * Show edit booking form
     */
    @GetMapping("/edit/{id}")
    public String showEditForm(@PathVariable String id, Model model) {
        Optional<Booking> booking = bookingService.getBookingById(id);
        if (booking.isPresent()) {
            model.addAttribute("booking", booking.get());
            model.addAttribute("movies", movieService.getAllMovies());
            return "bookings/edit";
        } else {
            return "redirect:/bookings";
        }
    }
    
    /**
     * Update a booking
     */
    @PostMapping("/edit/{id}")
    public String updateBooking(@PathVariable String id, @ModelAttribute Booking booking, RedirectAttributes redirectAttributes) {
        try {
            booking.setId(id);
            Booking updatedBooking = bookingService.updateBooking(booking);
            redirectAttributes.addFlashAttribute("message", "Booking updated successfully");
            return "redirect:/bookings/" + updatedBooking.getId();
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to update booking: " + e.getMessage());
            return "redirect:/bookings/edit/" + id;
        }
    }
    
    /**
     * Delete a booking
     */
    @GetMapping("/delete/{id}")
    public String deleteBooking(@PathVariable String id, RedirectAttributes redirectAttributes) {
        try {
            bookingService.deleteBooking(id);
            redirectAttributes.addFlashAttribute("message", "Booking deleted successfully");
        } catch (Exception e) {
            redirectAttributes.addFlashAttribute("error", "Failed to delete booking: " + e.getMessage());
        }
        return "redirect:/bookings";
    }
    
    /**
     * Show queue status
     */
    @GetMapping("/queue")
    public String showQueueStatus(Model model) {
        model.addAttribute("queueSize", bookingService.getQueueSize());
        model.addAttribute("totalProcessed", bookingService.getTotalProcessed());
        return "bookings/queue";
    }
}
