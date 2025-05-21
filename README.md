# Movie Ticket Reservation System

A Java-based web application for movie ticket reservations with a queue system to manage and process reservations sequentially.

## Tech Stack

### Backend
- Java
- Spring Boot
- Servlets

### Frontend
- JSP (JavaServer Pages)
- HTML/CSS
- JavaScript
- Bootstrap for responsive design

### Data Storage
- File-based CRUD (Read/Write to .txt files, no database)

## System Overview

This is a simple web application that enables users to reserve movie tickets and manages the booking requests using a queue system to ensure orderly processing.

### Core Components

#### Ticket Reservation System
- Users can select a movie, show time, and number of tickets
- Each booking request is added to a queue and processed in order
- Booked tickets are saved to a file (bookings.txt)
- Queue ensures fair and first-come-first-served booking

#### Main Features
- Create a new ticket reservation request
- Read/View all booked tickets
- Update existing bookings (e.g., change seat or show time)
- Delete a booking
- Queue System for processing bookings sequentially

## Getting Started

### Prerequisites
- Java 11 or higher
- Maven

### Installation

1. Clone the repository
```
git clone https://github.com/yourusername/movie-ticket-reservation.git
cd movie-ticket-reservation
```

2. Build the project
```
mvn clean install
```

3. Run the application
```
mvn spring-boot:run
```

4. Access the application
```
http://localhost:8080
```

## Project Structure

```
src/
├── main/
│   ├── java/
│   │   └── com/
│   │       └── ticketbooking/
│   │           ├── config/
│   │           ├── controller/
│   │           ├── model/
│   │           ├── service/
│   │           └── MovieTicketReservationApplication.java
│   ├── resources/
│   │   ├── static/
│   │   ├── templates/
│   │   └── application.properties
│   └── webapp/
│       └── WEB-INF/
│           └── views/
│               ├── bookings/
│               ├── movies/
│               ├── common/
│               └── home.jsp
└── test/
    └── java/
        └── com/
            └── ticketbooking/
```

## Data Storage

The application uses file-based storage for simplicity:
- `data/movies.txt` - Stores movie information
- `data/bookings.txt` - Stores booking information

## Queue System

The application implements a queue system to process booking requests:
- All booking requests enter a queue
- Queue is processed sequentially to write bookings to the file
- Processing occurs every 5 seconds

## OOP Concepts Implementation

- **Encapsulation**: All model classes use private fields with getters and setters
- **Inheritance**: Controllers and services extend base classes
- **Polymorphism**: Method overriding in service implementations
- **Composition**: Services use other services and models

## License

This project is licensed under the MIT License - see the LICENSE file for details.
