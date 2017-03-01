
/**
 * Author:  kenziemclouth
 * Created: Jan 31, 2017
 */

INSERT INTO 
    airport (code, city, sstate, country, timezone)
VALUES
    ("ORD", "Chicago", "IL", "USA", '6'),
    ("JFK", "New York", "NY", "USA", '5'),
    ("IFC","Iowa City", "IA", "USA", '6'),
    ("ATL","Atlanta","GA","USA", '5'),
    ("SFO","San Francisco","CA","USA", '8');
    
INSERT INTO
    aircraft_type (plane_name, down_time, capacity)
VALUES
    ("Boeing787-10", 60, 330),
    ("Boing747-8", 70, 400),
    ("Airbus318", 50, 100),
    ("Airbus330-300", 75, 277);


INSERT INTO
    airplane (aircraft_type_id, num)
VALUES
    (1, 'PL10001'),
    (1, 'PL10002'),
    (1, 'PL10003'),
    (1, 'PL10004'),
    (2, 'PL20001'),
    (2, 'PL20002'),
    (2, 'PL20003'),
    (3, 'PL30001'),
    (3, 'PL30002'),
    (3, 'PL30003');


INSERT INTO
    flight (num, airplane_id, origin_code, destination_code, flight_date, duration, departure_time, arrival_time, price)
VALUES
    ("AA111", 10000, "ORD","JFK", '2017-02-28', 135, '07:00:00', '10:15:00', 300.00),
    ("AA112", 10000, "ATL","IFC", '2017-03-01', 135, '09:00:00', '11:15:00', 250.00),
    ("AA115", 10001, "JFK","ATL", '2017-02-28', 160, '12:00:00', '14:40:00', 150.00),
    ("AA116", 10003, "SFO","ORD", '2017-02-28', 250, '08:00:00', '14:10:00', 480.00),
    ("AA117", 10003, "ORD","SFO", '2017-02-28', 280, '15:15:00', '17:55:00', 480.00);


INSERT INTO
    userr (first_name, last_name, email, password, user_type, gender)
VALUES
    ("MacKenzie", "McLouth", "mackenzie-mclouth@uiowa.edu", "password", "admin", 'female'),
    ("Nickolas", "Kutsch", "nickolas-kutsch@uiowa.edu", "password", "admin", 'male'),
    ("Kyle", "Anderson", "kyle-l-anderson@uiowa.edu", "password", "admin", 'male' ),
    ("John", "Doe", "kmclooooth1320@gmail.com", "password", "employee", 'male'),
    ("Jane", "Doe", "kmclooooth1320@yahoo.com", "password", "customer", 'female'),
    ("Joe", "Schmoe", "punkrock_ohno_udidnt@yahoo.com", "password", "customer", 'male'),
    ("Scott", "Endsley", "MacKenzie.McLouth@yahoo.com", "password", "customer", 'male');


INSERT INTO 
    boarding_pass (flight_id, userr_id, seat_num, luggage_count)
VALUES
    (1, 5, '1A', 1),
    (1, 6, '2A', 1),
    (1, 7, '3A', 3),
    (1, 1, '4A', 2),
    (1, 2, '1B', 2),
    (1, 3, '2B', 1),
    (1, 4, '2C', 1);
    
