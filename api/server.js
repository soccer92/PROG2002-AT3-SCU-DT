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

app.use(express.static(path.join(__dirname, '../web/client'))); // Serve static files from the 'web' directory.
app.use('/admin', express.static('../web/admin'));  // Admin still under /admin

// Routes
app.use('/api/events', routerEvents); // Map the events route.
app.use('/api/categories', routerCategories); // Map the categories route.
app.use('/api/registrations', routerRegistrations); // Map the registrations route.

// Page routes.
app.get('/', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/client/index.html'));
});

app.get('/search', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/client/search.html'));
});

app.get('/event', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/client/event.html'));
});

app.get('/register', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/client/registration.html'));
});

app.get('/admin', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/admin/admin.html'));
});

app.get('/admin/update', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/admin/update.html'));
});

app.get('/admin/new', function (_req, res) {
    res.sendFile(path.join(__dirname, '../web/admin/new.html'));
});

app.listen(8080, () => {
    console.log('Server is running on port 8080');
});