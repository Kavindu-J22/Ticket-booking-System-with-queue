<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h2>Book Movie Tickets</h2>
    </div>
    <div class="card-body">
        <form action="<c:url value='/bookings/create' />" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="customerName" class="form-label">Your Name</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="movieId" class="form-label">Select Movie</label>
                        <select class="form-select" id="movieId" name="movieId" required>
                            <option value="">-- Select a Movie --</option>
                            <c:forEach items="${movies}" var="movie">
                                <option value="${movie.id}" ${param.movieId eq movie.id ? 'selected' : ''}>
                                    ${movie.title} - $${movie.ticketPrice}
                                </option>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="showTime" class="form-label">Select Show Time</label>
                        <select class="form-select" id="showTime" name="showTime" required>
                            <option value="">-- Select Show Time --</option>
                            <!-- Show times will be populated via JavaScript -->
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="numberOfTickets" class="form-label">Number of Tickets</label>
                        <input type="number" class="form-control" id="numberOfTickets" name="numberOfTickets" min="1" max="10" value="1" required>
                    </div>
                </div>
                
                <div class="col-md-6">
                    <div class="card mb-3">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Booking Summary</h5>
                        </div>
                        <div class="card-body">
                            <p><strong>Movie:</strong> <span id="summaryMovie">Please select a movie</span></p>
                            <p><strong>Show Time:</strong> <span id="summaryShowTime">Please select a show time</span></p>
                            <p><strong>Number of Tickets:</strong> <span id="summaryTickets">1</span></p>
                            <p><strong>Price per Ticket:</strong> $<span id="summaryPrice">0.00</span></p>
                            <p><strong>Total Price:</strong> $<span id="summaryTotal">0.00</span></p>
                        </div>
                    </div>
                    
                    <div class="card">
                        <div class="card-header bg-warning">
                            <h5 class="mb-0">Queue Information</h5>
                        </div>
                        <div class="card-body">
                            <p>Your booking will be added to our queue system and processed in order.</p>
                            <p>Current Queue Size: <span class="badge bg-primary">${queueSize}</span></p>
                        </div>
                    </div>
                </div>
            </div>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                <a href="<c:url value='/movies' />" class="btn btn-secondary me-md-2">Cancel</a>
                <button type="submit" class="btn btn-success">Book Tickets</button>
            </div>
        </form>
    </div>
</div>

<!-- JavaScript for dynamic form behavior -->
<script>
    // Movie data for client-side processing
    const movies = [
        <c:forEach items="${movies}" var="movie" varStatus="status">
        {
            id: "${movie.id}",
            title: "${movie.title}",
            price: ${movie.ticketPrice},
            showTimes: [
                <c:forEach items="${movie.showTimes}" var="showTime" varStatus="timeStatus">
                "${showTime}"${!timeStatus.last ? ',' : ''}
                </c:forEach>
            ],
            availableSeats: ${movie.availableSeats}
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
    
    // Update show times when movie changes
    document.getElementById('movieId').addEventListener('change', function() {
        const movieId = this.value;
        const showTimeSelect = document.getElementById('showTime');
        const summaryMovie = document.getElementById('summaryMovie');
        const summaryPrice = document.getElementById('summaryPrice');
        
        // Clear existing options
        showTimeSelect.innerHTML = '<option value="">-- Select Show Time --</option>';
        
        if (movieId) {
            const selectedMovie = movies.find(movie => movie.id === movieId);
            
            // Update summary
            summaryMovie.textContent = selectedMovie.title;
            summaryPrice.textContent = selectedMovie.price.toFixed(2);
            
            // Add show time options
            selectedMovie.showTimes.forEach(showTime => {
                const option = document.createElement('option');
                option.value = showTime;
                option.textContent = showTime;
                
                // Check if this was the show time from the URL parameter
                if (showTime === "${param.showTime}") {
                    option.selected = true;
                }
                
                showTimeSelect.appendChild(option);
            });
            
            // Trigger show time change to update summary
            if (showTimeSelect.value) {
                document.getElementById('summaryShowTime').textContent = showTimeSelect.value;
            }
            
            // Update total price
            updateTotalPrice();
        } else {
            summaryMovie.textContent = "Please select a movie";
            summaryPrice.textContent = "0.00";
        }
    });
    
    // Update summary when show time changes
    document.getElementById('showTime').addEventListener('change', function() {
        document.getElementById('summaryShowTime').textContent = this.value || "Please select a show time";
    });
    
    // Update summary when number of tickets changes
    document.getElementById('numberOfTickets').addEventListener('change', function() {
        document.getElementById('summaryTickets').textContent = this.value;
        updateTotalPrice();
    });
    
    // Calculate total price
    function updateTotalPrice() {
        const movieId = document.getElementById('movieId').value;
        const numberOfTickets = parseInt(document.getElementById('numberOfTickets').value) || 0;
        
        if (movieId) {
            const selectedMovie = movies.find(movie => movie.id === movieId);
            const totalPrice = selectedMovie.price * numberOfTickets;
            document.getElementById('summaryTotal').textContent = totalPrice.toFixed(2);
        } else {
            document.getElementById('summaryTotal').textContent = "0.00";
        }
    }
    
    // Initialize form with URL parameters if available
    window.addEventListener('DOMContentLoaded', function() {
        const movieSelect = document.getElementById('movieId');
        if (movieSelect.value) {
            movieSelect.dispatchEvent(new Event('change'));
        }
    });
</script>

<%@ include file="../common/footer.jsp" %>
