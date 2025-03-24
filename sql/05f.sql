/* 
 * Finding movies with similar categories still gives you too many options.
 *
 * Write a SQL query that lists all movies that share 2 categories with AMERICAN CIRCUS and 1 actor.
 *
 * HINT:
 * It's possible to complete this problem both with and without set operations,
 * but I find the version using set operations much more intuitive.
 */

-- Films that share 2+ categories with 'AMERICAN CIRCUS'
WITH shared_categories AS (
    SELECT fc2.film_id
    FROM film f1
    JOIN film_category fc1 ON f1.film_id = fc1.film_id
    JOIN film_category fc2 ON fc1.category_id = fc2.category_id
    WHERE f1.title = 'AMERICAN CIRCUS'
    GROUP BY fc2.film_id
    HAVING COUNT(DISTINCT fc2.category_id) >= 2
),

-- Films that share at least 1 actor with 'AMERICAN CIRCUS'
shared_actors AS (
    SELECT fa2.film_id
    FROM film f1
    JOIN film_actor fa1 ON f1.film_id = fa1.film_id
    JOIN film_actor fa2 ON fa1.actor_id = fa2.actor_id
    WHERE f1.title = 'AMERICAN CIRCUS'
    GROUP BY fa2.film_id
)

-- Final result: films in both sets
SELECT f.title
FROM film f
WHERE f.film_id IN (
    SELECT film_id FROM shared_categories
    INTERSECT
    SELECT film_id FROM shared_actors
)
ORDER BY f.title;

