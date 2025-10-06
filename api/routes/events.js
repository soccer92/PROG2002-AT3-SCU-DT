/*
	Name: Thomas Carpenter and Debralee Thompson
    Description: Events endpoint to handle event-related requests.
*/

var express = require('express');
var router = express.Router();
var db = require('../event_db'); // Database connection.

// Admin dashboard data.
// Get /api/events/admin/
router.get('/admin', function (_req, res) {
    var sql =
        "SELECT `event`.*, category.category_name, organisation.org_name " +
        "FROM `event` " +
        "JOIN category ON `event`.category_id = category.category_id " +
        "JOIN organisation ON `event`.org_id = organisation.org_id " +
        "ORDER BY `event`.event_start_dt ASC";
    
    db.query(sql, [], function (err, rows) {
        if (err) return res.status(500).json({ error: 'Database error.' });
        res.json(rows);
    });
});

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
        if (err) return res.status(500).json({ error: 'Database error.' });
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

// Delete event data.
// DELETE /api/events/:id
router.delete('/:id', function (req, res) {
    var EventID = Number(req.params.id);
    if (!Number.isInteger(EventID) || EventID <= 0) {
        return res.status(400).json({ error: 'Invalid Event ID.' });
    }

    db.beginTransaction(function (err) {
        if (err) {
            console.error('Error starting transaction:', err.message);
            return res.status(500).json({ error: 'Database error with commencing transaction.' });
        }

        var checkRegistrationEntries = "SELECT COUNT(*) AS count FROM registration WHERE event_id = ?";
        db.query(checkRegistrationEntries, [EventID], function (err, rows) {
            if (err) {
                console.error('Error checking registrations:', err.message);
                return db.rollback(function () {
                    res.status(500).json({ error: 'Database error while checking registrations.' });
                });
            }

            var registrationsExist = rows && rows.length && rows[0].count > 0;
            if (registrationsExist) {
                return db.rollback(function () {
                    res.status(400).json({
                        message: 'Event deletion has been blocked due to registrations existing with this event.'
                    });
                });
            }
            var deleteEventTicket = "DELETE FROM ticket WHERE event_id = ?";
            var deleteEvent = "DELETE FROM `event` WHERE event_id = ?";
            var deleteEventDonation = "DELETE FROM donation WHERE event_id = ?";

            db.query(deleteEventTicket, [EventID], function (err, result) {
                if (err) {
                    console.error('Error deleting tickets:', err.message);
                    return db.rollback(function () {
                        res.status(500).json({ error: 'Database error while deleting event from tickets.' });
                    });
                }

                db.query(deleteEventDonation, [EventID], function (err, result) {
                    if (err) {
                        console.error('Error deleting donations:', err.message);
                        return db.rollback(function () {
                            res.status(500).json({ error: 'Database error while deleting event from donations.' });
                        });
                    }
                    db.query(deleteEvent, [EventID], function (err, result) {
                        if (err) {
                            console.error('Error deleting event:', err.message);
                            return db.rollback(function () {
                                res.status(500).json({ error: 'Database error while deleting event.' });
                            });
                        }

                        if (result.affectedRows === 0) {
                            return db.rollback(function () {
                                res.status(404).json({ error: 'Event not found, please try again' });
                            });
                        }

                        db.commit(function (err) {
                            if (err) {
                                console.error('Error committing transaction:', err.message);
                                return db.rollback(function () {
                                    res.status(500).json({ error: 'Database error during commit.' });
                                });
                            }
                            res.json({ message: 'Event and associated data has been deleted successfully.' });
                        }
                        );
                    });
                });
            });
        });
    });
});
module.exports = router;