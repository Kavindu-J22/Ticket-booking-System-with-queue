package com.ticketbooking.service;

import com.ticketbooking.model.Movie;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.util.ArrayList;
import java.util.List;
import java.util.Optional;
import java.util.UUID;
import java.util.stream.Collectors;

/**
 * Service for managing movie operations
 */
@Service
public class MovieService {

    @Autowired
    private FileService fileService;
    
    /**
     * Initialize with sample movies if none exist
     */
    @PostConstruct
    public void init() {
        if (getAllMovies().isEmpty()) {
            createSampleMovies();
        }
    }
    
    /**
     * Create sample movies for initial data
     */
    private void createSampleMovies() {
        List<Movie> sampleMovies = new ArrayList<>();
        
        Movie movie1 = new Movie();
        movie1.setId(UUID.randomUUID().toString());
        movie1.setTitle("Avengers: Endgame");
        movie1.setGenre("Action/Sci-Fi");
        movie1.setDuration(181);
        movie1.setShowTimes(List.of("10:00 AM", "2:00 PM", "6:00 PM", "9:30 PM"));
        movie1.setTicketPrice(12.99);
        movie1.setAvailableSeats(100);
        
        Movie movie2 = new Movie();
        movie2.setId(UUID.randomUUID().toString());
        movie2.setTitle("The Shawshank Redemption");
        movie2.setGenre("Drama");
        movie2.setDuration(142);
        movie2.setShowTimes(List.of("11:00 AM", "3:00 PM", "7:00 PM"));
        movie2.setTicketPrice(10.99);
        movie2.setAvailableSeats(80);
        
        Movie movie3 = new Movie();
        movie3.setId(UUID.randomUUID().toString());
        movie3.setTitle("Inception");
        movie3.setGenre("Sci-Fi/Thriller");
        movie3.setDuration(148);
        movie3.setShowTimes(List.of("12:00 PM", "4:00 PM", "8:00 PM"));
        movie3.setTicketPrice(11.99);
        movie3.setAvailableSeats(90);
        
        sampleMovies.add(movie1);
        sampleMovies.add(movie2);
        sampleMovies.add(movie3);
        
        for (Movie movie : sampleMovies) {
            saveMovie(movie);
        }
    }
    
    /**
     * Get all movies
     */
    public List<Movie> getAllMovies() {
        List<String> lines = fileService.readAllLines(fileService.getMoviesFilePath());
        return lines.stream()
                .filter(line -> !line.trim().isEmpty())
                .map(Movie::fromFileString)
                .collect(Collectors.toList());
    }
    
    /**
     * Get a movie by ID
     */
    public Optional<Movie> getMovieById(String id) {
        return getAllMovies().stream()
                .filter(movie -> movie.getId().equals(id))
                .findFirst();
    }
    
    /**
     * Save a new movie
     */
    public Movie saveMovie(Movie movie) {
        if (movie.getId() == null || movie.getId().isEmpty()) {
            movie.setId(UUID.randomUUID().toString());
        }
        fileService.appendLine(fileService.getMoviesFilePath(), movie.toFileString());
        return movie;
    }
    
    /**
     * Update an existing movie
     */
    public Movie updateMovie(Movie movie) {
        List<Movie> movies = getAllMovies();
        Optional<Movie> existingMovie = movies.stream()
                .filter(m -> m.getId().equals(movie.getId()))
                .findFirst();
        
        if (existingMovie.isPresent()) {
            fileService.updateLine(
                    fileService.getMoviesFilePath(),
                    existingMovie.get().toFileString(),
                    movie.toFileString()
            );
            return movie;
        } else {
            throw new IllegalArgumentException("Movie not found with ID: " + movie.getId());
        }
    }
    
    /**
     * Delete a movie by ID
     */
    public void deleteMovie(String id) {
        Optional<Movie> movie = getMovieById(id);
        if (movie.isPresent()) {
            fileService.deleteLine(fileService.getMoviesFilePath(), movie.get().toFileString());
        } else {
            throw new IllegalArgumentException("Movie not found with ID: " + id);
        }
    }
    
    /**
     * Update available seats for a movie
     */
    public void updateAvailableSeats(String movieId, int seatsToReduce) {
        Optional<Movie> optionalMovie = getMovieById(movieId);
        if (optionalMovie.isPresent()) {
            Movie movie = optionalMovie.get();
            int currentSeats = movie.getAvailableSeats();
            if (currentSeats >= seatsToReduce) {
                movie.setAvailableSeats(currentSeats - seatsToReduce);
                updateMovie(movie);
            } else {
                throw new IllegalStateException("Not enough seats available");
            }
        } else {
            throw new IllegalArgumentException("Movie not found with ID: " + movieId);
        }
    }
}
