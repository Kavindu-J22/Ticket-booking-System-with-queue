<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-warning text-dark">
        <h2>Edit Booking</h2>
    </div>
    <div class="card-body">
        <form action="<c:url value='/bookings/edit/${booking.id}' />" method="post">
            <div class="row">
                <div class="col-md-6">
                    <div class="mb-3">
                        <label for="customerName" class="form-label">Your Name</label>
                        <input type="text" class="form-control" id="customerName" name="customerName" value="${booking.customerName}" required>
                    </div>
                    
                    <div class="mb-3">
                        <label for="movieId" class="form-label">Movie</label>
                        <input type="text" class="form-control" value="${booking.movieTitle}" readonly>
                        <input type="hidden" id="movieId" name="movieId" value="${booking.movieId}">
                    </div>
                    
                    <div class="mb-3">
                        <label for="showTime" class="form-label">Show Time</label>
                        <select class="form-select" id="showTime" name="showTime" required>
                            <c:forEach items="${movies}" var="movie">
                                <c:if test="${movie.id eq booking.movieId}">
                                    <c:forEach items="${movie.showTimes}" var="showTime">
                                        <option value="${showTime}" ${booking.showTime eq showTime ? 'selected' : ''}>
                                            ${showTime}
                                        </option>
                                    </c:forEach>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>
                    
                    <div class="mb-3">
                        <label for="numberOfTickets" class="form-label">Number of Tickets</label>
                        <input type="number" class="form-control" id="numberOfTickets" name="numberOfTickets" 
                               min="1" max="10" value="${booking.numberOfTickets}" required>
                    </div>
                    
                    <!-- Hidden fields to preserve original data -->
                    <input type="hidden" name="bookingTime" value="${booking.bookingTime}">
                    <input type="hidden" name="status" value="${booking.status}">
                    <input type="hidden" name="movieTitle" value="${booking.movieTitle}">
                </div>
                
                <div class="col-md-6">
                    <div class="card mb-3">
                        <div class="card-header bg-info text-white">
                            <h5 class="mb-0">Booking Summary</h5>
                        </div>
                        <div class="card-body">
                            <p><strong>Booking ID:</strong> ${booking.id}</p>
                            <p><strong>Movie:</strong> ${booking.movieTitle}</p>
                            <p><strong>Current Show Time:</strong> ${booking.showTime}</p>
                            <p><strong>Current Number of Tickets:</strong> ${booking.numberOfTickets}</p>
                            <p><strong>Current Total Price:</strong> $${booking.totalPrice}</p>
                            <p><strong>Status:</strong> 
                                <span class="badge bg-success status-confirmed">CONFIRMED</span>
                            </p>
                        </div>
                    </div>
                    
                    <div class="alert alert-warning">
                        <p><strong>Note:</strong> Editing a booking may result in price changes if the number of tickets is modified.</p>
                    </div>
                </div>
            </div>
            
            <div class="d-grid gap-2 d-md-flex justify-content-md-end mt-4">
                <a href="<c:url value='/bookings/${booking.id}' />" class="btn btn-secondary me-md-2">Cancel</a>
                <button type="submit" class="btn btn-warning">Update Booking</button>
            </div>
        </form>
    </div>
</div>

<!-- JavaScript for dynamic price calculation -->
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
            ]
        }${!status.last ? ',' : ''}
        </c:forEach>
    ];
    
    // Update total price when number of tickets changes
    document.getElementById('numberOfTickets').addEventListener('change', function() {
        const movieId = "${booking.movieId}";
        const numberOfTickets = parseInt(this.value) || 0;
        
        if (movieId) {
            const selectedMovie = movies.find(movie => movie.id === movieId);
            if (selectedMovie) {
                const totalPrice = selectedMovie.price * numberOfTickets;
                document.querySelector('p:contains("Current Total Price")').textContent = 
                    `Current Total Price: $${totalPrice.toFixed(2)}`;
            }
        }
    });
</script>

<%@ include file="../common/footer.jsp" %>
