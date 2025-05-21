<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>

<div class="jumbotron p-5 rounded">
    <h1 class="display-4">Welcome to <span class="text-primary">QuickFlicks</span></h1>
    <p class="lead">Book your favorite movies with our easy-to-use ticket reservation system.</p>
    <hr class="my-4" style="border-color: rgba(0, 225, 255, 0.2);">
    <p>Our queue system ensures fair processing of all booking requests on a first-come-first-served basis.</p>
    <div class="d-grid gap-2 d-md-flex justify-content-md-start mt-4">
        <a href="<c:url value='/movies' />" class="btn btn-primary btn-lg me-md-2">View Movies</a>
        <a href="<c:url value='/bookings/create' />" class="btn btn-success btn-lg">Book Tickets</a>
    </div>
</div>

<div class="row mt-5">
    <div class="col-md-4">
        <div class="card text-center h-100">
            <div class="card-header bg-primary text-dark">
                <h5 class="card-title mb-0">Browse Movies</h5>
            </div>
            <div class="card-body">
                <p class="card-text">Explore our collection of movies and find your favorite one.</p>
                <div class="mt-auto">
                    <a href="<c:url value='/movies' />" class="btn btn-primary">View Movies</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center h-100">
            <div class="card-header bg-primary text-dark">
                <h5 class="card-title mb-0">Book Tickets</h5>
            </div>
            <div class="card-body">
                <p class="card-text">Reserve tickets for your favorite movies quickly and easily.</p>
                <div class="mt-auto">
                    <a href="<c:url value='/bookings/create' />" class="btn btn-success">Book Now</a>
                </div>
            </div>
        </div>
    </div>
    <div class="col-md-4">
        <div class="card text-center h-100">
            <div class="card-header bg-primary text-dark">
                <h5 class="card-title mb-0">Queue Status</h5>
            </div>
            <div class="card-body">
                <div class="d-flex justify-content-between mb-3">
                    <span>Current Queue Size:</span>
                    <span class="badge bg-primary">${queueSize}</span>
                </div>
                <div class="d-flex justify-content-between mb-3">
                    <span>Total Processed:</span>
                    <span class="badge bg-success">${totalProcessed}</span>
                </div>
                <div class="mt-auto">
                    <a href="<c:url value='/bookings/queue' />" class="btn btn-info">View Queue</a>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
