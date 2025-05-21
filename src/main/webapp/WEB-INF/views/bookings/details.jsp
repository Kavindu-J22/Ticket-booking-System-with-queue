<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h2>Booking Details</h2>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-8">
                <div class="card mb-4">
                    <div class="card-header bg-info text-white">
                        <h5 class="mb-0">Booking Information</h5>
                    </div>
                    <div class="card-body">
                        <table class="table table-bordered">
                            <tr>
                                <th width="30%">Booking ID</th>
                                <td>${booking.id}</td>
                            </tr>
                            <tr>
                                <th>Customer Name</th>
                                <td>${booking.customerName}</td>
                            </tr>
                            <tr>
                                <th>Movie</th>
                                <td>${booking.movieTitle}</td>
                            </tr>
                            <tr>
                                <th>Show Time</th>
                                <td>${booking.showTime}</td>
                            </tr>
                            <tr>
                                <th>Number of Tickets</th>
                                <td>${booking.numberOfTickets}</td>
                            </tr>
                            <tr>
                                <th>Total Price</th>
                                <td>$${booking.totalPrice}</td>
                            </tr>
                            <tr>
                                <th>Booking Time</th>
                                <td>${booking.bookingTime}</td>
                            </tr>
                            <tr>
                                <th>Status</th>
                                <td>
                                    <c:choose>
                                        <c:when test="${booking.status eq 'PENDING'}">
                                            <span class="badge bg-warning status-pending">PENDING</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'CONFIRMED'}">
                                            <span class="badge bg-success status-confirmed">CONFIRMED</span>
                                        </c:when>
                                        <c:when test="${booking.status eq 'CANCELLED'}">
                                            <span class="badge bg-danger status-cancelled">CANCELLED</span>
                                        </c:when>
                                        <c:otherwise>
                                            <span class="badge bg-secondary">${booking.status}</span>
                                        </c:otherwise>
                                    </c:choose>
                                </td>
                            </tr>
                        </table>
                    </div>
                </div>
            </div>
            
            <div class="col-md-4">
                <div class="card mb-4">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">Actions</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-grid gap-2">
                            <c:if test="${booking.status eq 'CONFIRMED'}">
                                <a href="<c:url value='/bookings/edit/${booking.id}' />" class="btn btn-warning">Edit Booking</a>
                            </c:if>
                            <a href="<c:url value='/bookings/delete/${booking.id}' />" class="btn btn-danger"
                               onclick="return confirm('Are you sure you want to delete this booking?')">Delete Booking</a>
                            <a href="<c:url value='/bookings' />" class="btn btn-secondary">Back to Bookings</a>
                        </div>
                    </div>
                </div>
                
                <c:if test="${booking.status eq 'PENDING'}">
                    <div class="card">
                        <div class="card-header bg-warning">
                            <h5 class="mb-0">Pending Status</h5>
                        </div>
                        <div class="card-body">
                            <p>Your booking is currently in the processing queue.</p>
                            <p>It will be processed shortly. Please check back in a few moments.</p>
                            <p>The page will refresh automatically every 10 seconds.</p>
                        </div>
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<c:if test="${booking.status eq 'PENDING'}">
    <!-- Auto-refresh for pending bookings -->
    <script>
        // Refresh the page every 10 seconds to check booking status
        setTimeout(function() {
            window.location.reload();
        }, 10000);
    </script>
</c:if>

<%@ include file="../common/footer.jsp" %>
