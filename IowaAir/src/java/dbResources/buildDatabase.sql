
/**
 * Author:  kenziemclouth
 * Created: Jan 31, 2017
 */

DROP TABLE booking_has_boarding_pass;
DROP TABLE booking;
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
    node_num INT NOT NULL,
    timezone ENUM('8', '7', '6', '5', '4', '3') NOT NULL,
        PRIMARY KEY (code)
);

CREATE TABLE aircraft_type
(
    id INT NOT NULL AUTO_INCREMENT,
    plane_name VARCHAR(191) UNIQUE NOT NULL,
    down_time INT NOT NULL,
    capacity_total INT NOT NULL,
    capacity_first_class INT NOT NULL,
    capacity_economy INT NOT NULL,
    seats_per_row INT,
        PRIMARY KEY (id)
);

CREATE TABLE airplane 
(
    id INT NOT NULL AUTO_INCREMENT,
    aircraft_type_id INT NOT NULL,
    num VARCHAR(191) NOT NULL UNIQUE,
        PRIMARY KEY (id),
        FOREIGN KEY (aircraft_type_id) 
        REFERENCES aircraft_type (id)
        
);

ALTER TABLE airplane  AUTO_INCREMENT = 10000;



CREATE TABLE flight
(
    id INT NOT NULL AUTO_INCREMENT,
    num VARCHAR(191) UNIQUE NOT NULL,
    airplane_id INT NOT NULL,
    origin_code VARCHAR(10) NOT NULL,
    destination_code VARCHAR(10) NOT NULL,
    departure_date DATE NOT NULL,
    arrival_date DATE NOT NULL,
    departure_time TIME NOT NULL,
    arrival_time TIME NOT NULL,
    duration INT NOT NULL,
    price_economy DECIMAL(7,2) NOT NULL,
    price_first_class DECIMAL(7,2) NOT NULL,
    first_class_remaining INT NOT NULL,
    economy_remaining INT NOT NULL,
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
    email VARCHAR(191) NOT NULL UNIQUE,
    password VARCHAR(255),
    user_type ENUM('admin', 'employee', 'customer'),
    birthday DATE,
    gender ENUM('female', 'male', 'other'),
    validation_status BOOLEAN DEFAULT false,
    confirmation_code VARCHAR(255),
        PRIMARY KEY (id)

);

CREATE TABLE boarding_pass
(
    id INT NOT NULL AUTO_INCREMENT,
    flight_id INT NOT NULL,
    userr_id INT NOT NULL,
    passenger_name VARCHAR(255),
    checked_in BOOLEAN DEFAULT false,
    clas ENUM('first_class', 'economy'),
    seat_num VARCHAR(10),
    luggage_count INT,
        PRIMARY KEY (id),
        FOREIGN KEY (flight_id)
        REFERENCES flight (id),
        FOREIGN KEY (userr_id)
        REFERENCES userr (id)

);


CREATE TABLE booking
(
    id VARCHAR(20) NOT NULL,
    booked_on DATE,
    passengers INT,
        PRIMARY KEY (id),
        CONSTRAINT id_unique UNIQUE (id)
);


CREATE TABLE booking_has_boarding_pass
(
    id INT NOT NULL AUTO_INCREMENT,
    booking_id VARCHAR(20) NOT NULL,
    boarding_pass_id INT NOT NULL,
        PRIMARY KEY (id),
        FOREIGN KEY (booking_id)
        REFERENCES booking (id),
        FOREIGN KEY (boarding_pass_id)
        REFERENCES boarding_pass (id)

);