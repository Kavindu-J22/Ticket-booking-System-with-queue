package com.ticketbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;

/**
 * Represents a booking in the ticket reservation system
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Booking {
    private String id;
    private String customerName;
    private String movieId;
    private String movieTitle;
    private String showTime;
    private int numberOfTickets;
    private double totalPrice;
    private LocalDateTime bookingTime;
    private String status; // PENDING, CONFIRMED, CANCELLED
    
    private static final DateTimeFormatter DATE_TIME_FORMATTER = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
    
    /**
     * Convert booking to a string format for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|")
          .append(customerName).append("|")
          .append(movieId).append("|")
          .append(movieTitle).append("|")
          .append(showTime).append("|")
          .append(numberOfTickets).append("|")
          .append(totalPrice).append("|")
          .append(bookingTime.format(DATE_TIME_FORMATTER)).append("|")
          .append(status);
        return sb.toString();
    }
    
    /**
     * Create a Booking object from a string read from file
     */
    public static Booking fromFileString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length != 9) {
            throw new IllegalArgumentException("Invalid booking data format");
        }
        
        Booking booking = new Booking();
        booking.setId(parts[0]);
        booking.setCustomerName(parts[1]);
        booking.setMovieId(parts[2]);
        booking.setMovieTitle(parts[3]);
        booking.setShowTime(parts[4]);
        booking.setNumberOfTickets(Integer.parseInt(parts[5]));
        booking.setTotalPrice(Double.parseDouble(parts[6]));
        booking.setBookingTime(LocalDateTime.parse(parts[7], DATE_TIME_FORMATTER));
        booking.setStatus(parts[8]);
        
        return booking;
    }
}
