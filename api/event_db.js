/*
	Name: Thomas Carpenter and Debralee Thompson
    Description: SQL Connection for the Charity Events Database.
*/
var mysql = require('mysql2');

// Initialise MySQL Connection
var connection = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    // password: 'Psy12cho!', // Change to your own password when required.
    password: 'config#1',
    database: 'charityevents_db',
    timezone: 'Australia/Sydney'
});

// Open the MySQL Connection
connection.connect((err) => {
    if (err) {
        console.error('Error connecting to the database:', err);
        return;
    }
    console.log('Connected to the MySQL database.');
});

module.exports = connection;
