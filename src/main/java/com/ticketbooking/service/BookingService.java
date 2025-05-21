package com.ticketbooking.service;

import com.ticketbooking.model.Booking;
import com.ticketbooking.model.BookingQueue;
import com.ticketbooking.model.Movie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing booking operations
 */
@Service
public class BookingService {

    @Autowired
    private FileService fileService;
    
    @Autowired
    private MovieService movieService;
    
    @Autowired
    private BookingQueue bookingQueue;
    
    /**
     * Create a new booking request
     */
    public Booking createBooking(Booking booking) {
        // Validate movie exists
        Optional<Movie> movie = movieService.getMovieById(booking.getMovieId());
        if (movie.isEmpty()) {
            throw new IllegalArgumentException("Movie not found with ID: " + booking.getMovieId());
        }
        
        // Set booking details
        booking.setId(UUID.randomUUID().toString());
        booking.setMovieTitle(movie.get().getTitle());
        booking.setBookingTime(LocalDateTime.now());
        booking.setStatus("PENDING");
        booking.setTotalPrice(movie.get().getTicketPrice() * booking.getNumberOfTickets());
        
        // Add to queue for processing
        bookingQueue.enqueue(booking);
        
        return booking;
    }
    
    /**
     * Get all bookings
     */
    public List<Booking> getAllBookings() {
        List<String> lines = fileService.readAllLines(fileService.getBookingsFilePath());
        return lines.stream()
                .filter(line -> !line.trim().isEmpty())
                .map(Booking::fromFileString)
                .collect(Collectors.toList());
    }
    
    /**
     * Get a booking by ID
     */
    public Optional<Booking> getBookingById(String id) {
        return getAllBookings().stream()
                .filter(booking -> booking.getId().equals(id))
                .findFirst();
    }
    
    /**
     * Get bookings by customer name
     */
    public List<Booking> getBookingsByCustomerName(String customerName) {
        return getAllBookings().stream()
                .filter(booking -> booking.getCustomerName().equalsIgnoreCase(customerName))
                .collect(Collectors.toList());
    }
    
    /**
     * Update an existing booking
     */
    public Booking updateBooking(Booking booking) {
        List<Booking> bookings = getAllBookings();
        Optional<Booking> existingBooking = bookings.stream()
                .filter(b -> b.getId().equals(booking.getId()))
                .findFirst();
        
        if (existingBooking.isPresent()) {
            fileService.updateLine(
                    fileService.getBookingsFilePath(),
                    existingBooking.get().toFileString(),
                    booking.toFileString()
            );
            return booking;
        } else {
            throw new IllegalArgumentException("Booking not found with ID: " + booking.getId());
        }
    }
    
    /**
     * Delete a booking by ID
     */
    public void deleteBooking(String id) {
        Optional<Booking> booking = getBookingById(id);
        if (booking.isPresent()) {
            fileService.deleteLine(fileService.getBookingsFilePath(), booking.get().toFileString());
            
            // Return tickets to available seats
            if (booking.get().getStatus().equals("CONFIRMED")) {
                try {
                    movieService.updateAvailableSeats(
                            booking.get().getMovieId(), 
                            -booking.get().getNumberOfTickets() // Negative to add seats back
                    );
                } catch (Exception e) {
                    // Log error but continue with deletion
                    System.err.println("Failed to return seats: " + e.getMessage());
                }
            }
        } else {
            throw new IllegalArgumentException("Booking not found with ID: " + id);
        }
    }
    
    /**
     * Process the booking queue every 5 seconds
     */
    @Scheduled(fixedRate = 5000)
    public void processBookingQueue() {
        if (!bookingQueue.isEmpty()) {
            Booking booking = bookingQueue.dequeue();
            try {
                // Check if seats are available
                Optional<Movie> movie = movieService.getMovieById(booking.getMovieId());
                if (movie.isPresent() && movie.get().getAvailableSeats() >= booking.getNumberOfTickets()) {
                    // Update available seats
                    movieService.updateAvailableSeats(booking.getMovieId(), booking.getNumberOfTickets());
                    
                    // Confirm booking
                    booking.setStatus("CONFIRMED");
                    
                    // Save to file
                    fileService.appendLine(fileService.getBookingsFilePath(), booking.toFileString());
                } else {
                    // Not enough seats
                    booking.setStatus("CANCELLED");
                    fileService.appendLine(fileService.getBookingsFilePath(), booking.toFileString());
                }
            } catch (Exception e) {
                // Handle error
                booking.setStatus("ERROR");
                fileService.appendLine(fileService.getBookingsFilePath(), booking.toFileString());
                System.err.println("Error processing booking: " + e.getMessage());
            }
        }
    }
    
    /**
     * Get current queue status
     */
    public int getQueueSize() {
        return bookingQueue.size();
    }
    
    /**
     * Get total processed bookings
     */
    public int getTotalProcessed() {
        return bookingQueue.getTotalProcessed();
    }
}
