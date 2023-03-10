SELECT id, first_name FROM users;

SELECT first_name, last_name FROM users;

SELECT * FROM users
WHERE id = 2220;

SELECT * FROM users
WHERE gender = 'male';

SELECT * FROM users
WHERE gender = 'male' AND is_subscribed;

SELECT * FROM users
WHERE id % 2 = 0;

SELECT * FROM users
WHERE gender = 'female' AND is_subscribed = false;

SELECT email FROM users
WHERE is_subscribed;


SELECT * FROM users
WHERE first_name = 'John';

SELECT * FROM users
WHERE first_name IN ('John', 'Clark');


SELECT * FROM users
WHERE id IN (1, 10, 2500);


SELECT * FROM users
WHERE id > 2500 AND id < 3000;


SELECT * FROM users
WHERE id BETWEEN 2500 AND 3000;


SELECT * FROM users
WHERE first_name LIKE 'K%';


SELECT * FROM users
WHERE first_name LIKE '_____';


SELECT * FROM users
WHERE first_name LIKE '%a';


UPDATE users
SET weight = 60
WHERE id BETWEEN 2500 AND 2550;


UPDATE users
SET weight = 70
WHERE id % 5 = 0 RETURNING *;

DELETE FROM users
WHERE id = 2222
RETURNING *;

SELECT * FROM users
WHERE birthday < '2004-01-01';

SELECT first_name, extract("years" from age(birthday)) FROM users;

SELECT * FROM users
WHERE extract("years" from age(birthday)) > 25;


SELECT email FROM users
WHERE gender = 'male' AND extract("years" from age(birthday)) >= 18 AND extract("years" from age(birthday)) <= 60;


SELECT email, birthday FROM users
WHERE gender = 'male' AND (extract("years" from age(birthday)) BETWEEN 18 AND 60);




SELECT * FROM users
WHERE extract("month" from birthday) = 10;


SELECT email FROM users
WHERE (extract("day" from birthday) = 1) AND (extract("month" from birthday) = 11);


UPDATE users
SET height = 2.00
WHERE extract("years" from age(birthday)) >= 60 RETURNING *;


UPDATE users
SET weight = 80
WHERE gender = 'male' AND (extract("years" from age(birthday)) BETWEEN 30 AND 50) RETURNING *;



SELECT * FROM users;

SELECT id AS "Порядковий номер",
first_name AS "ім'я",
last_name AS "Прізвище",
email AS "Пошта",
is_subscribed AS "Підписка"
FROM users AS u;

SELECT * FROM users AS u
WHERE u.id = 2222;



SELECT * 
FROM users
LIMIT 10;


SELECT * FROM users
LIMIT 10
OFFSET 10;


SELECT * FROM orders
LIMIT 50
OFFSET 100;




SELECT id, first_name ||  ' ' || last_name AS full_name FROM users;

SELECT id, concat(first_name, ' ', last_name) AS full_name 
FROM users
WHERE char_length(concat(first_name, ' ', last_name)) > 10;

SELECT * FROM (
    SELECT id, concat(first_name, ' ', last_name) AS full_name 
    FROM users
) AS fn
WHERE char_length(fn.full_name) > 10;







DROP TABLE workers;
CREATE TABLE workers(
    id serial PRIMARY KEY,
    name varchar(256) NOT NULL CHECK (name != ''),
    salary numeric(7,2) NOT NULL,
    birthday date CHECK (birthday < current_date)
);


INSERT INTO workers (name, birthday, salary) VALUES
('Олег', '1990-01-01', 300);

INSERT INTO workers (name, salary) VALUES
('Ярослава', 1200);

INSERT INTO workers (name, birthday, salary) VALUES
('Саша', '1985-05-03', 85),
('Маша', '1995-11-23', 85);

UPDATE workers
SET salary = 500
WHERE name = 'Олег';

UPDATE workers
SET salary = 900
WHERE name = 'Маша';

UPDATE workers
SET salary = 1000
WHERE name = 'Саша';

UPDATE workers
SET birthday = '1987-09-09'
WHERE id = 4;

UPDATE workers
SET salary = 700
WHERE salary > 500;

UPDATE workers
SET birthday = '1999-03-05'
WHERE id BETWEEN 2 AND 5;

UPDATE workers
SET name = 'Женя'
WHERE name = 'Саша';

UPDATE workers
SET salary = 900
WHERE name = 'Женя';

SELECT * FROM workers
WHERE salary > 400;

SELECT * FROM workers
WHERE id > 4;

SELECT salary, extract("years" from age(birthday)) FROM workers
WHERE name = 'Женя';

SELECT * FROM workers
WHERE name = 'Петя';

SELECT * FROM workers
WHERE (extract("years" from age(birthday))=27) OR salary > 800;

SELECT * FROM workers
WHERE (extract("years" from age(birthday)) BETWEEN 25 AND 28);

SELECT * FROM workers
WHERE (extract("month" from birthday) = 9);

DELETE FROM workers
WHERE id = 4;

DELETE FROM workers
WHERE name = 'Олег';

DELETE FROM workers
WHERE extract("years" from age(birthday))>30;



INSERT INTO workers (name, birthday, salary) VALUES
('Олег', '1990-01-01', 300);

UPDATE workers
SET salary = 1200, name = 'Олег'
WHERE name = 'Женя';




SELECT max(height) FROM users;

SELECT avg(height) FROM users;

SELECT count(*) FROM users
WHERE gender = 'female';

SELECT avg(weight) FROM users
WHERE gender = 'male';


SELECT avg(weight), gender FROM users
GROUP BY gender;


SELECT avg(weight) FROM users
WHERE birthday > '2000-01-01';


SELECT avg(weight), gender FROM users
WHERE extract("year" from age(birthday)) > 25
GROUP BY gender;


SELECT avg(height) FROM users;

SELECT min(height), max(height), gender FROM users
GROUP BY gender;

SELECT count(*) FROM users
WHERE birthday > '1999-12-31';

SELECT count(*) FROM users
WHERE first_name = 'John';

SELECT count(*) FROM users
WHERE extract("year" from age(birthday)) BETWEEN 20 AND 30;

SELECT count(*) FROM users
WHERE height > 1.5;

SELECT count(*) FROM users
WHERE first_name ILIKE 'John';




SELECT count(*), customer_id FROM orders 
GROUP BY customer_id;



SELECT avg(price), brand FROM products
GROUP BY brand;


SELECT sum(quantity), brand FROM products
GROUP BY brand;


SELECT sum(quantity) FROM products;
SELECT sum(quantity) FROM orders_to_products;







-- SELECT min(quantity), brand, model 
-- FROM products
-- GROUP BY brand, model;


SELECT * FROM users
ORDER BY id ASC;

SELECT * FROM users
ORDER BY id DESC;

SELECT * FROM users
ORDER BY first_name ASC;


SELECT * FROM users
ORDER BY height, birthday;


SELECT * FROM products
ORDER BY quantity;


SELECT * FROM products
ORDER BY price DESC
LIMIT 5;


SELECT *,extract("years" from age(birthday)) FROM users
ORDER BY extract("years" from age(birthday)), first_name DESC;


SELECT extract("years" from age(birthday)), count(*) 
FROM users
GROUP BY extract("years" from age(birthday))
ORDER BY extract("years" from age(birthday));


SELECT * FROM products
ORDER BY price;


SELECT * FROM (
    SELECT *, extract("years" from age(birthday)) AS age
    FROM users) AS u_w_age
ORDER BY u_w_age;


SELECT count(*), age FROM (
    SELECT *, extract("years" from age(birthday)) AS age
    FROM users) AS u_w_age
GROUP BY age
ORDER BY age;


SELECT count(*), age FROM (
    SELECT *, extract("years" from age(birthday)) AS age
    FROM users) AS u_w_age
GROUP BY age
HAVING count(*) >= 5
ORDER BY age;


SELECT count(*), customer_id
FROM orders
GROUP BY customer_id
HAVING count(*) >= 3;


SELECT sum(quantity), brand
FROM products
GROUP BY brand
HAVING sum(quantity) >= 70000;




CREATE TABLE a(
    v char(3),
    t int
);

CREATE TABLE b(
    v char(3)  
);

INSERT INTO a VALUES
('XXX', 1), ('XXY', 1), ('XXZ', 1),
('XYX', 2), ('XYY', 2), ('XYZ', 2),
('YXX', 3), ('YXY', 3), ('YXZ', 3);

INSERT INTO b VALUES
('ZXX'), ('XXX'), ('ZXZ'), ('YXZ'), ('YXY');


SELECT * FROM a, b;

SELECT v FROM a UNION
SELECT * FROM b;


SELECT v FROM a 
INTERSECT
SELECT * FROM b;


SELECT v FROM a
EXCEPT
SELECT * FROM b;



INSERT INTO users (
    first_name,
    last_name,
    email,
    birthday,
    gender
  )
VALUES (
    'Tester1',
    'Tester1',
    'test@mail.com',
    '1989-02-26',
    'male'
  ),
  (
    'Tester2',
    'Tester2',
    'test2@mail.com',
    '1989-02-23',
    'male'
  ),
  (
    'Tester3',
    'Tester3',
    'test3@mail.com',
    '1989-02-27',
    'male'
  );


SELECT id FROM users;

SELECT id FROM users
INTERSECT 
SELECT customer_id FROM orders;


SELECT id FROM users
EXCEPT 
SELECT customer_id FROM orders;


SELECT email FROM users
WHERE id IN (SELECT id FROM users
                EXCEPT 
                SELECT customer_id FROM orders);



SELECT A.v as 'id',
A.t as 'price',
B.v as 'Phone_id' 
FROM a,b
WHERE a.v = b.v;


SELECT *
FROM a JOIN b ON A.v = B.v;


SELECT u.*, o.id AS order_id
FROM users AS u 
JOIN orders AS o
ON o.customer_id = u.id
WHERE u.id = 2555;


SELECT p.model
FROM products AS p
JOIN orders_to_products AS otp
ON p.id = otp.product_id
WHERE otp.order_id = 7;


SELECT u.id, email, o.id AS order_id
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id;


SELECT u.id, email, o.id AS order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id;


SELECT u.id, email, o.id AS order_id
FROM users AS u
RIGHT JOIN orders AS o
ON u.id = o.customer_id;


SELECT u.id, email, o.id AS order_id
FROM users AS u
LEFT JOIN orders AS o
ON u.id = o.customer_id
WHERE o.id IS NULL;


SELECT u.id, email, o.id AS order_id
FROM users AS u
FULL JOIN orders AS o
ON u.id = o.customer_id;




SELECT otp.order_id, p.model
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE brand = 'Samsung';


SELECT p.model, count(*) AS amount
FROM orders_to_products AS otp
JOIN products AS p
ON otp.product_id = p.id
WHERE brand = 'Samsung'
GROUP BY p.model;


33 model 62


SELECT email
FROM users AS u
JOIN orders AS o 
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON otp.product_id = p.id
WHERE p.model = '33 model 62'
GROUP BY email;


SELECT * 
FROM products AS p 
LEFT JOIN orders_to_products AS otp 
ON p.id = otp.product_id
WHERE otp.order_id IS NULL;



SELECT otp.order_id, sum(p.price * otp.quantity) AS order_price
FROM products AS p 
JOIN orders_to_products AS otp 
ON p.id = otp.product_id
GROUP BY otp.order_id
ORDER BY otp.order_id;






SELECT otp.order_id
FROM orders_to_products AS otp
JOIN products AS p
ON p.id = otp.product_id
WHERE p.brand = 'Samsung'
GROUP BY otp.order_id
ORDER BY otp.order_id;



SELECT u.email, count(*) AS number_of_orders
FROM users AS u 
JOIN orders AS o 
ON u.id = o.customer_id
GROUP BY u.id;



SELECT o.id, count(otp.quantity) AS number_of_products
FROM orders_to_products AS otp
JOIN orders AS o 
ON o.id = otp.order_id
GROUP BY o.id
ORDER BY o.id;


SELECT otp.order_id, count(*)
FROM orders_to_products AS otp
GROUP BY otp.order_id
ORDER BY otp.order_id;



SELECT p.brand, p.model, sum(otp.quantity)
FROM products AS p 
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY p.model, p.brand
ORDER BY sum(otp.quantity) DESC
LIMIT 1;



SELECT avg(o_w_sum.order_sum)
FROM (
  SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
  FROM orders_to_products AS otp
  JOIN products AS p
  ON p.id = otp.product_id
  GROUP BY otp.order_id
  ) AS o_w_sum;



SELECT u.first_name, u.last_name, count(*)
FROM users AS u 
JOIN orders AS o
ON u.id = o.customer_id
GROUP BY u.first_name, u.last_name
ORDER BY count(*) DESC
LIMIT 1;


SELECT u.*, sum(otp.quantity * p.price)
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON otp.product_id = p.id
GROUP BY u.id;


SELECT u.*, sum(otp.quantity * p.price) AS total_sum
FROM users AS u
JOIN orders AS o
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
JOIN products AS p
ON otp.product_id = p.id
GROUP BY u.id
ORDER BY total_sum DESC
LIMIT 1;


SELECT p.brand, sum(otp.quantity)
FROM products AS p 
JOIN orders_to_products AS otp
ON p.id = otp.product_id
GROUP BY p.brand
ORDER BY sum(otp.quantity) DESC
LIMIT 1;




SELECT * FROM (
  SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
  FROM orders_to_products AS otp
  JOIN products AS p
  ON p.id = otp.product_id
  GROUP BY otp.order_id
  ) AS order_with_costs
  WHERE order_with_costs.order_sum > (SELECT avg(o_w_sum.order_sum)
    FROM (
      SELECT otp.order_id, sum(otp.quantity * p.price) AS order_sum
      FROM orders_to_products AS otp
      JOIN products AS p
      ON p.id = otp.product_id
      GROUP BY otp.order_id
      ) AS o_w_sum);

-- =

WITH orders_with_costs AS (
    SELECT otp.order_id, sum(p.price*otp.quantity) AS total_amount
    FROM orders_to_products AS otp
    JOIN products AS p
    ON p.id = otp.product_id
    GROUP BY otp.order_id
    )
SELECT owc.*
FROM orders_with_costs AS owc
WHERE owc.total_amount > (SELECT avg(o_w_sum.order_sum)
       FROM (
            SELECT otp.order_id, sum(p.price*otp.quantity) AS order_sum
            FROM orders_to_products AS otp
            JOIN products AS p
            ON p.id = otp.product_id
            GROUP BY otp.order_id
              ) AS o_w_sum);




SELECT * FROM (
  SELECT u.*, count(*) AS numder_orders
  FROM users AS u 
  JOIN orders AS o
  ON u.id = o.customer_id
  GROUP BY u.id
  ORDER BY count(*) DESC) AS n_o_ord
  WHERE n_o_ord.numder_orders > (SELECT avg(u_w_orders.number_orders)
    FROM (
      SELECT u.*, count(*) AS number_orders
      FROM users AS u 
      JOIN orders AS o
      ON u.id = o.customer_id
      GROUP BY u.id
      ORDER BY count(*) DESC) AS u_w_orders);

-- =

WITH user_with_orders AS (
  SELECT u.*, count(*) AS numders_orders
  FROM users AS u 
  JOIN orders AS o
  ON u.id = o.customer_id
  GROUP BY u.id
  ORDER BY count(*) DESC
)
SELECT uwo.*
FROM user_with_orders AS uwo
WHERE uwo.numders_orders > (SELECT avg(u_w_orders.number_orders)
    FROM (
      SELECT u.*, count(*) AS number_orders
      FROM users AS u 
      JOIN orders AS o
      ON u.id = o.customer_id
      GROUP BY u.id
      ORDER BY count(*) DESC) AS u_w_orders);



SELECT u.*, count(otp.product_id)
FROM users AS u 
JOIN orders AS o 
ON u.id = o.customer_id
JOIN orders_to_products AS otp
ON o.id = otp.order_id
GROUP BY u.id
ORDER BY u.id;


