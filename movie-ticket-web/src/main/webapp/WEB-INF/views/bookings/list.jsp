<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white d-flex justify-content-between align-items-center">
        <h2 class="mb-0">Your Bookings</h2>
        <a href="<c:url value='/bookings/create' />" class="btn btn-success">New Booking</a>
    </div>
    <div class="card-body">
        <div class="alert alert-info">
            <p><strong>Queue Status:</strong> There are currently <span class="badge bg-primary">${queueSize}</span> bookings in the queue.</p>
        </div>
        
        <c:if test="${not empty bookings}">
            <div class="table-responsive">
                <table class="table table-striped table-hover">
                    <thead class="table-dark">
                        <tr>
                            <th>ID</th>
                            <th>Customer</th>
                            <th>Movie</th>
                            <th>Show Time</th>
                            <th>Tickets</th>
                            <th>Total Price</th>
                            <th>Status</th>
                            <th>Actions</th>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach items="${bookings}" var="booking">
                            <tr>
                                <td>${booking.id.substring(0, 8)}...</td>
                                <td>${booking.customerName}</td>
                                <td>${booking.movieTitle}</td>
                                <td>${booking.showTime}</td>
                                <td>${booking.numberOfTickets}</td>
                                <td>$${booking.totalPrice}</td>
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
                                <td>
                                    <div class="btn-group" role="group">
                                        <a href="<c:url value='/bookings/${booking.id}' />" class="btn btn-sm btn-info">View</a>
                                        <c:if test="${booking.status eq 'CONFIRMED'}">
                                            <a href="<c:url value='/bookings/edit/${booking.id}' />" class="btn btn-sm btn-warning">Edit</a>
                                        </c:if>
                                        <a href="<c:url value='/bookings/delete/${booking.id}' />" class="btn btn-sm btn-danger" 
                                           onclick="return confirm('Are you sure you want to delete this booking?')">Delete</a>
                                    </div>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </c:if>
        
        <c:if test="${empty bookings}">
            <div class="alert alert-warning">
                <p>You don't have any bookings yet.</p>
                <a href="<c:url value='/bookings/create' />" class="btn btn-primary mt-2">Book Tickets Now</a>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
