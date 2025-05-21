<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-success text-white">
        <h2>Booking Confirmation</h2>
    </div>
    <div class="card-body">
        <div class="alert alert-success">
            <h4 class="alert-heading">Thank you for your booking!</h4>
            <p>Your booking request has been added to our queue and will be processed shortly.</p>
            <hr>
            <p class="mb-0">Booking ID: <strong>${bookingId}</strong></p>
        </div>
        
        <div class="row mt-4">
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-primary text-white">
                        <h5 class="mb-0">Queue Status</h5>
                    </div>
                    <div class="card-body">
                        <p>Your booking is in our processing queue.</p>
                        <p>Current Queue Size: <span class="badge bg-primary">${queueSize}</span></p>
                        <p>Your Position: <span class="badge bg-info">${queuePosition}</span></p>
                        <p>Estimated Processing Time: <span class="badge bg-secondary">~${queuePosition * 5} seconds</span></p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">What's Next?</h5>
                    </div>
                    <div class="card-body">
                        <p>Your booking will be processed automatically by our queue system.</p>
                        <p>Once processed, you can view your booking details and status.</p>
                        <p>You will be able to update or cancel your booking if needed.</p>
                    </div>
                </div>
            </div>
        </div>
        
        <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
            <a href="<c:url value='/bookings' />" class="btn btn-primary me-md-2">View All Bookings</a>
            <a href="<c:url value='/bookings/queue' />" class="btn btn-info me-md-2">Check Queue Status</a>
            <a href="<c:url value='/' />" class="btn btn-secondary">Return to Home</a>
        </div>
    </div>
</div>

<!-- Auto-refresh to check booking status -->
<script>
    // Refresh the page every 10 seconds to check booking status
    setTimeout(function() {
        window.location.href = "<c:url value='/bookings' />";
    }, 10000);
</script>

<%@ include file="../common/footer.jsp" %>
