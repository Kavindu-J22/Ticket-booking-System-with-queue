package com.ticketbooking.model;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.util.List;

/**
 * Represents a movie in the ticket booking system
 */
@Data
@NoArgsConstructor
@AllArgsConstructor
public class Movie {
    private String id;
    private String title;
    private String genre;
    private int duration; // in minutes
    private List<String> showTimes;
    private double ticketPrice;
    private int availableSeats;
    
    /**
     * Convert movie to a string format for file storage
     */
    public String toFileString() {
        StringBuilder sb = new StringBuilder();
        sb.append(id).append("|")
          .append(title).append("|")
          .append(genre).append("|")
          .append(duration).append("|")
          .append(String.join(",", showTimes)).append("|")
          .append(ticketPrice).append("|")
          .append(availableSeats);
        return sb.toString();
    }
    
    /**
     * Create a Movie object from a string read from file
     */
    public static Movie fromFileString(String line) {
        String[] parts = line.split("\\|");
        if (parts.length != 7) {
            throw new IllegalArgumentException("Invalid movie data format");
        }
        
        Movie movie = new Movie();
        movie.setId(parts[0]);
        movie.setTitle(parts[1]);
        movie.setGenre(parts[2]);
        movie.setDuration(Integer.parseInt(parts[3]));
        movie.setShowTimes(List.of(parts[4].split(",")));
        movie.setTicketPrice(Double.parseDouble(parts[5]));
        movie.setAvailableSeats(Integer.parseInt(parts[6]));
        
        return movie;
    }
}
