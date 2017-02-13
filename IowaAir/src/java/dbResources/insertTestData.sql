
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
    airplane (num, down_time, capacity)
VALUES
    ("Boeing787-10", 60, 330),
    ("Boing747-8", 70, 400),
    ("Airbus318", 50, 100),
    ("Airbus330-300", 75, 277);


INSERT INTO
    flight (num, airplane_id, origin_code, destination_code, flight_date, duration, departure_time, arrival_time, price)
VALUES
    ("AA111", 1, "ORD","JFK", '2017-02-28', 135, '07:00:00', '10:15:00', 300.00),
    ("AA112", 1, "ATL","IFC", '2017-03-01', 135, '09:00:00', '11:15:00', 250.00),
    ("AA115", 2, "JFK","ATL", '2017-02-28', 160, '12:00:00', '14:40:00', 150.00),
    ("AA116", 3, "SFO","ORD", '2017-02-28', 250, '08:00:00', '14:10:00', 480.00),
    ("AA117", 3, "ORD","SFO", '2017-02-28', 280, '15:15:00', '17:55:00', 480.00);


INSERT INTO
    userr (first_name, last_name, email, password, user_type)
VALUES
    ("MacKenzie", "McLouth", "mackenzie-mlouth@uiowa.edu", "password", "admin"),
    ("Nickolas", "Kutsch", "nickolas-kutsch@uiowa.edu", "password", "admin"),
    ("Kyle", "Anderson", "kyle-l-anderson@uiowa.edu", "password", "admin" ),
    ("John", "Doe", "kmclooooth1320@gmail.com", "password", "employee"),
    ("Jane", "Doe", "kmclooooth1320@yahoo.com", "password", "customer"),
    ("Joe", "Schmoe", "punkrock_ohno_udidnt@yahoo.com", "password", "customer"),
    ("Scott", "Endsley", "MacKenzie.McLouth@yahoo.com", "password", "customer");


INSERT INTO 
    boarding_pass (flight_id, userr_id, seat_num)
VALUES
    (1, 5, '1A'),
    (1, 6, '2A'),
    (1, 7, '3A');
    
