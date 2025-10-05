/*
    Name: Debralee Thompson
    Student ID: 24416186
    Description: Registration endpoints that handle attendee registration submissions 
    and retrieval of registrations for specific events.
*/


// Import the Express framework to handle routing and HTTP requests
var express = require('express');

// Create a new router instance to define registration-related API routes
var router = express.Router();

// Import the shared database connection from event_db.js
var db = require('../event_db');

// Import crypto module for generating secure random reference codes
const crypto = require("crypto");


// ROUTE 1: POST /api/registrations
// Insert a new attendee into the registration table
router.post('/', function (req, res) {
    // Destructure the incoming request body to extract registration form fields sent by the frontend
    const { event_id, first_name, last_name, contact_email, contact_phone, tickets_purchased } = req.body;

    // Validate incoming request data to ensure all required fields are present
    // If any mandatory field is missing send a 400 Bad Request response with an appropriate error message
    if (!event_id || !first_name || !last_name || !contact_email || !tickets_purchased) {
        return res.status(400).json({ error: 'Missing required fields.' });
    }

    // Generate a cryptographically secure registration reference before inserting
    const registrationRef = `EVT${event_id.toString().padStart(4, '0')}-${crypto.randomBytes(3).toString('hex').toUpperCase()}`;

    // Prepare the INSERT query
    const insertSql = `
        INSERT INTO registration (event_id, first_name, last_name, contact_email, contact_phone, tickets_purchased, registration_date, registration_ref)
        VALUES (?, ?, ?, ?, ?, ?, NOW(), ?)
    `;

    // Create an array of parameter values to safely insert into the SQL query (prevent SQL injection)
    // If no contact phone is provided, use NULL instead of leaving it undefined
    const params = [
        event_id, 
        first_name, 
        last_name, 
        contact_email, 
        contact_phone || null, 
        tickets_purchased,
        registrationRef    
    ];

    // Execute the query
    // Replaces the "?" placeholder in the prepared query with the params
    db.query(insertSql, params, function (err, result) {
        // Check for database errors during the query operation and if one occurs log it to the console for debuggingg and send a 500 (Internal Server Error) response back to the client
        if (err) {
            console.error("Database insert error:", err);
            return res.status(500).json({ error: 'Failed to save registration.' });
        }

        // Get the automatically generated primary key (reg_id)
        const regId = result.insertId;

        // Otherwise, send a JSON response back to the client with key registration details for use in frontend JS
        res.status(201).json({
            registration_id: regId,
            registration_ref: registrationRef,
            event_id: event_id
        });
    });
});


// ROUTE 2: GET /api/registrations/:event_id
// Retrieve all attendee records linked to a specific event from the database
router.get('/:event_id', function (req, res) {
    // Prepare the SELECT query
    // Retrieves relevant attendee details for the specified event ID ordered by registration_date in descending order
    const sql = `
        SELECT reg_id, first_name, last_name, contact_email, contact_phone, tickets_purchased, registration_date
        FROM registration
        WHERE event_id = ?
        ORDER BY registration_date DESC
    `;

    // Execute the query
    // Replaces the "?" placeholder in the prepared query with the provided event_id from the URL
    db.query(sql, [req.params.event_id], function (err, rows) {
        // Check for database errors during the query operation and if one occurs log it to the console for debuggingg and send a 500 (Internal Server Error) response back to the client
        if (err) {
            console.error("Database select error:", err);
            return res.status(500).json({ error: 'Database error while fetching attendees.' });
        }

        // If there are no attendees for this event return an empty array
        // This avoids sending a 404 and lets the frontend handle "no results" gracefully
        if (rows.length === 0) {
            return res.status(200).json([]); // Return empty list with 200 OK
        }

        // Otherwise, send the retrieved attendee data as JSON with a 200 OK response
        res.json(rows);
    });
});


// Export the router object so it can be imported and used in server.js
module.exports = router;
