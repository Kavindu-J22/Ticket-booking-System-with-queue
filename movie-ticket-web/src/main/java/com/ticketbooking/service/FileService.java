package com.ticketbooking.service;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.stereotype.Service;

import javax.annotation.PostConstruct;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.List;
import java.util.stream.Collectors;

/**
 * Service for handling file operations
 */
@Service
public class FileService {

    @Value("${app.storage.movies}")
    private String moviesFilePath;

    @Value("${app.storage.bookings}")
    private String bookingsFilePath;

    @PostConstruct
    public void init() {
        createDirectoryIfNotExists();
    }

    /**
     * Create data directory if it doesn't exist
     */
    private void createDirectoryIfNotExists() {
        try {
            Path moviesPath = Paths.get(moviesFilePath);
            Path bookingsPath = Paths.get(bookingsFilePath);
            
            Files.createDirectories(moviesPath.getParent());
            Files.createDirectories(bookingsPath.getParent());
            
            // Create files if they don't exist
            if (!Files.exists(moviesPath)) {
                Files.createFile(moviesPath);
            }
            
            if (!Files.exists(bookingsPath)) {
                Files.createFile(bookingsPath);
            }
        } catch (IOException e) {
            throw new RuntimeException("Failed to create data directories", e);
        }
    }

    /**
     * Read all lines from a file
     */
    public List<String> readAllLines(String filePath) {
        try {
            return Files.readAllLines(Paths.get(filePath));
        } catch (IOException e) {
            throw new RuntimeException("Failed to read from file: " + filePath, e);
        }
    }

    /**
     * Write all lines to a file
     */
    public void writeAllLines(String filePath, List<String> lines) {
        try {
            Files.write(Paths.get(filePath), lines);
        } catch (IOException e) {
            throw new RuntimeException("Failed to write to file: " + filePath, e);
        }
    }

    /**
     * Append a line to a file
     */
    public void appendLine(String filePath, String line) {
        try (BufferedWriter writer = new BufferedWriter(new FileWriter(filePath, true))) {
            writer.write(line);
            writer.newLine();
        } catch (IOException e) {
            throw new RuntimeException("Failed to append to file: " + filePath, e);
        }
    }

    /**
     * Update a specific line in a file
     */
    public void updateLine(String filePath, String oldLine, String newLine) {
        try {
            List<String> lines = Files.readAllLines(Paths.get(filePath));
            List<String> updatedLines = lines.stream()
                    .map(line -> line.equals(oldLine) ? newLine : line)
                    .collect(Collectors.toList());
            Files.write(Paths.get(filePath), updatedLines);
        } catch (IOException e) {
            throw new RuntimeException("Failed to update line in file: " + filePath, e);
        }
    }

    /**
     * Delete a specific line from a file
     */
    public void deleteLine(String filePath, String lineToDelete) {
        try {
            List<String> lines = Files.readAllLines(Paths.get(filePath));
            List<String> updatedLines = lines.stream()
                    .filter(line -> !line.equals(lineToDelete))
                    .collect(Collectors.toList());
            Files.write(Paths.get(filePath), updatedLines);
        } catch (IOException e) {
            throw new RuntimeException("Failed to delete line from file: " + filePath, e);
        }
    }

    public String getMoviesFilePath() {
        return moviesFilePath;
    }

    public String getBookingsFilePath() {
        return bookingsFilePath;
    }
}
