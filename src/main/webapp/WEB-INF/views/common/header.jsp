<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>QuickFlicks - Movie Ticket Booking System</title>
    <!-- Bootstrap CSS -->
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
    <!-- Google Fonts -->
    <link href="https://fonts.googleapis.com/css2?family=Montserrat:wght@400;500;600;700&display=swap" rel="stylesheet">
    <!-- Custom CSS -->
    <style>
        :root {
            --primary-color: #00e1ff;
            --primary-dark: #00b8cc;
            --secondary-color: #121a24;
            --dark-bg: #0f1923;
            --card-bg: #1a2634;
            --text-color: #ffffff;
            --text-muted: #a0a0a0;
            --accent-color: #00e1ff;
        }

        body {
            padding-top: 60px;
            padding-bottom: 40px;
            background-color: var(--dark-bg);
            color: var(--text-color);
            font-family: 'Montserrat', sans-serif;
        }

        .navbar-brand {
            font-weight: 700;
            color: var(--primary-color) !important;
            letter-spacing: 0.5px;
        }

        .navbar-brand span {
            color: var(--text-color);
        }

        .card {
            margin-bottom: 20px;
            background-color: var(--card-bg);
            border: 1px solid rgba(0, 225, 255, 0.2);
            border-radius: 8px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
        }

        .card-header {
            border-bottom: 1px solid rgba(0, 225, 255, 0.2);
        }

        .movie-card {
            transition: transform 0.3s, box-shadow 0.3s;
        }

        .movie-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 8px 20px rgba(0, 225, 255, 0.15);
        }

        .footer {
            margin-top: 30px;
            padding: 20px 0;
            background-color: var(--secondary-color);
            color: var(--text-color);
            border-top: 1px solid rgba(0, 225, 255, 0.2);
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

        .btn-primary {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--secondary-color);
            font-weight: 600;
        }

        .btn-primary:hover, .btn-primary:focus {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: var(--secondary-color);
        }

        .btn-success {
            background-color: #00cc88;
            border-color: #00cc88;
            font-weight: 600;
        }

        .btn-info {
            background-color: var(--primary-color);
            border-color: var(--primary-color);
            color: var(--secondary-color);
            font-weight: 600;
        }

        .btn-info:hover, .btn-info:focus {
            background-color: var(--primary-dark);
            border-color: var(--primary-dark);
            color: var(--secondary-color);
        }

        .nav-link {
            color: var(--text-color) !important;
            font-weight: 500;
            padding: 0.5rem 1rem;
            transition: color 0.3s;
        }

        .nav-link:hover {
            color: var(--primary-color) !important;
        }

        .badge {
            font-weight: 600;
            padding: 0.5em 0.8em;
        }

        .bg-primary {
            background-color: var(--primary-color) !important;
            color: var(--secondary-color);
        }

        .text-primary {
            color: var(--primary-color) !important;
        }

        .alert {
            border-radius: 8px;
        }

        .jumbotron {
            background-color: var(--card-bg);
            border: 1px solid rgba(0, 225, 255, 0.2);
            border-radius: 8px;
        }

        .list-group-item {
            background-color: var(--card-bg);
            border-color: rgba(0, 225, 255, 0.2);
            color: var(--text-color);
        }

        .table {
            color: var(--text-color);
        }
    </style>
</head>
<body>
    <!-- Navigation -->
    <nav class="navbar navbar-expand-lg navbar-dark fixed-top" style="background-color: var(--secondary-color);">
        <div class="container">
            <a class="navbar-brand" href="<c:url value='/' />">Quick<span>Flicks</span></a>
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
