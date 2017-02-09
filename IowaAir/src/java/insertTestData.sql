
/**
 * Author:  kenziemclouth
 * Created: Jan 31, 2017
 */

INSERT INTO 
    airport (code, city, sstate, country)
VALUES
    ("ORD", "Chicago", "IL", "USA"),
    ("JFK", "New York", "NY", "USA"),
    ("DFW","Dallas / Fort Worth", "TX", "USA"),
    ("ATL","Atlanta","GA","USA"),
    ("SFO","San Francisco","CA","USA");
    

INSERT INTO
    airplane (num, down_time)
VALUES
    ("Boeing737", 50),
    ("Boing757", 70);


INSERT INTO
    flight (num, airplane_id, origin_code, destination_code, capacity)
VALUES
    ("AA111", 1, "ORD","JFK", 196),
    ("AA112", 1, "ATL","DFW", 204),
    ("AA115", 2, "JFK","ATL", 106),
    ("AA116", 2, "LAX","ORD", 244);


select * from airplane;
select * from flight;

    