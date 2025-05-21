<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-white">
        <h2>About Movie Ticket Reservation System</h2>
    </div>
    <div class="card-body">
        <h5 class="card-title">System Overview</h5>
        <p class="card-text">
            This is a simple web application that enables users to reserve movie tickets and manages the booking requests 
            using a queue system to ensure orderly processing.
        </p>
        
        <h5 class="card-title mt-4">Core Components</h5>
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-header bg-info text-white">
                        Ticket Reservation System
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>Users can select a movie, show time, and number of tickets</li>
                            <li>Each booking request is added to a queue and processed in order</li>
                            <li>Booked tickets are saved to a file (bookings.txt)</li>
                            <li>Queue ensures fair and first-come-first-served booking</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-header bg-success text-white">
                        Main Features
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>Create a new ticket reservation request</li>
                            <li>Read/View all booked tickets</li>
                            <li>Update existing bookings (e.g., change seat or show time)</li>
                            <li>Delete a booking</li>
                            <li>Queue System for processing bookings sequentially</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
        
        <h5 class="card-title mt-4">Technology Stack</h5>
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-header bg-secondary text-white">
                        Backend
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>Java</li>
                            <li>Spring Boot</li>
                            <li>Servlets</li>
                            <li>File-based CRUD (Read/Write to .txt files)</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="col-md-6">
                <div class="card mb-3">
                    <div class="card-header bg-secondary text-white">
                        Frontend
                    </div>
                    <div class="card-body">
                        <ul>
                            <li>JSP (JavaServer Pages)</li>
                            <li>HTML/CSS</li>
                            <li>JavaScript</li>
                            <li>Bootstrap for responsive design</li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
</div>

<%@ include file="common/footer.jsp" %>
