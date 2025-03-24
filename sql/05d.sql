/* 
 * In the previous query, the actors could come from any combination of movies.
 * Unfortunately, you've found that if the actors all come from only 1 or 2 of the movies,
 * then there is not enough diversity in the acting talent.
 *
 * Write a SQL query that lists all of the movies where:
 * at least 1 actor was also in AMERICAN CIRCUS,
 * at least 1 actor was also in ACADEMY DINOSAUR,
 * and at least 1 actor was also in AGENT TRUMAN.
 *
 * HINT:
 * There are many ways to solve this problem,
 * but I personally found the INTERSECT operator to make a convenient solution.
 */

SELECT f.title
FROM film f
WHERE f.film_id IN (
    -- Films with at least one actor from AMERICAN CIRCUS
    SELECT fa1.film_id
    FROM film_actor fa1
    WHERE fa1.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title = 'AMERICAN CIRCUS'
    )

    INTERSECT

    -- Films with at least one actor from ACADEMY DINOSAUR
    SELECT fa2.film_id
    FROM film_actor fa2
    WHERE fa2.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title = 'ACADEMY DINOSAUR'
    )

    INTERSECT

    -- Films with at least one actor from AGENT TRUMAN
    SELECT fa3.film_id
    FROM film_actor fa3
    WHERE fa3.actor_id IN (
        SELECT fa.actor_id
        FROM film f
        JOIN film_actor fa ON f.film_id = fa.film_id
        WHERE f.title = 'AGENT TRUMAN'
    )
)
ORDER BY f.title;

