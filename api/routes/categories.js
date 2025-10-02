/*
	Name: Thomas Carpenter
    Student ID: 23636116
    Description: Endpoint to handle category-related requests.
*/

var express = require('express');
var router = express.Router();
var db = require('../event_db'); // Database connection.

// Get all categories.
// GET /api/categories/
router.get('/', function (_req, res) {
    var sql = "SELECT * FROM category ORDER BY category_name ASC";
    db.query(sql, [], function (err, rows) {
        if (err) return res.status(500).json({ error: 'Database error.' });
        res.json(rows);
    });
});

module.exports = router;