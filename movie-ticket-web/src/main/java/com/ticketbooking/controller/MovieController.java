package com.ticketbooking.controller;

import com.ticketbooking.model.Movie;
import com.ticketbooking.service.MovieService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.Optional;

/**
 * Controller for movie-related operations
 */
@Controller
@RequestMapping("/movies")
public class MovieController {

    @Autowired
    private MovieService movieService;

    /**
     * List all movies
     */
    @GetMapping
    public String getAllMovies(Model model) {
        model.addAttribute("movies", movieService.getAllMovies());
        return "movies/list";
    }
    
    /**
     * View movie details
     */
    @GetMapping("/{id}")
    public String getMovieDetails(@PathVariable String id, Model model) {
        Optional<Movie> movie = movieService.getMovieById(id);
        if (movie.isPresent()) {
            model.addAttribute("movie", movie.get());
            return "movies/details";
        } else {
            return "redirect:/movies";
        }
    }
}
