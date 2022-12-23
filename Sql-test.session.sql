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
ADD CONSTRAINT "to_height_user" CHECK (height < 3.0);

ALTER TABLE users
DROP CONSTRAINT "to_height_user";

ALTER TABLE users
DROP CONSTRAINT "weight_not_0";

ALTER TABLE users
ADD COLUMN weight numeric(5,2) CONSTRAINT "weight_not_0" CHECK (weight > 0);

ALTER TABLE users
ADD CONSTRAINT "not_before_1990" CHECK (birthday > '1900-01-01');


INSERT INTO users (first_name, last_name, email, birthday, gender, height, weight) VALUES 
('Clark', 'Kent', 'super@man.com', '1980-09-09', 'male', 3.84, 72.81);

INSERT INTO users (first_name, last_name, email, birthday, gender) VALUES 
('Iron', 'Man', 'iron@man.cocm', '1960-06-09', 'male'),
('Loki', 'Odyn', 'loki@man.cocm', '1940-06-05', 'male'),
('Spyder', 'Man', 'spyderyea@man.cocm', '2001-01-05', 'male');

DROP TABLE messages;

CREATE TABLE messages(
    id serial NOT PRIMARY KEY,
    body text NOT NULL CHECK (body != ''),
    author varchar(256) NOT NULL,
    created_at timestamp NOT NULL CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    is_read boolean NOT NULL DEFAULT false
);

INSERT INTO messages (author, body) VALUES
('test user', 'dsdfs'),
('test user', 'dsdfs'),
('test user2', 'dsdfsdfd');

