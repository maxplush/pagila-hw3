/*
 * List the first and last names of all actors who:
 * 1. have appeared in at least one movie in the "Children" category,
 * 2. but that have never appeared in any movie in the "Horror" category.
 */

SELECT first_name, last_name
FROM (
    SELECT DISTINCT a.first_name, a.last_name, a.actor_id
    FROM actor a
    JOIN film_actor fa ON a.actor_id = fa.actor_id
    JOIN film f ON fa.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    WHERE c.name = 'Children'
      AND a.actor_id NOT IN (
          SELECT a2.actor_id
          FROM actor a2
          JOIN film_actor fa2 ON a2.actor_id = fa2.actor_id
          JOIN film f2 ON fa2.film_id = f2.film_id
          JOIN film_category fc2 ON f2.film_id = fc2.film_id
          JOIN category c2 ON fc2.category_id = c2.category_id
          WHERE c2.name = 'Horror'
      )
) sub
ORDER BY actor_id;

