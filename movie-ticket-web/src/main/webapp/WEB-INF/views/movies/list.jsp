<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h2>Available Movies</h2>
    </div>
    <div class="card-body">
        <div class="row">
            <c:forEach items="${movies}" var="movie">
                <div class="col-md-4 mb-4">
                    <div class="card movie-card h-100">
                        <div class="card-header bg-dark text-white">
                            <h5 class="card-title mb-0">${movie.title}</h5>
                        </div>
                        <div class="card-body">
                            <p><strong>Genre:</strong> ${movie.genre}</p>
                            <p><strong>Duration:</strong> ${movie.duration} minutes</p>
                            <p><strong>Price:</strong> $${movie.ticketPrice}</p>
                            <p><strong>Available Seats:</strong> ${movie.availableSeats}</p>
                            <p><strong>Show Times:</strong></p>
                            <ul class="list-group mb-3">
                                <c:forEach items="${movie.showTimes}" var="showTime">
                                    <li class="list-group-item">${showTime}</li>
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
