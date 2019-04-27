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

-- Question4d
UPDATE actor
SET first_name = 'HARPO' 
WHERE first_name = 'GROUCHO' AND last_name = 'WILLIAMS';

-- Question5a
SHOW CREATE TABLE address;

-- Question6a
SELECT s.first_name, s.last_name, a.address, c.city, co.country
FROM staff AS s
LEFT JOIN address AS a
ON s.address_id = a.address_id
LEFT JOIN city AS c
ON a.city_id = c.city_id
LEFT JOIN country as co
ON c.country_id = co.country_id;

-- Question6b
SELECT s.staff_id,  s.first_name, s.last_name, SUM(p.amount) as total_sales
FROM payment AS p
INNER JOIN staff AS s
ON p.staff_id = s.staff_id
WHERE payment_date BETWEEN  "20050801" AND "20050901"
GROUP BY s.staff_id;

-- Question6d
SELECT f.title, COUNT(f.title) AS num FROM film AS f
INNER JOIN inventory AS i 
ON f.film_id = i.film_id
WHERE f.title = "Hunchback Impossible"
GROUP BY f.title;

-- Question6e
SELECT c.first_name, c.last_name, sum(p.amount) AS total_paid FROM payment AS p
INNER JOIN customer AS c
ON p.customer_id = c.customer_id
GROUP BY c.first_name, c.last_name
ORDER BY c.last_name, c.first_name;

-- Question7a
select * from language;
SELECT title FROM film
WHERE title LIKE "Q%" OR title LIKE "K%"
	AND language_id = (
		SELECT language_id FROM language
        WHERE name = "English");


-- Question7b
	SELECT first_name, last_name FROM actor
	WHERE actor_id IN (
		SELECT actor_id FROM film_actor 
	    WHERE film_id = (
			SELECT film_id FROM film 
	        WHERE title = "Alone Trip"));
            
-- Question7c
SELECT c.first_name, c.last_name, c.email
FROM customer AS c
INNER JOIN address AS a
    ON c.address_id = a.address_id
INNER JOIN city AS ct
    ON a.city_id = ct.city_id
INNER JOIN country AS co
    ON ct.country_id = co.country_id
WHERE co.country = "Canada";

-- Question7d
SELECT title FROM film
WHERE film_id IN (

SELECT film_id
    FROM film_category
    WHERE category_id = (

SELECT category_id
        FROM category
        WHERE name = "Family"));
        
-- Question7e

SELECT f.title, COUNT(f.title) AS rent_mov
FROM rental AS r
INNER JOIN inventory AS i
    ON r.inventory_id = i.inventory_id
INNER JOIN film AS f
    ON i.film_id = f.film_id
GROUP BY f.title
ORDER BY rent_mov DESC;

-- Question7f
SELECT a.address, ct.city, co.country, SUM(p.amount) AS total_revenue
FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN customer AS c
    ON s.store_id=c.store_id
INNER JOIN payment AS p
    ON p.customer_id = c.customer_id
INNER JOIN city AS ct
    ON ct.city_id = a.city_id
INNER JOIN country AS co
    ON co.country_id = ct.country_id
GROUP BY a.address, ct.city, co.country;

-- Question7g
SELECT s.store_id, a.address, cy.city, co.country FROM store AS s
INNER JOIN address AS a
    ON s.address_id = a.address_id
INNER JOIN city AS cy
    ON cy.city_id = a.city_id
INNER JOIN country AS co
    ON co.country_id = cy.country_id;
    
-- Question7h

SELECT c.name, SUM(p.amount) AS gross_revenue
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN inventory AS i
    ON fc.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY name
ORDER BY gross_revenue DESC
LIMIT 5;

-- Question8a
CREATE VIEW top_five_gen_gross_rev AS
SELECT c.name, SUM(p.amount) AS gross_rev
FROM category AS c
INNER JOIN film_category AS fc
    ON c.category_id = fc.category_id
INNER JOIN inventory AS i
    ON fc.film_id = i.film_id
INNER JOIN rental AS r
    ON i.inventory_id = r.inventory_id
INNER JOIN payment AS p
    ON r.rental_id = p.rental_id
GROUP BY name
LIMIT 5;

-- Question8b

SELECT * FROM top_five_gen_gross_rev;

-- Question8c

DROP VIEW IF EXISTS top_five_gen_gross_rev;