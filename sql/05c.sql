/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

-- Get all film IDs with 3 or more actors from the 3 favorite films
WITH target_actors AS (
    SELECT DISTINCT fa.actor_id
    FROM film f
    JOIN film_actor fa ON f.film_id = fa.film_id
    WHERE f.title IN ('ACADEMY DINOSAUR', 'AGENT TRUMAN', 'AMERICAN CIRCUS')
),
films_with_matches AS (
    SELECT fa.film_id
    FROM film_actor fa
    JOIN target_actors ta ON fa.actor_id = ta.actor_id
    GROUP BY fa.film_id
    HAVING COUNT(DISTINCT fa.actor_id) >= 3
)
SELECT f.title
FROM film f
JOIN films_with_matches fm ON f.film_id = fm.film_id
ORDER BY f.title;

