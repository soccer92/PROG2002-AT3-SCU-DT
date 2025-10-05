/*
	Name: Thomas Carpenter
    Student ID: 23636116
    Description: Events endpoint to handle event-related requests.
*/

var express = require('express');
var router = express.Router();
var db = require('../event_db'); // Database connection.

// Homepage data.
// Get /api/events/
router.get('/', function (_req, res) {
    var sql =
        "SELECT `event`.*, category.category_name, organisation.org_name " +
        "FROM `event` " +
        "JOIN category ON `event`.category_id = category.category_id " +
        "JOIN organisation ON `event`.org_id = organisation.org_id " +
        "WHERE `event`.event_end_dt >= NOW() " +
        "ORDER BY `event`.event_start_dt ASC";

    db.query(sql, [], function (err, rows) {
        if (err) return res.status(500).json({ error: 'DB error' });
        res.json(rows);
    });
});

// Search data.
// Get /api/events/search/
router.get('/search', function (req, res) {
    var date = req.query.date || null;
    var location = req.query.location || null;
    var category = req.query.category || null;

    var sql =
        "SELECT `event`.*, category.category_name, organisation.org_name " +
        "FROM `event` " +
        "JOIN category ON `event`.category_id = category.category_id " +
        "JOIN organisation ON `event`.org_id = organisation.org_id " +
        "WHERE `event`.event_end_dt >= NOW() ";
    var params = [];

    if (date) {
        sql += "AND DATE(`event`.event_start_dt) = ? ";
        params.push(date);
    }

    if (location) {
        sql += "AND `event`.location_city LIKE ? ";
        params.push('%' + location + '%');
    }

    if (category) {
        sql += "AND category.category_name = ? ";
        params.push(category);
    }

    sql += "ORDER BY `event`.event_start_dt ASC";

    db.query(sql, params, function (err, rows) {
        if (err) return res.status(500).json({ error: 'Database error.' });
        res.json(rows);
    });
});

// Event details.
// Get /api/events/
router.get('/:id', function (req, res) {
    var sql =
        "SELECT `event`.*, category.category_name, organisation.org_name, organisation.org_mission_statement, ticket.ticket_price " +
        "FROM `event` " +
        "JOIN category ON `event`.category_id = category.category_id " +
        "JOIN organisation ON `event`.org_id = organisation.org_id " +
        "LEFT JOIN ticket ON `event`.event_id = ticket.event_id " +
        "WHERE `event`.event_id = ?";
    
    db.query(sql, [req.params.id], function (err, rows) {
        if (err) return res.status(500).json({ error: 'Database error.' });
        if (rows.length === 0) return res.status(404).json({ error: 'Event not found, please try again' });
        res.json(rows[0]);
    });
});

module.exports = router;
