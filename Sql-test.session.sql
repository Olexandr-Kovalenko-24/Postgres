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
    first_name varchar(256) NOT NULL CHECK (first_name != ''),
    last_name varchar(256) NOT NULL CHECK (last_name != ''),
    email varchar(256) NOT NULL UNIQUE CHECK (email != ''),
    birthday date CHECK (birthday < current_date),
    gender varchar(128) CHECK (gender != ''),
    CONSTRAINT name_pair UNIQUE(first_name, last_name)
);

INSERT INTO users VALUES 
('Clark', 'Kent', 'super@man.com', '1990-09-09', 'male');

INSERT INTO users VALUES 
('Iron', 'Man', 'iron@man.cocm', '1960-06-09', 'male'),
('Loki', 'Odyn', 'loki@man.cocm', '1940-06-05', 'male'),
('Spyder', 'Man', 'spyderyea@man.cocm', '2001-01-05', 'male');

DROP TABLE messages;

CREATE TABLE messages(
    id serial NOT PRIMARY KEY,
    body text NOT NULL CHECK (body != ''),
    author varchar(256) NOT NULL,
    created_at timestamp NOT NULL CHECK (created_at <= current_timestamp) DEFAULT current_timestamp,
    is_read boolean NULL DEFAULT false
);

INSERT INTO messages (author, body) VALUES
('test user', 'dsdfs'),
('test user', 'dsdfs'),
('test user2', 'dsdfsdfd');

