<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ include file="../common/header.jsp" %>

<div class="card">
    <div class="card-header bg-primary text-dark">
        <h2 class="mb-0">Queue Status</h2>
    </div>
    <div class="card-body">
        <div class="row">
            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Current Queue</h5>
                    </div>
                    <div class="card-body text-center">
                        <div class="display-1 mb-3 text-primary">${queueSize}</div>
                        <p class="lead">Bookings currently in queue</p>
                        <div class="progress mb-3" style="height: 10px; background-color: rgba(0, 225, 255, 0.1);">
                            <div class="progress-bar bg-primary" role="progressbar" style="width: ${queueSize * 10}%"></div>
                        </div>
                        <p>Estimated processing time: <span class="badge bg-primary">~${queueSize * 5} seconds</span></p>
                    </div>
                </div>
            </div>

            <div class="col-md-6">
                <div class="card mb-4">
                    <div class="card-header bg-primary text-dark">
                        <h5 class="mb-0">Processed Bookings</h5>
                    </div>
                    <div class="card-body text-center">
                        <div class="display-1 mb-3 text-success">${totalProcessed}</div>
                        <p class="lead">Total bookings processed</p>
                        <div class="progress mb-3" style="height: 10px; background-color: rgba(0, 204, 136, 0.1);">
                            <div class="progress-bar bg-success" role="progressbar" style="width: ${totalProcessed > 0 ? 100 : 0}%"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>

        <div class="card mt-4">
            <div class="card-header bg-primary text-dark">
                <h5 class="mb-0">How Our Queue System Works</h5>
            </div>
            <div class="card-body">
                <div class="row">
                    <div class="col-md-4">
                        <div class="card mb-3 h-100" style="border-left: 4px solid var(--primary-color);">
                            <div class="card-body text-center">
                                <div class="display-4 mb-3 text-primary">1</div>
                                <h5>Submit Booking</h5>
                                <p>When you submit a booking request, it is added to our queue system.</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-3 h-100" style="border-left: 4px solid var(--primary-color);">
                            <div class="card-body text-center">
                                <div class="display-4 mb-3 text-primary">2</div>
                                <h5>Queue Processing</h5>
                                <p>Bookings are processed in order (first-come-first-served).</p>
                            </div>
                        </div>
                    </div>
                    <div class="col-md-4">
                        <div class="card mb-3 h-100" style="border-left: 4px solid var(--primary-color);">
                            <div class="card-body text-center">
                                <div class="display-4 mb-3 text-primary">3</div>
                                <h5>Confirmation</h5>
                                <p>Once processed, your booking is confirmed and seats are reserved.</p>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="card mt-3" style="background-color: rgba(0, 225, 255, 0.1); border: none;">
                    <div class="card-body">
                        <p class="mb-0"><strong>Note:</strong> Our queue system processes bookings every 5 seconds. This ensures fair and orderly processing of all booking requests.</p>
                    </div>
                </div>
            </div>
        </div>

        <div class="d-grid gap-2 d-md-flex justify-content-md-center mt-4">
            <a href="<c:url value='/bookings/create' />" class="btn btn-success me-md-2">Make a New Booking</a>
            <a href="<c:url value='/bookings' />" class="btn btn-primary me-md-2">View Your Bookings</a>
            <a href="<c:url value='/' />" class="btn btn-secondary">Return to Home</a>
        </div>
    </div>
</div>

<!-- Auto-refresh the queue status every 5 seconds -->
<script>
    setTimeout(function() {
        window.location.reload();
    }, 5000);
</script>

<%@ include file="../common/footer.jsp" %>
