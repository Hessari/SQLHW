USE sakila;

-- Question1a

SELECT first_name, last_name
 FROM actor;

-- Question1b
SELECT concat(first_name, ' ', last_name) AS Actor_Name
FROM actor;


-- Question2a

SELECT first_name, last_name, actor_id FROM actor
WHERE first_name = "Joe";

-- Question2b

SELECT * FROM actor
WHERE last_name like '%GEN%';

-- Question2c

SELECT last_name, first_name  FROM actor
WHERE last_name like '%LI%';

-- Question2d

SELECT country_id, country FROM country
WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

-- Question3a

ALTER TABLE actor
ADD description BLOB AFTER last_update;

-- Question3b

ALTER TABLE actor
DROP description ;

-- Question4a
SELECT last_name, count(last_name)
FROM actor
GROUP BY last_name;

-- Question4b
SELECT last_name, COUNT(last_name) AS ls_count
FROM actor
GROUP BY last_name 
HAVING ls_count > 1;

-- Question4c
UPDATE actor
SET first_name = 'GROUCHO' 
WHERE first_name = 'HARPO' AND last_name = 'WILLIAMS';

SELECT * FROM actor
WHERE first_name = 'GROUCHO';




