-- Car Rental Database Solution and Queries
-- by Conor Dowdall
--
--
-- this script is executable using the following command:
-- source PATH_TO_FILE/FILENAME.sql
--
--
-- insert test data
INSERT INTO customers
VALUES (
        NULL,
        'Aaron A. Anderson',
        '1 A-Street, A-Town, A-City, A-County, A-Country',
        'a@aa.aaa',
        '111-111-1111',
        'credit card 1234-1234-1234-1234'
    ),
    (
        NULL,
        'Barbara B. Benson',
        '1 B-Street, B-Town, B-City, B-County, B-Country',
        NULL,
        '222-222-2222',
        'credit card 1234-1234-1234-1234'
    );
INSERT INTO vehicle_types
VALUES (
        NULL,
        'Luxury SUV',
        'BMW iX xDrive50',
        'The all-electric iX is spacious, comfortable, surprisingly efficient and ridiculously agile for its size. If you can get past its slightly polarizing design, you may just fall in love with this electric BMW.',
        100.0
    ),
    (
        NULL,
        'Van',
        'Ford Transit',
        'Smarter, more useful and more connected technology. More powerful and efficient engines. More versatile performance with optional intelligent All-Wheel Drive. A striking new design. And now even more strength with the new 5-Tonne model. This is our toughest, most trusted Ford Transit yet.',
        750.
    );
INSERT INTO vehicles
VALUES (NULL, 1),
    (NULL, 1),
    (NULL, 2),
    (NULL, 2),
    (NULL, 2);
INSERT INTO rental_types
VALUES (NULL, 'short term'),
    (NULL, 'long term');
INSERT INTO rentals
VALUES (
        NULL,
        1,
        1,
        2,
        NOW() - INTERVAL 1 DAY,
        NOW() + INTERVAL 14 DAY,
        DEFAULT,
        DEFAULT,
        NULL,
        NULL
    ),
    (
        NULL,
        2,
        3,
        1,
        NOW() - INTERVAL 1 HOUR,
        NOW() + INTERVAL 3 DAY,
        DEFAULT,
        DEFAULT,
        NULL,
        NULL
    );
INSERT INTO payments
VALUES (NULL, 1, 100.0, 'credit card', DEFAULT),
    (NULL, 2, 200.0, 'cash', DEFAULT);