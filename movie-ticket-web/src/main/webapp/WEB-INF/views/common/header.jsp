<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Movie Ticket Reservation System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        body {
            padding-top: 60px;
            padding-bottom: 40px;
            background-color: #f8f9fa;
        }
        .navbar-brand {
            font-weight: bold;
        }
        .card {
            margin-bottom: 20px;
            box-shadow: 0 4px 6px rgba(0,0,0,0.1);
        }
        .movie-card {
            transition: transform 0.3s;
        }
        .movie-card:hover {
            transform: translateY(-5px);
        }
        .footer {
            margin-top: 30px;
            padding: 20px 0;
            background-color: #343a40;
            color: white;
        }
        .booking-status {
            font-weight: bold;
        }
        .status-pending {
            color: #ffc107;
        }
        .status-confirmed {
            color: #28a745;
        }
        .status-cancelled {
            color: #dc3545;
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark bg-dark fixed-top">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/' />">Movie Ticket Reservation</a>
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
                <span class="navbar-toggler-icon"></span>
            </button>
            <div class="collapse navbar-collapse" id="navbarNav">
                <ul class="navbar-nav me-auto">
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/' />">Home</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/movies' />">Movies</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/bookings' />">Bookings</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/bookings/create' />">Book Tickets</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/bookings/queue' />">Queue Status</a>
                    </li>
                    <li class="nav-item">
                        <a class="nav-link" href="<c:url value='/about' />">About</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <!-- Main Content -->
    <div class="container mt-4">
        <!-- Flash Messages -->
        <c:if test="${not empty message}">
            <div class="alert alert-success alert-dismissible fade show" role="alert">
                ${message}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
        <c:if test="${not empty error}">
            <div class="alert alert-danger alert-dismissible fade show" role="alert">
                ${error}
                <button type="button" class="btn-close" data-bs-dismiss="alert" aria-label="Close"></button>
            </div>
        </c:if>
