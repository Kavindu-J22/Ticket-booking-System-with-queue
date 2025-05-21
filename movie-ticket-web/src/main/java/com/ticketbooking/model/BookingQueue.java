package com.ticketbooking.model;

import lombok.Getter;
import org.springframework.stereotype.Component;

import java.util.LinkedList;
import java.util.Queue;
import java.util.concurrent.locks.Lock;
import java.util.concurrent.locks.ReentrantLock;

/**
 * Queue system to manage booking requests in a first-come-first-served manner
 */
@Component
public class BookingQueue {
    private final Queue<Booking> bookingQueue = new LinkedList<>();
    private final Lock queueLock = new ReentrantLock();
    
    @Getter
    private int totalProcessed = 0;
    
    /**
     * Add a booking to the queue
     */
    public void enqueue(Booking booking) {
        queueLock.lock();
        try {
            bookingQueue.add(booking);
        } finally {
            queueLock.unlock();
        }
    }
    
    /**
     * Remove and return the next booking from the queue
     */
    public Booking dequeue() {
        queueLock.lock();
        try {
            Booking booking = bookingQueue.poll();
            if (booking != null) {
                totalProcessed++;
            }
            return booking;
        } finally {
            queueLock.unlock();
        }
    }
    
    /**
     * Check if the queue is empty
     */
    public boolean isEmpty() {
        queueLock.lock();
        try {
            return bookingQueue.isEmpty();
        } finally {
            queueLock.unlock();
        }
    }
    
    /**
     * Get the current size of the queue
     */
    public int size() {
        queueLock.lock();
        try {
            return bookingQueue.size();
        } finally {
            queueLock.unlock();
        }
    }
    
    /**
     * Peek at the next booking without removing it
     */
    public Booking peek() {
        queueLock.lock();
        try {
            return bookingQueue.peek();
        } finally {
            queueLock.unlock();
        }
    }
}
