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
    author int REFERENCES users(id),
    created_at timestamp NOT NULL CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false
);

DROP TABLE chats;
CREATE TABLE chats(
    id serial PRIMARY KEY,
    user_id int REFERENCES users(id),
    message_id int REFERENCES messages(id),
    chat_name varchar(128) NOT NULL CHECK (chat_name != '')
);


DROP TABLE chats_to_users;
CREATE TABLE chats_to_users(
    user_id int REFERENCES users(id),
    chats_id int REFERENCES chats(id),
    PRIMARY KEY (user_id, chats_id)
);




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