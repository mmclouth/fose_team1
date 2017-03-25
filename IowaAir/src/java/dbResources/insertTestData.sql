
/**
 * Author:  kenziemclouth
 * Created: Jan 31, 2017
 */

INSERT INTO 
    airport (code, city, sstate, country, timezone, node_num)
VALUES
    ("IFC","Iowa City", "IA", "USA", '6', 1),
    ("ORD", "Chicago", "IL", "USA", '6', 2),
    ("JFK", "New York", "NY", "USA", '5', 3),
    ("ATL","Atlanta","GA","USA", '5', 4),
    ("SFO","San Francisco","CA","USA", '8', 5);
    
INSERT INTO
    aircraft_type (plane_name, down_time, capacity_total, capacity_first_class, capacity_economy, seats_per_row )
VALUES
    ("Boeing787-10", 60, 330, 35, 295, 7),
    ("Boing747-8", 70, 400, 35, 365, 7),
    ("Airbus318", 50, 100, 10, 90, 4),
    ("Airbus330-300", 75, 278, 30, 248, 6);


INSERT INTO
    airplane (aircraft_type_id, num)
VALUES
    (1, 'PL10001'),
    (1, 'PL10002'),
    (1, 'PL10003'),
    (1, 'PL10004'),
    (1, 'PL10005'),
    (1, 'PL10006'),
    (2, 'PL20001'),
    (2, 'PL20002'),
    (2, 'PL20003'),
    (2, 'PL20004'),
    (2, 'PL20005'),
    (2, 'PL20006'),
    (3, 'PL30001'),
    (3, 'PL30002'),
    (3, 'PL30003'),
    (3, 'PL30004'),
    (3, 'PL30005'),
    (3, 'PL30006'),
    (4, 'PL40001'),
    (4, 'PL40002'),
    (4, 'PL40003'),
    (4, 'PL40004'),
    (4, 'PL40005'),
    (4, 'PL40006');


INSERT INTO
    flight (num, airplane_id, origin_code, destination_code, flight_date, duration, departure_time, arrival_time, price_economy, first_class_remaining, economy_remaining, price_first_class)
VALUES
    ("AA111", 10000, "ORD","JFK", '2017-03-28', 135, '07:00:00', '10:15:00', 300.00, 26, 290, 500.00),
    ("AA112", 10000, "ATL","IFC", '2017-04-01', 135, '09:00:00', '11:15:00', 250.00, 35, 295, 400.00),
    ("AA115", 10001, "JFK","ATL", '2017-03-28', 160, '12:00:00', '14:40:00', 150.00, 35, 295, 300.00),
    ("AA116", 10003, "SFO","ORD", '2017-03-28', 250, '08:00:00', '14:10:00', 480.00, 35, 295, 600.00),
    ("AA117", 10003, "ORD","SFO", '2017-03-28', 280, '15:15:00', '17:55:00', 480.00, 35, 295, 600.00),
    ("AA118", 10000, "IFC","SFO", '2017-04-02', 345, '07:15:00', '11:00:00', 680.00, 35, 295, 850.00),
    ("AA119", 10000, "SFO","ORD", '2017-04-02', 250, '15:00:00', '21:10:00', 200.00, 35, 295, 375.00),
    ("AA120", 10002, "ATL","JFK", '2017-04-05', 130, '06:15:00', '08:25:00', 280.00, 35, 295, 420.00),
    ("AA121", 10002, "JFK","IFC", '2017-04-05', 315, '09:15:00', '13:30:00', 480.00, 35, 295, 650.00),
    ("AA122", 10002, "IFC","ORD", '2017-04-05', 70,  '14:15:00', '15:30:00', 180.00, 35, 295, 300.00),
    ("AA123", 10003, "SFO","ATL", '2017-04-05', 285, '07:15:00', '14:00:00', 500.00, 35, 295, 680.00),
    ("AA124", 10003, "ATL","JFK", '2017-04-05', 130, '15:00:00', '17:10:00', 280.00, 35, 295, 410.00),
    ("AA125", 10001, "ATL","ORD", '2017-04-05', 125, '08:00:00', '09:05:00', 300.00, 35, 295, 390.00),
    ("AA126", 10001, "ORD","IFC", '2017-04-05', 60,  '10:00:00', '11:00:00', 180.00, 35, 295, 310.00),
    ("AA127", 10004, "ORD","ATL", '2017-04-02', 130, '05:40:00', '07:50:00', 160.00, 35, 295, 240.00),
    ("AA128", 10005, "JFK","ORD", '2017-04-01', 180, '10:10:00', '13:10:00', 219.00, 35, 295, 315.00),
    ("AA129", 10006, "JFK","SFO", '2017-04-02', 400, '14:00:00', '20:40:00', 400.00, 35, 365, 500.00),
    ("AA130", 10007, "IFC","JFK", '2017-03-29', 240, '07:30:00', '11:30:00', 269.00, 35, 365, 400.00),
    ("AA131", 10008, "IFC","ATL", '2017-04-01', 130, '08:10:00', '10:20:00', 250.00, 35, 365, 415.00),
    ("AA132", 10009, "ATL","SFO", '2017-04-03', 300, '16:00:00', '21:00:00', 509.00, 35, 365, 650.00),
    ("AA133", 10010, "SFO","JFK", '2017-04-02', 380, '05:30:00', '11:50:00', 435.00, 35, 365, 600.00),
    ("AA134", 10011, "SFO","IFC", '2017-04-04', 360, '12:10:00', '18:10:00', 599.00, 35, 365, 725.00),
    ("AA135", 10012, "ATL", "SFO", '2017-04-02', 280, '22:30:00', '02:50:00', 529.00, 10, 90, 690.00),
    ("AA136", 10012, "SFO", "JFK", '2017-04-03', 360, '05:20:00', '11:20:00', 499.00, 10, 90, 600.00),
    ("AA137", 10012, "JFK","IFC", '2017-04-03', 220, '11:50:00', '03:30:00', 299.00, 10, 90, 495.00),
    ("AA138", 10013, "ATL", "IFC", '2017-04-02', 120, '22:30:00', '00:30:00', 149.00, 10, 90, 210.00),
    ("AA139", 10014, "ORD","ATL", '2017-04-01', 150, '13:00:00', '15:30:00', 119.00, 10, 90, 230.00),
    ("AA140", 10014, "ATL","IFC", '2017-04-01', 110, '16:20:00', '18:10:00', 99.00, 10, 90, 200.00),
    ("AA141", 10014, "IFC","ATL", '2017-04-05', 110, '08:00:00', '09:50:00', 99.00, 10, 90, 200.00),
    ("AA142", 10014, "ATL","ORD", '2017-04-05', 160, '11:00:00', '13:40:00', 109.00, 10, 90, 225.00),
    ("AA143", 10015, "IFC","JFK", '2017-04-03', 220, '15:20:00', '19:00:00', 259.00, 10, 90, 350.00),
    ("AA144", 10015, "JFK","IFC", '2017-04-04', 230, '05:40:00', '09:30:00', 259.00, 10, 90, 350.00),
    ("AA145", 10016, "SFO","IFC", '2017-03-29', 340, '12:00:00', '05:40:00', 389.00, 10, 90, 520.00),
    ("AA146", 10016, "IFC","ATL", '2017-03-29', 120, '07:00:00', '09:00:00', 79.00, 10, 90, 140.00),
    ("AA147", 10017, "ORD","IFC", '2017-04-01', 60, '09:00:00', '10:00:00', 79.00, 10, 90, 140.00),
    ("AA148", 10018, "SFO","JFK", '2017-04-02', 400, '06:20:00', '13:00:00', 516.00, 30, 248, 720.00),
    ("AA149", 10018, "JFK","IFC", '2017-04-05', 240, '09:10:00', '13:10:00', 309.00, 30, 248, 500.00),
    ("AA150", 10018, "IFC","SFO", '2017-04-05', 200, '15:00:00', '18:20:00', 119.00, 30, 248, 225.00);



INSERT INTO
    userr (first_name, last_name, email, password, user_type, gender,validation_status)
VALUES
    ("MacKenzie", "McLouth", "mackenzie-mclouth@uiowa.edu", "5f4dcc3b5aa765d61d8327deb882cf99", "admin", 'female',1),
    ("Nickolas", "Kutsch", "nickolas-kutsch@uiowa.edu", "5f4dcc3b5aa765d61d8327deb882cf99", "admin", 'male',1),
    ("Kyle", "Anderson", "kyle-l-anderson@uiowa.edu", "5f4dcc3b5aa765d61d8327deb882cf99", "admin", 'male',1),
    ("John", "Doe", "johndoe@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "employee", 'male',1),
    ("Jane", "Doe", "janedoe@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'female',1),
    ("Joe", "Schmoe", "joeschmoe@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Scott", "Endsley", "scoot@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Micahel", "Scott", "littlekidlover@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Dwight", "Schrute", "contactus@schrutefarms.com", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Jessica", "Day", "polkadots@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'female',1),
    ("Nick", "Miller", "beer@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Noname", "Schmitt", "schmitt@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Leslie", "Knope", "pawneeandwaffles@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'female',1),
    ("April", "Ludgate", "iheartdeath@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'female',1),
    ("Andy", "Dwyer", "mouseratrules@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1),
    ("Ben", "yatt", "starwars@iowaair.net", "5f4dcc3b5aa765d61d8327deb882cf99", "customer", 'male',1);


INSERT INTO 
    boarding_pass (flight_id, userr_id, seat_num, luggage_count, clas)
VALUES
    (1, 5, '1A', 1, 'first_class'),
    (1, 6, '2A', 1, 'first_class'),
    (1, 7, '3A', 3, 'first_class'),
    (1, 1, '4A', 2, 'first_class'),
    (1, 2, '1B', 2, 'first_class'),
    (1, 3, '2B', 1, 'first_class'),
    (1, 8, '3B', 1, 'first_class'),
    (1, 9, '3C', 1, 'first_class'),
    (1, 10, '10A', 1, 'economy'),
    (1, 11, '10B', 1, 'economy'),
    (1, 12, '10C', 1, 'economy'),
    (1, 13, '14C', 1, 'economy'),
    (1, 14, '15C', 1, 'economy'),
    (1, 4, '2C', 1, 'first_class');
