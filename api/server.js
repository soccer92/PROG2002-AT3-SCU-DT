/*
	Name: Thomas Carpenter
    Student ID: 23636116
    Description: Initialising the API.
*/

var express = require('express');
var path = require('path')
var cors = require('cors'); // optional but useful for cross-origin requests

var routerEvents = require('./routes/events'); // Events URL mapping.
var routerCategories = require('./routes/categories'); // Categories URL mapping.
var routerRegistrations = require('./routes/registrations'); // Registrations URL mapping.

var app = express();

app.use(cors()); // Middleware: allow CORS (optional but recommended)

app.use(express.json()); // Middleware: parse JSON bodies from fetch() POSTs

app.use(express.urlencoded({ extended: true })); // Middleware: parse URL-encoded form data (optional but harmless)

app.use(express.static(path.join(__dirname, '../web'))); // Serve static files from the 'web' directory.

// Routes
app.use('/api/events', routerEvents); // Map the events route.
app.use('/api/categories', routerCategories); // Map the categories route.
app.use('/api/registrations', routerRegistrations); // Map the registrations route.

app.listen(8080, () => {
    console.log('Server is running on port 8080');
});
