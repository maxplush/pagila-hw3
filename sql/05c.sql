/* 
 * You also like the acting in the movies ACADEMY DINOSAUR and AGENT TRUMAN,
 * and so you'd like to see movies with actors that were in either of these movies or AMERICAN CIRCUS.
 *
 * Write a SQL query that lists all movies where at least 3 actors were in one of the above three movies.
 * (The actors do not necessarily have to all be in the same movie, and you do not necessarily need one actor from each movie.)
 */

-- Get all film IDs with 3 or more actors from the 3 favorite films

SELECT title
FROM (
    SELECT f1.title, COUNT(*) AS actor_count
    FROM film f1
    JOIN film_actor fa1 USING (film_id)
    JOIN film_actor fa2 USING (actor_id)
    JOIN film f2 ON fa2.film_id = f2.film_id
    WHERE f2.title IN ('AMERICAN CIRCUS', 'ACADEMY DINOSAUR', 'AGENT TRUMAN')
    GROUP BY f1.title
) a
WHERE actor_count >= 3
ORDER BY title;

