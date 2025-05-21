import java.io.File;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.Scanner;

public class RunMovieTicketSystem {
    private static final String DATA_DIR = "data";
    private static final String MOVIES_FILE = DATA_DIR + "/movies.txt";
    private static final String BOOKINGS_FILE = DATA_DIR + "/bookings.txt";
    
    private static List<Movie> movies = new ArrayList<>();
    private static List<Booking> bookings = new ArrayList<>();
    private static BookingQueue bookingQueue = new BookingQueue();
    
    public static void main(String[] args) {
        System.out.println("Movie Ticket Reservation System");
        System.out.println("===============================");
        
        // Initialize data directory and files
        initializeDataFiles();
        
        // Load sample data if needed
        if (loadMovies().isEmpty()) {
            createSampleMovies();
        } else {
            movies = loadMovies();
        }
        
        bookings = loadBookings();
        
        // Start the booking processor thread
        Thread bookingProcessor = new Thread(() -> {
            while (true) {
                processBookingQueue();
                try {
                    Thread.sleep(5000); // Process every 5 seconds
                } catch (InterruptedException e) {
                    e.printStackTrace();
                }
            }
        });
        bookingProcessor.setDaemon(true);
        bookingProcessor.start();
        
        // Main menu
        Scanner scanner = new Scanner(System.in);
        boolean running = true;
        
        while (running) {
            System.out.println("\nMain Menu:");
            System.out.println("1. View Movies");
            System.out.println("2. Book Tickets");
            System.out.println("3. View Bookings");
            System.out.println("4. Queue Status");
            System.out.println("5. Exit");
            System.out.print("Enter your choice: ");
            
            int choice = scanner.nextInt();
            scanner.nextLine(); // Consume newline
            
            switch (choice) {
                case 1:
                    displayMovies();
                    break;
                case 2:
                    bookTickets(scanner);
                    break;
                case 3:
                    displayBookings();
                    break;
                case 4:
                    displayQueueStatus();
                    break;
                case 5:
                    running = false;
                    System.out.println("Thank you for using Movie Ticket Reservation System!");
                    break;
                default:
                    System.out.println("Invalid choice. Please try again.");
            }
        }
        
        scanner.close();
    }
    
    private static void initializeDataFiles() {
        try {
            // Create data directory if it doesn't exist
            Files.createDirectories(Paths.get(DATA_DIR));
            
            // Create movies file if it doesn't exist
            File moviesFile = new File(MOVIES_FILE);
            if (!moviesFile.exists()) {
                moviesFile.createNewFile();
            }
            
            // Create bookings file if it doesn't exist
            File bookingsFile = new File(BOOKINGS_FILE);
            if (!bookingsFile.exists()) {
                bookingsFile.createNewFile();
            }
        } catch (IOException e) {
            System.err.println("Error initializing data files: " + e.getMessage());
        }
    }
    
    private static void createSampleMovies() {
        Movie movie1 = new Movie("1", "Avengers: Endgame", "Action/Sci-Fi", 181, 
                Arrays.asList("10:00 AM", "2:00 PM", "6:00 PM", "9:30 PM"), 12.99, 100);
        
        Movie movie2 = new Movie("2", "The Shawshank Redemption", "Drama", 142, 
                Arrays.asList("11:00 AM", "3:00 PM", "7:00 PM"), 10.99, 80);
        
        Movie movie3 = new Movie("3", "Inception", "Sci-Fi/Thriller", 148, 
                Arrays.asList("12:00 PM", "4:00 PM", "8:00 PM"), 11.99, 90);
        
        movies.add(movie1);
        movies.add(movie2);
        movies.add(movie3);
        
        saveMovies();
    }
    
    private static List<Movie> loadMovies() {
        List<Movie> loadedMovies = new ArrayList<>();
        try {
            List<String> lines = Files.readAllLines(Paths.get(MOVIES_FILE));
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.split("\\|");
                    if (parts.length == 7) {
                        String id = parts[0];
                        String title = parts[1];
                        String genre = parts[2];
                        int duration = Integer.parseInt(parts[3]);
                        List<String> showTimes = Arrays.asList(parts[4].split(","));
                        double ticketPrice = Double.parseDouble(parts[5]);
                        int availableSeats = Integer.parseInt(parts[6]);
                        
                        Movie movie = new Movie(id, title, genre, duration, showTimes, ticketPrice, availableSeats);
                        loadedMovies.add(movie);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading movies: " + e.getMessage());
        }
        return loadedMovies;
    }
    
    private static void saveMovies() {
        try {
            List<String> lines = new ArrayList<>();
            for (Movie movie : movies) {
                StringBuilder sb = new StringBuilder();
                sb.append(movie.getId()).append("|")
                  .append(movie.getTitle()).append("|")
                  .append(movie.getGenre()).append("|")
                  .append(movie.getDuration()).append("|")
                  .append(String.join(",", movie.getShowTimes())).append("|")
                  .append(movie.getTicketPrice()).append("|")
                  .append(movie.getAvailableSeats());
                lines.add(sb.toString());
            }
            Files.write(Paths.get(MOVIES_FILE), lines);
        } catch (IOException e) {
            System.err.println("Error saving movies: " + e.getMessage());
        }
    }
    
    private static List<Booking> loadBookings() {
        List<Booking> loadedBookings = new ArrayList<>();
        try {
            List<String> lines = Files.readAllLines(Paths.get(BOOKINGS_FILE));
            for (String line : lines) {
                if (!line.trim().isEmpty()) {
                    String[] parts = line.split("\\|");
                    if (parts.length == 9) {
                        Booking booking = Booking.fromFileString(line);
                        loadedBookings.add(booking);
                    }
                }
            }
        } catch (IOException e) {
            System.err.println("Error loading bookings: " + e.getMessage());
        }
        return loadedBookings;
    }
    
    private static void saveBooking(Booking booking) {
        try {
            Files.write(Paths.get(BOOKINGS_FILE), 
                    Arrays.asList(booking.toFileString()), 
                    java.nio.file.StandardOpenOption.APPEND);
            bookings.add(booking);
        } catch (IOException e) {
            System.err.println("Error saving booking: " + e.getMessage());
        }
    }
    
    private static void displayMovies() {
        System.out.println("\nAvailable Movies:");
        System.out.println("================");
        
        for (Movie movie : movies) {
            System.out.println("ID: " + movie.getId());
            System.out.println("Title: " + movie.getTitle());
            System.out.println("Genre: " + movie.getGenre());
            System.out.println("Duration: " + movie.getDuration() + " minutes");
            System.out.println("Show Times: " + String.join(", ", movie.getShowTimes()));
            System.out.println("Ticket Price: $" + movie.getTicketPrice());
            System.out.println("Available Seats: " + movie.getAvailableSeats());
            System.out.println("------------------------------");
        }
    }
    
    private static void bookTickets(Scanner scanner) {
        displayMovies();
        
        System.out.print("\nEnter your name: ");
        String customerName = scanner.nextLine();
        
        System.out.print("Enter movie ID: ");
        String movieId = scanner.nextLine();
        
        // Find the movie
        Movie selectedMovie = null;
        for (Movie movie : movies) {
            if (movie.getId().equals(movieId)) {
                selectedMovie = movie;
                break;
            }
        }
        
        if (selectedMovie == null) {
            System.out.println("Invalid movie ID. Please try again.");
            return;
        }
        
        // Display show times
        System.out.println("Available Show Times:");
        for (int i = 0; i < selectedMovie.getShowTimes().size(); i++) {
            System.out.println((i + 1) + ". " + selectedMovie.getShowTimes().get(i));
        }
        
        System.out.print("Select show time (1-" + selectedMovie.getShowTimes().size() + "): ");
        int showTimeIndex = scanner.nextInt() - 1;
        scanner.nextLine(); // Consume newline
        
        if (showTimeIndex < 0 || showTimeIndex >= selectedMovie.getShowTimes().size()) {
            System.out.println("Invalid show time selection. Please try again.");
            return;
        }
        
        String showTime = selectedMovie.getShowTimes().get(showTimeIndex);
        
        System.out.print("Enter number of tickets (1-10): ");
        int numberOfTickets = scanner.nextInt();
        scanner.nextLine(); // Consume newline
        
        if (numberOfTickets < 1 || numberOfTickets > 10) {
            System.out.println("Invalid number of tickets. Please enter a number between 1 and 10.");
            return;
        }
        
        // Create booking
        Booking booking = new Booking();
        booking.setId(String.valueOf(System.currentTimeMillis()));
        booking.setCustomerName(customerName);
        booking.setMovieId(selectedMovie.getId());
        booking.setMovieTitle(selectedMovie.getTitle());
        booking.setShowTime(showTime);
        booking.setNumberOfTickets(numberOfTickets);
        booking.setTotalPrice(selectedMovie.getTicketPrice() * numberOfTickets);
        booking.setBookingTime(java.time.LocalDateTime.now());
        booking.setStatus("PENDING");
        
        // Add to queue
        bookingQueue.enqueue(booking);
        
        System.out.println("\nBooking added to queue!");
        System.out.println("Booking ID: " + booking.getId());
        System.out.println("Current Queue Size: " + bookingQueue.size());
    }
    
    private static void displayBookings() {
        System.out.println("\nYour Bookings:");
        System.out.println("=============");
        
        if (bookings.isEmpty()) {
            System.out.println("No bookings found.");
            return;
        }
        
        for (Booking booking : bookings) {
            System.out.println("ID: " + booking.getId());
            System.out.println("Customer: " + booking.getCustomerName());
            System.out.println("Movie: " + booking.getMovieTitle());
            System.out.println("Show Time: " + booking.getShowTime());
            System.out.println("Tickets: " + booking.getNumberOfTickets());
            System.out.println("Total Price: $" + booking.getTotalPrice());
            System.out.println("Status: " + booking.getStatus());
            System.out.println("------------------------------");
        }
    }
    
    private static void displayQueueStatus() {
        System.out.println("\nQueue Status:");
        System.out.println("=============");
        System.out.println("Current Queue Size: " + bookingQueue.size());
        System.out.println("Total Processed: " + bookingQueue.getTotalProcessed());
    }
    
    private static void processBookingQueue() {
        if (!bookingQueue.isEmpty()) {
            Booking booking = bookingQueue.dequeue();
            
            // Find the movie
            Movie movie = null;
            for (Movie m : movies) {
                if (m.getId().equals(booking.getMovieId())) {
                    movie = m;
                    break;
                }
            }
            
            if (movie != null && movie.getAvailableSeats() >= booking.getNumberOfTickets()) {
                // Update available seats
                movie.setAvailableSeats(movie.getAvailableSeats() - booking.getNumberOfTickets());
                saveMovies();
                
                // Confirm booking
                booking.setStatus("CONFIRMED");
                saveBooking(booking);
                
                System.out.println("\n[Queue Processor] Booking confirmed: " + booking.getId());
            } else {
                // Not enough seats
                booking.setStatus("CANCELLED");
                saveBooking(booking);
                
                System.out.println("\n[Queue Processor] Booking cancelled (not enough seats): " + booking.getId());
            }
        }
    }
    
    // Simple model classes
    static class Movie {
        private String id;
        private String title;
        private String genre;
        private int duration;
        private List<String> showTimes;
        private double ticketPrice;
        private int availableSeats;
        
        public Movie(String id, String title, String genre, int duration, List<String> showTimes, double ticketPrice, int availableSeats) {
            this.id = id;
            this.title = title;
            this.genre = genre;
            this.duration = duration;
            this.showTimes = showTimes;
            this.ticketPrice = ticketPrice;
            this.availableSeats = availableSeats;
        }
        
        public String getId() { return id; }
        public String getTitle() { return title; }
        public String getGenre() { return genre; }
        public int getDuration() { return duration; }
        public List<String> getShowTimes() { return showTimes; }
        public double getTicketPrice() { return ticketPrice; }
        public int getAvailableSeats() { return availableSeats; }
        
        public void setAvailableSeats(int availableSeats) { this.availableSeats = availableSeats; }
    }
    
    static class Booking {
        private String id;
        private String customerName;
        private String movieId;
        private String movieTitle;
        private String showTime;
        private int numberOfTickets;
        private double totalPrice;
        private java.time.LocalDateTime bookingTime;
        private String status;
        
        private static final java.time.format.DateTimeFormatter DATE_TIME_FORMATTER = 
                java.time.format.DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
        
        public String getId() { return id; }
        public String getCustomerName() { return customerName; }
        public String getMovieId() { return movieId; }
        public String getMovieTitle() { return movieTitle; }
        public String getShowTime() { return showTime; }
        public int getNumberOfTickets() { return numberOfTickets; }
        public double getTotalPrice() { return totalPrice; }
        public java.time.LocalDateTime getBookingTime() { return bookingTime; }
        public String getStatus() { return status; }
        
        public void setId(String id) { this.id = id; }
        public void setCustomerName(String customerName) { this.customerName = customerName; }
        public void setMovieId(String movieId) { this.movieId = movieId; }
        public void setMovieTitle(String movieTitle) { this.movieTitle = movieTitle; }
        public void setShowTime(String showTime) { this.showTime = showTime; }
        public void setNumberOfTickets(int numberOfTickets) { this.numberOfTickets = numberOfTickets; }
        public void setTotalPrice(double totalPrice) { this.totalPrice = totalPrice; }
        public void setBookingTime(java.time.LocalDateTime bookingTime) { this.bookingTime = bookingTime; }
        public void setStatus(String status) { this.status = status; }
        
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
            booking.setBookingTime(java.time.LocalDateTime.parse(parts[7], DATE_TIME_FORMATTER));
            booking.setStatus(parts[8]);
            
            return booking;
        }
    }
    
    static class BookingQueue {
        private final java.util.Queue<Booking> bookingQueue = new java.util.LinkedList<>();
        private final Object lock = new Object();
        private int totalProcessed = 0;
        
        public void enqueue(Booking booking) {
            synchronized (lock) {
                bookingQueue.add(booking);
            }
        }
        
        public Booking dequeue() {
            synchronized (lock) {
                Booking booking = bookingQueue.poll();
                if (booking != null) {
                    totalProcessed++;
                }
                return booking;
            }
        }
        
        public boolean isEmpty() {
            synchronized (lock) {
                return bookingQueue.isEmpty();
            }
        }
        
        public int size() {
            synchronized (lock) {
                return bookingQueue.size();
            }
        }
        
        public int getTotalProcessed() {
            return totalProcessed;
        }
    }
}
