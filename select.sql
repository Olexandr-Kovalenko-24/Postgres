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


