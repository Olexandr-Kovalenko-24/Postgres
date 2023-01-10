DROP TABLE books;
CREATE TABLE books(
    name varchar(300),
    author varchar(300),
    type varchar(150),
    pages int,
    year date,
    publisher varchar(256)
);

DROP TABLE users;

CREATE TABLE users(
    id serial PRIMARY KEY,
    first_name varchar(256) NOT NULL CHECK (first_name != ''),
    last_name varchar(256) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
    birthday date CHECK (birthday < current_date),
    gender varchar(128) CHECK (gender != '')
);

ALTER TABLE users 
ADD COLUMN height numeric(3,2);

ALTER TABLE users
DROP CONSTRAINT "to_height_user";
ALTER TABLE users 
ADD CONSTRAINT "to_height_user" CHECK (height < 4.00);

ALTER TABLE users
DROP CONSTRAINT "to_height_user";

ALTER TABLE users
DROP COLUMN weight;
ALTER TABLE users
ADD COLUMN weight numeric(5,2) CONSTRAINT "weight_not_0" CHECK (weight > 0);


ALTER TABLE users
ADD CONSTRAINT "not_before_1990" CHECK (birthday > '1900-01-01');

ALTER TABLE users
ADD COLUMN is_subscribed boolean;

ALTER TABLE users
DROP CONSTRAINT "not_before_1990";

DELETE FROM users
WHERE id > 10;

ALTER TABLE users
DROP CONSTRAINT users_email_key;


INSERT INTO users (first_name, last_name, email, birthday, gender, height, weight) VALUES 
('Clark', 'Kent', 'supfdfer@marn.com', '1980-09-09', 'male', 4.84, 72.81);

INSERT INTO users (first_name, last_name, email, birthday, gender) VALUES 
('Iron', 'Man', 'iron@man.cocm', '1960-06-09', 'male'),
('Loki', 'Odyn', 'loki@man.cocm', '1940-06-05', 'male'),
('Spyder', 'Man', 'spyderyea@man.cocm', '2001-01-05', 'male');

DROP TABLE messages;
CREATE TABLE messages(
    id serial PRIMARY KEY,
    body text NOT NULL CHECK (body != ''),
    author_id int REFERENCES users(id),
    created_at timestamp NOT NULL CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false
);

ALTER TABLE messages
ADD COLUMN chats_id int REFERENCES chats(id);


DROP TABLE chats;
CREATE TABLE chats(
    id serial PRIMARY KEY,
    chat_name varchar(128) NOT NULL CHECK (chat_name != ''),
    owner_id int REFERENCES users(id),
    created_at timestamp NOT NULL DEFAULT current_timestamp
);


DROP TABLE chats_to_users;
CREATE TABLE chats_to_users(
    user_id int REFERENCES users(id) ON DELETE CASCADE,
    chats_id int REFERENCES chats(id),
    PRIMARY KEY (user_id, chats_id)
);


INSERT INTO chats (chat_name, owner_id) VALUES
('first chat', 1);

INSERT INTO chats_to_users VALUES
(1, 1), (2, 1), (3, 1), (5, 1);

INSERT INTO messages (author_id, body, chats_id) VALUES
(1, 'hello', 1), (2, 'hello, by', 1);


CREATE TABLE products(
    id serial PRIMARY KEY,
    name varchar(100) NOT NULL CHECK (name != ''),
    category varchar(100),
    price numeric(10,2) NOT NULL CHECK (price > 0),
    quantity int CHECK (quantity > 0)
);

INSERT INTO products (name, price, quantity) VALUES
('Samsung', 100, 5),
('Iphone', 120, 9),
('Nokia', 30, 15);


ALTER TABLE products
ADD COLUMN model varchar(200);


ALTER TABLE products
RENAME COLUMN name TO brand;

DELETE FROM orders_to_products;

DELETE FROM products;


DROP TABLE orders;
CREATE TABLE orders(
    id serial PRIMARY KEY,
    created_at timestamp DEFAULT current_timestamp,
    customer_id int REFERENCES users(id)
);

INSERT INTO orders (customer_id) VALUES
(1), (1), (2), (1), (3);

INSERT INTO orders (customer_id) VALUES
(4);

CREATE TABLE orders_to_products(
    product_id int REFERENCES products(id),
    order_id int REFERENCES orders(id),
    quantity int CHECK (quantity > 0),
    PRIMARY KEY (product_id, order_id)
);

INSERT INTO orders_to_products(product_id, order_id, quantity) VALUES
(1, 7, 1),
(2, 8, 1),
(3, 9, 1);




CREATE TABLE content (
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name != ''),
    description text,
    created_at timestamp NOT NULL DEFAULT current_timestamp
);

INSERT INTO content (name) VALUES
('funny cats1'), ('funny cats2'), ('funny cats3');

CREATE TABLE reactions (
    user_id int REFERENCES users(id),
    content_id int REFERENCES content(id),
    reaction boolean,
    PRIMARY KEY (user_id, content_id)
);

INSERT INTO reactions (content_id, user_id, reaction) VALUES
(1, 1, true), (2, 2, false), (3, 3);




CREATE TABLE coaches(
    id serial PRIMARY KEY,
    name varchar(300)
    -- team_id int REFERENCES teams(id)
);

ALTER TABLE coaches
ADD COLUMN team_id int REFERENCES teams(id);


CREATE TABLE teams(
    id serial PRIMARY KEY,
    name varchar(300),
    coach_id int REFERENCES coaches(id)
);


ALTER TABLE coaches
DROP COLUMN team_id;

DROP TABLE teams;

DROP TABLE coaches;



UPDATE users
SET first_name = 'James'
WHERE id = 8;


UPDATE users
SET weight = 60.00
WHERE birthday > '1990-01-01';


DELETE FROM users
WHERE id=5;
---not possible

SELECT * FROM users;

SELECT * FROM users
WHERE weight = 60.00;

SELECT * FROM users
WHERE birthday > '1992-01-01';



SELECT * FROM chats;

INSERT INTO chats (name, owner_id) VALUES ('second', 1) RETURNING *;







SELECT first_name AS "Ім'я",
    last_name AS "Прізвище"
FROM users;


SELECT *, (
    CASE
        WHEN is_subscribed = TRUE
            THEN 'Підписаний'
        WHEN is_subscribed = FALSE
            THEN 'Не підписаний'
        ELSE 'Не відомо'
    END
)
FROM users;



ALTER TABLE orders
ADD COLUMN status boolean;

UPDATE orders
SET status = true
WHERE id % 3 = 0;

UPDATE orders
SET status = false;

UPDATE orders
SET status = NULL
WHERE id BETWEEN 10 AND 15;

SELECT *, (
    CASE
        WHEN status = TRUE
            THEN 'done'
        WHEN status = FALSE
            THEN 'processing'
        ELSE 'new'
    END
)
FROM orders;



SELECT *, (
    CASE extract("month" from birthday)
        WHEN 1 THEN 'winter'
        WHEN 2 THEN 'winter'
        WHEN 3 THEN 'spring'
        WHEN 4 THEN 'spring'
        WHEN 5 THEN 'spring'
        WHEN 6 THEN 'summer'
        WHEN 7 THEN 'summer'
        WHEN 8 THEN 'summer'
        WHEN 9 THEN 'fall'
        WHEN 10 THEN 'fall'
        WHEN 11 THEN 'fall'
        WHEN 12 THEN 'winter'
    ELSE 'unknown'
END
) AS "birth_season"
FROM users;



SELECT *, (
    CASE extract("years" from age(birthday)) > 18
        WHEN false THEN 'Не повнолітній'
        WHEN true THEN 'Повнолітній'
    ELSE 'unknown'
END
) AS "Повнолітність"
FROM users;


SELECT *, (
    CASE 
        WHEN extract("years" from age(birthday)) > 18
        THEN 'Повнолітній'
    ELSE 'Не повнолітній'
    END
) AS "Повнолітність"
FROM users;


SELECT *, (
    CASE
        WHEN brand = 'iPhone'
        THEN 'Apple'
    ELSE 'Other'
    END
) AS "manufacturer"
FROM products;


SELECT *, (
    CASE 
        WHEN price > 9000
        THEN 'flagman'
        WHEN price < 1000
        THEN 'cheap'
        WHEN price BETWEEN 1000 AND 9000
        THEN 'middle'
    ELSE 'haven`t price'
    END
) AS "price_category"
FROM products;


SELECT u.*, count(o.id), (
    CASE 
        WHEN count(o.id) > 5
        THEN 'parmanent'
        WHEN count(o.id) = 0
        THEN 'new client'
        WHEN count(o.id) BETWEEN 1 AND 5
        THEN 'active'
    ELSE 'haven`t price'
    END
) AS "user_status"
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.id
ORDER BY count(o.id);



SELECT id, brand, price, COALESCE(category, 'smartphone') AS category
FROM products;


SELECT *, LEAST(price, 1000) AS sale_price
FROM products;


SELECT *, GREATEST(price, 1000) AS new_price
FROM products;



SELECT * 
FROM users AS u
WHERE u.id NOT IN (
    SELECT o.customer_id
    FROM orders AS o
);

SELECT * 
FROM users AS u
WHERE u.id IN (
    SELECT o.customer_id
    FROM orders AS o
);


SELECT * 
FROM products AS p
WHERE p.id NOT IN (
    SELECT otp.product_id
    FROM orders_to_products AS otp
);



SELECT *
FROM users
WHERE id = 190;

SELECT EXISTS
    (SELECT *
    FROM users
    WHERE id = 190);


SELECT EXISTS
    (SELECT o.customer_id
    FROM orders AS o
    WHERE id = 2300);


SELECT u.id, u.email, (EXISTS
                        (SELECT o.customer_id
                        FROM orders AS o))
FROM users AS u;



----ANY/SOME----
---(IN)---

--Якщо хоч для якогось значення умова = true -  то повернеться true

--------------ALL--------
--Якщо для всіх рядків значення = true

SELECT *
FROM products AS p
WHERE p.id != ALL (
    SELECT product_id 
    FROM orders_to_products
);





SELECT id, first_name, last_name
FROM users;

SELECT u.*, count(*) AS order_count
FROM users As u 
JOIN orders As o
ON u.id = o.customer_id
GROUP BY u.id, u.email;


CREATE VIEW users_with_order_count AS (SELECT u.*, count(*) AS order_count
FROM users As u 
JOIN orders As o
ON u.id = o.customer_id
GROUP BY u.id, u.email);


SELECT * 
FROM users_with_order_count
WHERE id = 2222;


SELECT * 
FROM users_with_order_count
WHERE order_count > 5;


-- SELECT * FROM (
--   SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
--   FROM orders_to_products AS otp
--   JOIN products AS p
--   ON p.id = otp.product_id
--   GROUP BY otp.order_id
--   ) AS order_with_costs
--   WHERE order_with_costs.order_sum > (SELECT avg(o_w_sum.order_sum)
--     FROM (
--       SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
--       FROM orders_to_products AS otp
--       JOIN products AS p
--       ON p.id = otp.product_id
--       GROUP BY otp.order_id
--       ) AS o_w_sum);



CREATE VIEW "order_with_costs" AS 
    (SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
    FROM orders_to_products AS otp
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY otp.order_id);


SELECT owc.*
FROM order_with_costs AS owc
WHERE owc.order_sum > (SELECT avg(order_sum)
                        FROM order_with_costs);



CREATE VIEW "sum_with_model_count" AS
(SELECT o.*, sum(otp.quantity * p.price) AS order_sum, count(otp.product_id) AS model_quantity
    FROM orders AS o
    JOIN orders_to_products AS otp
    ON otp.order_id = o.id
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY o.id);


SELECT sum_with_model_count.customer_id, sum(order_sum) AS total_costs
FROM sum_with_model_count
GROUP BY sum_with_model_count.customer_id;

-- =

SELECT u.*, sum(order_sum)
FROM users AS u
JOIN sum_with_model_count AS swmc 
ON u.id = swmc.customer_id
GROUP BY u.id;


CREATE VIEW "full_name_users_with_total_coasts" AS
(SELECT u.id, concat(first_name, ' ', last_name) AS full_name, u.email, sum(order_sum) AS total_coast
FROM users AS u
JOIN sum_with_model_count AS swmc 
ON u.id = swmc.customer_id
GROUP BY u.id);




SELECT *
FROM full_name_users_with_total_coasts
ORDER BY full_name_users_with_total_coasts.total_coast DESC
LIMIT 10;


-- Серед однонго замовлення
SELECT *
FROM users AS u
JOIN sum_with_model_count AS swmc
ON u.id = swmc.customer_id
ORDER BY swmc.model_quantity DESC
LIMIT 10;

-- Серед всіх замовлень
SELECT u.id, u.email, sum(swmc.model_quantity) AS model_count
FROM users AS u
JOIN sum_with_model_count AS swmc
ON u.id = swmc.customer_id
GROUP BY u.id, u.email
ORDER BY model_count DESC
LIMIT 10;

SELECT swmc.customer_id, sum(model_quantity)
FROM sum_with_model_count AS swmc
GROUP BY swmc.customer_id;



SELECT *
FROM users_with_order_count
WHERE users_with_order_count.order_count > (SELECT avg(users_with_order_count.order_count)
                                            FROM users_with_order_count);



SELECT *
FROM sum_with_model_count
WHERE sum_with_model_count.model_quantity > (SELECT avg(sum_with_model_count.model_quantity)
                                                FROM sum_with_model_count);


