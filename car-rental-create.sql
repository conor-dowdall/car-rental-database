-- Car Rental Database Solution and Queries
-- by Conor Dowdall
--
--
-- this script is executable using the following command:
-- source PATH_TO_FILE/FILENAME.sql
--
--
-- create the database
CREATE DATABASE IF NOT EXISTS car_rental;
--
--
-- on the use of roles...
-- further discussion with the business would allow a 
-- proper implementation of user roles
-- for example, only a 'manager' can access the 
-- 'vehicles' table and, perhaps, only a 'frontdesk' 
-- can access the 'rentals' table
-- sample implementation statements...
-- CREATE ROLE 'manager',
-- 'mechanic',
-- 'frontdesk';
-- GRANT SELECT,
--     INSERT,
--     UPDATE,
--     DELETE,
--     ON car_rental.vehicle_types to 'manager';
-- GRANT SELECT,
--     INSERT,
--     UPDATE,
--     DELETE,
--     ON car_rental.vehicles to 'manager';
-- GRANT SELECT,
--     INSERT,
--     UPDATE,
--     DELETE,
--     ON car_rental.rentals to 'frontdesk';
-- CREATE USER 'manager1'@'localhost' IDENTIFIED BY 'Manager1234!';
-- CREATE USER 'frontdesk1'@'localhost' IDENTIFIED BY 'Frontdesk1234!';
-- GRANT 'manager' TO 'manager1'@'localhost';
-- GRANT 'frontdesk' TO 'frontdesk1'@'localhost';
-- localhost may be unnecessary for actual deployment 
-- (i.e. default to % for non-localhost logins)
--
--
-- use the created database
USE car_rental;
--
--
-- drop existing views and tables
DROP VIEW IF EXISTS customers_rental_type;
DROP VIEW IF EXISTS customers_rentals;
DROP VIEW IF EXISTS rentals_for_today;
DROP TABLE IF EXISTS payments;
DROP TABLE IF EXISTS rentals;
DROP TABLE IF EXISTS rental_types;
DROP TABLE IF EXISTS maintenance;
DROP TABLE IF EXISTS vehicles;
DROP TABLE IF EXISTS vehicle_types;
DROP TABLE IF EXISTS feedback;
DROP TABLE IF EXISTS customers;
--
--
-- create the tables
CREATE TABLE customers (
    customer_id INT AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    address VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    phone VARCHAR(30) NOT NULL,
    payment_details TEXT NOT NULL,
    PRIMARY KEY (customer_id)
);
CREATE TABLE vehicle_types (
    vehicle_type_id INT AUTO_INCREMENT,
    type VARCHAR (100) NOT NULL,
    model VARCHAR (100) NOT NULL,
    description TEXT NOT NULL,
    cost_per_day DECIMAL(10, 2),
    PRIMARY KEY (vehicle_type_id)
);
CREATE TABLE vehicles (
    vehicle_id INT AUTO_INCREMENT,
    vehicle_type_id INT NOT NULL,
    PRIMARY KEY (vehicle_id),
    FOREIGN KEY (vehicle_type_id) REFERENCES vehicle_types(vehicle_type_id)
);
CREATE TABLE maintenance (
    maintenance_id INT AUTO_INCREMENT,
    vehicle_id INT NOT NULL,
    log LONGTEXT,
    PRIMARY KEY (maintenance_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id)
);
CREATE TABLE rental_types (
    rental_type_id INT AUTO_INCREMENT,
    type VARCHAR(100),
    PRIMARY KEY (rental_type_id)
);
CREATE TABLE rentals (
    rental_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    vehicle_id INT NOT NULL,
    rental_type_id INT NOT NULL,
    date_time DATETIME NOT NULL,
    date_time_end DATETIME NOT NULL,
    pickup_location VARCHAR(255) DEFAULT 'onsite',
    dropoff_location VARCHAR(255) DEFAULT 'onsite',
    checklist_pre TEXT,
    checklist_post TEXT,
    PRIMARY KEY (rental_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id),
    FOREIGN KEY (vehicle_id) REFERENCES vehicles(vehicle_id),
    FOREIGN KEY (rental_type_id) REFERENCES rental_types(rental_type_id)
);
CREATE TABLE payments (
    payment_id INT AUTO_INCREMENT,
    rental_id INT NOT NULL,
    amount DECIMAL(10, 2) NOT NULL,
    method VARCHAR(20) NOT NULL,
    date_time DATETIME DEFAULT NOW(),
    PRIMARY KEY (payment_id),
    FOREIGN KEY (rental_id) REFERENCES rentals(rental_id)
);
CREATE TABLE feedback (
    feedback_id INT AUTO_INCREMENT,
    customer_id INT NOT NULL,
    feedback TEXT NOT NULL,
    PRIMARY KEY (feedback_id),
    FOREIGN KEY (customer_id) REFERENCES customers(customer_id)
);