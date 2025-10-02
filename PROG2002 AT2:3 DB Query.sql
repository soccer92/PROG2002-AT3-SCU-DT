/*
	Name: Thomas Carpenter
    Student ID: 23636116
    Description: Query to initiate required elements for the database component of AT2.
*/

DROP DATABASE charityevents_db;

/* Initiating database for the first time. */
CREATE DATABASE charityevents_db;
use charityevents_db;

/* Create Organisation Table */
CREATE TABLE organisation (
	org_id					INT AUTO_INCREMENT,
    org_name				VARCHAR(200) NOT NULL,
    org_welcome_message		TEXT NOT NULL,
    org_mission_statement	TEXT NOT NULL,
    org_website				VARCHAR(200) NOT NULL,
    org_phone				VARCHAR(20) NOT NULL,
    org_email				VARCHAR(200) NOT NULL,
    PRIMARY KEY (org_id)
);

/* Create Category Table */
CREATE TABLE category (
	category_id				INT AUTO_INCREMENT,
    category_name			VARCHAR(200) NOT NULL,
    category_desc			VARCHAR(255) NOT NULL,
    PRIMARY KEY (category_id)
);

/* Create Event Table */
CREATE TABLE event (
	event_id				INT AUTO_INCREMENT,
    org_id					INT NOT NULL, -- FOREIGN KEY
    category_id				INT NOT NULL, -- FOREIGN KEY
    event_name				VARCHAR(255) NOT NULL,
    event_desc				TEXT NOT NULL,
    event_start_dt			DATETIME NOT NULL,
    event_end_dt			DATETIME NOT NULL,
    location_city			VARCHAR(100) NOT NULL,
    location_state			VARCHAR(50) NOT NULL,
    location_postcode		VARCHAR(20) NOT NULL,
    location_country		VARCHAR(50) NOT NULL DEFAULT 'Australia',
    goal_amount				DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (event_id),
    FOREIGN KEY (org_id) REFERENCES organisation(org_id),
    FOREIGN KEY (category_id) REFERENCES category(category_id)
);

/* Create Ticket Table */
CREATE TABLE ticket (
	ticket_id				INT AUTO_INCREMENT,
    event_id				INT NOT NULL, -- FOREIGN KEY
    ticket_price			DECIMAL(4,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (ticket_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

/* Create Donation Table */
CREATE TABLE donation (
	donation_id				INT AUTO_INCREMENT,
    event_id				INT NOT NULL, -- FOREIGN KEY
    donation_amount			DECIMAL(10,2) NOT NULL DEFAULT 0.00,
    PRIMARY KEY (donation_id),
    FOREIGN KEY (event_id) REFERENCES event(event_id)
);

/* Adding data into the tables. */
/* Organisations */
INSERT INTO organisation (org_name, org_welcome_message, org_mission_statement, org_website, org_email, org_phone) VALUES
('Macleay Valley Rail Ltd', 'Welcome to Macleay Valley Rail Ltd', 'Introducing trains to our Macleay Valley Communities', 'www.macleayvalleyrail.com.au', 'admin@macleayvalleyrail.com.au', '0422 044 712'),
('Hat Head Landcare', 'Welcome to Hat Head Landcare', 'Planting one tree at a time', 'www.hhlc.org.au', 'contact@hhlc.org.au', '0400 008 754'),
('Lifeline Mid Coast', 'Welcome to Lifeline Mid Coast', 'Caring for our most vulnerable', 'www.lifelinemidcoast.org.au', 'admin@lifelinemidcoast.org.au', '02 6562 1346'),
('Crescent Head Beach Care', 'Welcome to Crescent Head Beach Care', 'Caring for our pristine coastline!', 'www.chbc.org.au', 'chbc@chbc.org.au', '0476 553 221'),
('Gowings Foundation', 'Welcome to Gowings Foundation', 'Caring for our Mid-North Coast communities', 'www.gowings.com.au', 'info@gowings.com.au', '1300 800 500'),
('Arts Mid North Coast', 'Welcome to Arts Mid North Coast', 'Getting arts back into the MNC!', 'www.artsmidnorthcoast.com', 'contact@artsmidnorthcoast.com', '0400 443 862'),
('Carpenter Foundation', 'Welcome to the Carpenter Foundation', 'Improving access for young people on the North Coast', 'www.carpenterfoundation.com', 'contact@carpenterfoundation.com', '0488 774 221'),
('Macleay Valley Revitalisation Project', 'Welcome to the MVRP!', 'Improving the Macleay Valley, one step at a time', 'www.mvrp.org.au', 'info@mvrp.org.au', '0422 334 113');

/* Categories */
INSERT INTO category (category_name, category_desc) VALUES
('Fun Run', 'Community fun run for fundraising'),
('Gala', 'Formal dinner and charity event'),
('Auction', 'Live charity auction'),
('Concert', 'Live music ensemble');

/* Events */
INSERT INTO event (org_id, category_id, event_name, event_desc, event_start_dt, event_end_dt, location_city, location_state, location_postcode, location_country, goal_amount) VALUES
(1, (SELECT category_id FROM category WHERE category_name='Fun Run'), 'Bellbrook to Crescent Head Fun Run', 'A combined 88km fun run from the Country to the Surf.', '2025-10-15 10:00:00', '2025-10-15 18:00:00', 'Bellbrook', 'NSW', '2440', 'Australia', 100000.00),
(2, (SELECT category_id FROM category WHERE category_name='Concert'), 'Charity Concert with Guy Sebastian', 'A night in concert at Port Macquarie Glasshouse with Guy Sebastian, raising much needed funds for Hat Head Landcare.', '2025-10-04 19:00:00', '2025-10-04 22:00:00', 'Port Macquarie', 'NSW', '2440', 'Australia', 50000.00),
(3, (SELECT category_id FROM category WHERE category_name='Gala'), 'Gala Dinner at the Slim Dusty Centre', 'Gala dinner, entertainment and speakers to support young people with mental health challenges.', '2025-10-01 18:00:00', '2025-10-01 22:00:00', 'Kempsey South', 'NSW', '2440', 'Australia', 15000.00),
(4, (SELECT category_id FROM category WHERE category_name='Auction'), 'Artwork Auction at Crescent Head SLSC', 'Artwork auction to raise vital funds for Crescent Head Beach Care.', '2025-09-30 12:00:00', '2025-09-30 14:30:00', 'Crescent Head', 'NSW', '2440', 'Australia', 3000.00),
(5, (SELECT category_id FROM category WHERE category_name='Auction'), 'Sculpture Auction to Support our Flood Victims', 'Sculpture auction to support our flood affected communities.', '2025-09-22 18:30:00', '2025-09-22 20:00:00', 'Kempsey West', 'NSW', '2440', 'Australia', 1200.00),
(6, (SELECT category_id FROM category WHERE category_name='Concert'), 'Local Artists Concert to Raise Funds for Arts MNC!', 'Bandbox Theatre concert featuring Mid-North Coast Local Artists to raise funds for Arts Mid-North Coast.', '2025-09-27 19:30:00', '2025-09-27 21:30:00', 'Kempsey West', 'NSW', '2440', 'Australia', 5000.00),
(7, (SELECT category_id FROM category WHERE category_name='Gala'), 'Gala Dinner at the Kempsey Macleay RSL Club', 'Gala dinner at the Kempsey Macleay RSL Club to increase public transport on the North Coast.', '2025-10-12 18:00:00', '2025-10-12 20:30:00', 'Kempsey', 'NSW', '2440', 'Australia', 5500.00),
(8, (SELECT category_id FROM category WHERE category_name='Fun Run'), 'Kempsey Fun Run to Improve the Macleay', 'Kempsey fun run along the Eden Street Parklands to improve the Macleay Valley!', '2025-10-01 09:00:00', '2025-10-01 12:00:00', 'Kempsey', 'NSW', '2440', 'Australia', 12000.00);

/* Tickets */
INSERT INTO ticket (event_id, ticket_price) VALUES
(1, 20.00),
(2, 65.00),
(3, 95.00),
(4, 5.00),
(5, 10.00),
(6, 30.00),
(7, 80.00),
(8, 15.50);

/* Donations */
INSERT INTO donation (event_id, donation_amount) VALUES
(1, 3000.00),
(2, 500.00),
(3, 10000.00),
(4, 100.00),
(5, 100000.00),
(6, 1500.50),
(7, 1800.20),
(8, 10000.00);