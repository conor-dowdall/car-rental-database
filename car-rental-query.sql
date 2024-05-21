-- Car Rental Database Solution and Queries
-- by Conor Dowdall
--
--
-- this script is executable using the following command:
-- source PATH_TO_FILE/FILENAME.sql
--
--
-- create queries to demonstrate CRUD statements
-- SELECT
CREATE VIEW rentals_for_today AS
SELECT name AS 'Customer',
    TIME(date_time) AS 'Time'
FROM customers
    INNER JOIN rentals USING (customer_id)
WHERE DATE(date_time) = DATE(NOW());
SELECT *
FROM rentals_for_today;
-- INSERT
INSERT INTO payments
VALUES (NULL, 1, 10.0, 'cash', DEFAULT);
SELECT *
FROM payments;
-- UPDATE
CREATE VIEW customers_rental_type AS
SELECT customers.name AS 'Name',
    customers.phone AS 'Phone',
    rental_types.type AS 'Rental Type'
FROM customers
    INNER JOIN rentals USING (customer_id)
    INNER JOIN rental_types ON rentals.rental_type_id = rental_types.rental_type_id;
SELECT *
FROM customers_rental_type;
UPDATE customers
    INNER JOIN rentals USING (customer_id)
SET customers.phone = '333-333-3333',
    rentals.rental_type_id = 1
WHERE customers.name LIKE 'Aaron%';
SELECT *
FROM customers_rental_type;
-- DELETE
INSERT INTO payments
VALUES (NULL, 1, 150.0, 'payment mistake', DEFAULT);
SELECT *
FROM payments;
CREATE TEMPORARY TABLE payments_copy AS
SELECT MAX(payment_id) AS id
from payments;
DELETE FROM payments
WHERE payment_id = (
        SELECT id
        FROM payments_copy
    );
DROP TEMPORARY TABLE IF EXISTS payments_copy;
SELECT *
FROM payments;
--
--
-- demonstrate 3 of Codd's rules
-- Rule 3
-- Systematic Treatment of Null Values
SELECT *
FROM customers
WHERE email IS NULL;
SELECT *
FROM customers
WHERE email IS NOT NULL;
-- Rule 6
-- View Updating Rule
CREATE VIEW customers_rentals AS
SELECT name AS 'Name',
    date_time
FROM customers
    INNER JOIN rentals USING (customer_id);
SELECT *
FROM customers_rentals;
UPDATE customers_rentals
SET date_time = (NOW() + INTERVAL 1 MONTH)
WHERE name LIKE 'Barbara%';
SELECT *
FROM customers_rentals;
-- Rule 9
-- Logical Data Independence
SELECT *
FROM payments;
ALTER TABLE payments
ADD COLUMN codd_test VARCHAR(255);
SELECT *
FROM payments;