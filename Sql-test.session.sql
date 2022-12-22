CREATE TABLE books(
    name varchar(300),
    author varchar(300),
    type varchar(150),
    pages int,
    year date,
    publisher varchar(256)
);

CREATE TABLE users(
    first_name varchar(256),
    last_name varchar(256),
    email varchar(256),
    birthday date,
    gender varchar(128)
);

INSERT INTO users VALUES 
('Clark', 'Kent', 'super@man.com', '1990-09-09', 'male');