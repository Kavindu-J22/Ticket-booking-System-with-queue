<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-dark">
        <h2 class="mb-0">About QuickFlicks</h2>
    </div>
    <div class="card-body">
        <h5 class="card-title text-primary">System Overview</h5>
        <p class="card-text">
            QuickFlicks is a modern web application that enables users to reserve movie tickets and manages the booking requests
            using a queue system to ensure orderly processing.
        </p>

        <h5 class="card-title mt-4 text-primary">Core Components</h5>
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3 h-100">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Ticket Reservation System</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Users can select a movie, show time, and number of tickets</li>
                            <li class="list-group-item">Each booking request is added to a queue and processed in order</li>
                            <li class="list-group-item">Booked tickets are saved to a file (bookings.txt)</li>
                            <li class="list-group-item">Queue ensures fair and first-come-first-served booking</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-3 h-100">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Main Features</h5>
                    </div>
                    <div class="card-body">
                        <ul class="list-group list-group-flush">
                            <li class="list-group-item">Create a new ticket reservation request</li>
                            <li class="list-group-item">Read/View all booked tickets</li>
                            <li class="list-group-item">Update existing bookings (e.g., change seat or show time)</li>
                            <li class="list-group-item">Delete a booking</li>
                            <li class="list-group-item">Queue System for processing bookings sequentially</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>

        <h5 class="card-title mt-4 text-primary">Technology Stack</h5>
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3 h-100">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Backend</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2 mb-3">
                            <span class="badge bg-secondary p-2">Java</span>
                            <span class="badge bg-secondary p-2">Spring Boot</span>
                            <span class="badge bg-secondary p-2">Servlets</span>
                            <span class="badge bg-secondary p-2">File-based CRUD</span>
                        </div>
                        <p>Our backend is built with Java and Spring Boot, providing a robust foundation for the ticket booking system. The application uses file-based storage for simplicity and portability.</p>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-3 h-100">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Frontend</h5>
                    </div>
                    <div class="card-body">
                        <div class="d-flex flex-wrap gap-2 mb-3">
                            <span class="badge bg-secondary p-2">JSP</span>
                            <span class="badge bg-secondary p-2">HTML/CSS</span>
                            <span class="badge bg-secondary p-2">JavaScript</span>
                            <span class="badge bg-secondary p-2">Bootstrap</span>
                        </div>
                        <p>The frontend uses JSP for server-side rendering, combined with modern HTML, CSS, and JavaScript. Bootstrap provides responsive design capabilities for a seamless experience across devices.</p>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
