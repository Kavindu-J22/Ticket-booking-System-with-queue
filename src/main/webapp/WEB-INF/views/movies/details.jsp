<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h2>${movie.title}</h2>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-8">
                <h4>Movie Details</h4>
                <table class="table table-bordered">
                    <tr>
                        <th width="30%">Genre</th>
                        <td>${movie.genre}</td>
                    </tr>
                    <tr>
                        <th>Duration</th>
                        <td>${movie.duration} minutes</td>
                    </tr>
                    <tr>
                        <th>Ticket Price</th>
                        <td>$${movie.ticketPrice}</td>
                    </tr>
                    <tr>
                        <th>Available Seats</th>
                        <td>${movie.availableSeats}</td>
                    </tr>
                </table>
                
                <h4 class="mt-4">Show Times</h4>
                <div class="row">
                    <c:forEach items="${movie.showTimes}" var="showTime">
                        <div class="col-md-4 mb-3">
                            <div class="card">
                                <div class="card-body text-center">
                                    <h5 class="card-title">${showTime}</h5>
                                    <a href="<c:url value='/bookings/create?movieId=${movie.id}&showTime=${showTime}' />" class="btn btn-success btn-sm">Book this show</a>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
            <div class="col-md-4">
                <div class="card">
                    <div class="card-header bg-success text-white">
                        <h5 class="mb-0">Book Tickets</h5>
                    </div>
                    <div class="card-body">
                        <p>Ready to watch ${movie.title}?</p>
                        <p>Book your tickets now and enjoy the show!</p>
                        <div class="d-grid gap-2">
                            <a href="<c:url value='/bookings/create?movieId=${movie.id}' />" class="btn btn-primary">Book Tickets</a>
                            <a href="<c:url value='/movies' />" class="btn btn-secondary">Back to Movies</a>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="../common/footer.jsp" %>
