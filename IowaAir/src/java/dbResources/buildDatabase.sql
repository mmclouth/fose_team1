
/**
 * Author:  kenziemclouth
 * Created: Jan 31, 2017
 */


DROP TABLE boarding_pass;
DROP TABLE userr;
DROP TABLE flight;
DROP TABLE airplane;
DROP TABLE aircraft_type;
DROP TABLE airport;



CREATE TABLE airport
(
    code VARCHAR(10) NOT NULL,
    city VARCHAR(255) NOT NULL,
    sstate VARCHAR(255),
    country VARCHAR(255) NOT NULL,
    timezone ENUM('8', '7', '6', '5', '4', '3') NOT NULL,
        PRIMARY KEY (code)
);

CREATE TABLE aircraft_type
(
    id INT NOT NULL AUTO_INCREMENT,
    plane_name VARCHAR(255) NOT NULL,
    down_time INT NOT NULL,
    capacity INT NOT NULL,
        PRIMARY KEY (id)
);

CREATE TABLE airplane 
(
    id INT NOT NULL AUTO_INCREMENT,
    aircraft_type_id INT NOT NULL,
    num VARCHAR(255) NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (aircraft_type_id) 
        REFERENCES aircraft_type (id)
        
);

ALTER TABLE airplane  AUTO_INCREMENT = 10000;



CREATE TABLE flight
(
    id INT NOT NULL AUTO_INCREMENT,
    num VARCHAR(255) NOT NULL,
    airplane_id INT NOT NULL,
    origin_code VARCHAR(10) NOT NULL,
    destination_code VARCHAR(10) NOT NULL,
    flight_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    duration INT NOT NULL,
    price DECIMAL(7,2) NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (airplane_id) 
        REFERENCES airplane (id),
        FOREIGN KEY (origin_code) 
        REFERENCES airport (code),
        FOREIGN KEY (destination_code) 
        REFERENCES airport (code)

);

CREATE TABLE userr
(
    id INT NOT NULL AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    email VARCHAR(255) NOT NULL,
    password VARCHAR(255),
    user_type ENUM('admin', 'employee', 'customer'),
    birthday DATE,
    gender ENUM('female', 'male', 'other'),
    validation_status BOOLEAN,
        PRIMARY KEY (id)

);

CREATE TABLE boarding_pass
(
    id INT NOT NULL AUTO_INCREMENT,
    flight_id INT NOT NULL,
    userr_id INT NOT NULL,
    seat_num VARCHAR(10),
    luggage_count INT,
        PRIMARY KEY (id),
        FOREIGN KEY (flight_id)
        REFERENCES flight (id),
        FOREIGN KEY (userr_id)
        REFERENCES userr (id)

);





