#1 Find all films with maximum length or minimum rental duration (compared to all other films). 
#In other words let L be the maximum film length, and let R be the minimum rental duration in the table film. You need to find all films that have length L or duration R or both length L and duration R.
#You just need to return attribute film id for this query. 

SELECT film_id FROM film
WHERE rental_duration = ( SELECT MIN( rental_duration ) FROM film ) 
OR length = ( SELECT MAX( length ) FROM film ) ;

#2 We want to find out how many of each category of film ED CHASE has started in so return a table with category.name and the count
#of the number of films that ED was in which were in that category order by the category name ascending (Your query should return every category even if ED has been in no films in that category).

SELECT c.name, COUNT(a.actor_id)
FROM category AS c
LEFT JOIN film_category AS fc ON c.category_id = fc.category_id
LEFT JOIN film AS f ON fc.film_id = f.film_id
LEFT JOIN film_actor AS fa ON f.film_id = fa.film_id 
LEFT JOIN actor AS a ON fa.actor_id = a.actor_id AND (a.first_name = 'ED' AND a.last_name = 'CHASE')
GROUP BY  c.name;

#3 Find the first name, last name and total combined film length of Sci-Fi films for every actor
#That is the result should list the names of all of the actors(even if an actor has not been in any Sci-Fi films)and the total length of Sci-Fi films they have been in.

SELECT a.first_name, a.last_name,
   SUM(CASE WHEN c.name = 'Sci-Fi' THEN f.length ELSE 0 END) AS s
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
INNER JOIN film_category AS fc ON fa.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
GROUP BY c.name, a.actor_id
ORDER BY s DESC;

#4 Find the first name and last name of all actors who have never been in a Sci-Fi film

SELECT a.first_name, a.last_name
FROM actor AS a
INNER JOIN film_actor AS fa ON a.actor_id = fa.actor_id
INNER JOIN film AS f ON fa.film_id = f.film_id
INNER JOIN film_category AS fc ON fa.film_id = fc.film_id
INNER JOIN category AS c ON fc.category_id = c.category_id
WHERE c.name NOT IN (SELECT name FROM category WHERE name = 'Sci-Fi')
GROUP BY a.last_name ASC;

#5 Find the film title of all films which feature both KIRSTEN PALTROW and WARREN NOLTE
#Order the results by title, descending (use ORDER BY title DESC at the end of the query)
#Warning, this is a tricky one and while the syntax is all things you know, you have to think oustide
#the box a bit to figure out how to get a table that shows pairs of actors in movies

SELECT f.title FROM film as f
INNER JOIN film_actor AS fa ON f.film_id = fa.film_id
INNER JOIN actor AS a ON fa.actor_id = a.actor_id
WHERE a.actor_id = 
(SELECT actor_id FROM actor WHERE first_name = 'KIRSTEN' && last_name = 'PALTROW')
&&(SELECT actor_id FROM actor WHERE first_name = 'WARREN' && last_name = 'NOLTE')
GROUP BY f.title DESC;



