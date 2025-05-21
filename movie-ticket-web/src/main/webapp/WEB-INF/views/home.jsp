<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>

<div class="jumbotron bg-light p-5 rounded">
    <h1 class="display-4">Welcome to Movie Ticket Reservation</h1>
    <p class="lead">Book your favorite movies with our easy-to-use ticket reservation system.</p>
    <hr class="my-4">
    <p>Our queue system ensures fair processing of all booking requests on a first-come-first-served basis.</p>
    <div class="d-grid gap-2 d-md-flex justify-content-md-start">
        <a href="<c:url value='/movies' />" class="btn btn-primary btn-lg me-md-2">View Movies</a>
        <a href="<c:url value='/bookings/create' />" class="btn btn-success btn-lg">Book Tickets</a>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">Browse Movies</h5>
                <p class="card-text">Explore our collection of movies and find your favorite one.</p>
                <a href="<c:url value='/movies' />" class="btn btn-primary">View Movies</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">Book Tickets</h5>
                <p class="card-text">Reserve tickets for your favorite movies quickly and easily.</p>
                <a href="<c:url value='/bookings/create' />" class="btn btn-success">Book Now</a>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center">
            <div class="card-body">
                <h5 class="card-title">Queue Status</h5>
                <p class="card-text">Current Queue Size: <span class="badge bg-primary">${queueSize}</span></p>
                <p class="card-text">Total Processed: <span class="badge bg-success">${totalProcessed}</span></p>
                <a href="<c:url value='/bookings/queue' />" class="btn btn-info">View Queue</a>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
