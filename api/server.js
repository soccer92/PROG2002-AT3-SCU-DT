/*
	Name: Thomas Carpenter
    Student ID: 23636116
    Description: Initialising the API.
*/

var express = require('express');
var path = require('path')

var routerEvents = require('./routes/events'); // Events URL mapping.
var routerCategories = require('./routes/categories'); // Categories URL mapping.

var app = express();
app.use(express.static(path.join(__dirname, '../web'))); // Serve static files from the 'web' directory.
app.use('/api/events', routerEvents); // Map the events route.
app.use('/api/categories', routerCategories); // Map the categories route.

app.listen(8080, () => {
    console.log('Server is running on port 8080');
});