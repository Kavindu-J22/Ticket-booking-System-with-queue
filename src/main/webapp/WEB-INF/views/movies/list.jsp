<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-dark">
        <h2 class="mb-0">Available Movies</h2>
    </div>
    <div class="card-body">
        <div class="row">
            <c:forEach items="${movies}" var="movie">
                <div class="col-md-4 mb-4">
                    <div class="card movie-card h-100">
                        <div class="card-header bg-primary text-dark">
                            <h5 class="card-title mb-0">${movie.title}</h5>
                        </div>
                        <div class="card-body">
                            <div class="mb-3">
                                <span class="badge bg-secondary me-1">${movie.genre}</span>
                                <span class="badge bg-secondary">${movie.duration} min</span>
                            </div>
                            <div class="d-flex justify-content-between mb-2">
                                <span><strong>Price:</strong></span>
                                <span class="text-primary">$${movie.ticketPrice}</span>
                            </div>
                            <div class="d-flex justify-content-between mb-3">
                                <span><strong>Available Seats:</strong></span>
                                <span class="badge bg-success">${movie.availableSeats}</span>
                            </div>
                            <p class="mb-2"><strong>Show Times:</strong></p>
                            <ul class="list-group mb-3">
                                <c:forEach items="${movie.showTimes}" var="showTime">
                                    <li class="list-group-item d-flex justify-content-between align-items-center">
                                        ${showTime}
                                        <a href="<c:url value='/bookings/create?movieId=${movie.id}&showTime=${showTime}' />" class="btn btn-sm btn-success">Book</a>
                                    </li>
                                </c:forEach>
                            </ul>
                        </div>
                        <div class="card-footer">
                            <div class="d-grid gap-2">
                                <a href="<c:url value='/movies/${movie.id}' />" class="btn btn-info">View Details</a>
                                <a href="<c:url value='/bookings/create?movieId=${movie.id}' />" class="btn btn-success">Book Tickets</a>
                            </div>
                        </div>
                    </div>
                </div>
            </c:forEach>

            <c:if test="${empty movies}">
                <div class="col-12">
                    <div class="alert alert-info">
                        No movies available at the moment.
                    </div>
                </div>
            </c:if>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
