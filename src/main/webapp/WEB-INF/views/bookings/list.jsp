<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-dark d-flex justify-content-between align-items-center">
        <h2 class="mb-0">Your Bookings</h2>
        <a href="<c:url value='/bookings/create' />" class="btn btn-success">New Booking</a>
    </div>
    <div class="card-body">
        <div class="card mb-4" style="background-color: rgba(0, 225, 255, 0.1);">
            <div class="card-body">
                <div class="d-flex align-items-center">
                    <div class="me-3">
                        <span class="badge bg-primary rounded-circle p-3">
                            <i class="bi bi-clock"></i> ${queueSize}
                        </span>
                    </div>
                    <div>
                        <h5 class="mb-1">Queue Status</h5>
                        <p class="mb-0">There are currently <strong>${queueSize}</strong> bookings in the queue.</p>
                    </div>
                    <div class="ms-auto">
                        <a href="<c:url value='/bookings/queue' />" class="btn btn-info btn-sm">View Queue</a>
                    </div>
                </div>
            </div>
        </div>

        <c:if test="${not empty bookings}">
            <div class="table-responsive">
                <table class="table table-hover">
                    <thead style="background-color: var(--secondary-color); color: var(--text-color);">
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
                                <td><span class="badge bg-secondary">${booking.id.substring(0, 8)}...</span></td>
                                <td>${booking.customerName}</td>
                                <td><span class="text-primary">${booking.movieTitle}</span></td>
                                <td>${booking.showTime}</td>
                                <td class="text-center"><span class="badge bg-secondary">${booking.numberOfTickets}</span></td>
                                <td class="text-primary">$${booking.totalPrice}</td>
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
            <div class="card text-center p-5">
                <div class="card-body">
                    <h4 class="mb-3">No Bookings Found</h4>
                    <p>You don't have any bookings yet.</p>
                    <a href="<c:url value='/bookings/create' />" class="btn btn-primary mt-2">Book Tickets Now</a>
                </div>
            </div>
        </c:if>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
