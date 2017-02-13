
/**
 * Author:  kenziemclouth
 * Created: Feb 10, 2017
 */


/* View all data from database */
select * from airport;
select * from airplane;
select * from flight;
select * from userr;
select * from boarding_pass;



/* view all passengers on a flight */
SELECT userr.first_name, userr.last_name, boarding_pass.seat_num
FROM userr
INNER JOIN boarding_pass
ON userr.id=boarding_pass.userr_id
WHERE boarding_pass.flight_id = 1;

/* view all flights leaving an airport */
SELECT *
FROM flight
WHERE origin_code='ORD';

/* view all flights arriving at an airport */
SELECT *
FROM flight
WHERE destination_code='ORD';


/* select all users of a certain user_type */
SELECT *
FROM userr
WHERE user_type = 'employee';


/* sort flights by field */
SELECT *
FROM flight
ORDER BY price;


