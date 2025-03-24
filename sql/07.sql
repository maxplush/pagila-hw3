/*
 * List all actors with Bacall Number 2;
 * That is, list all actors that have appeared in a film with an actor that has appeared in a film with 'RUSSELL BACALL',
 * but do not include actors that have Bacall Number < 2.
 */

-- Step 1: Find Russell's actor_id
WITH russell AS (
    SELECT actor_id FROM actor
    WHERE first_name = 'RUSSELL' AND last_name = 'BACALL'
),

-- Step 2: Actors who acted with Russell (Bacall #1)
bacall_1 AS (
    SELECT DISTINCT fa2.actor_id
    FROM film_actor fa1
    JOIN film_actor fa2 ON fa1.film_id = fa2.film_id
    WHERE fa1.actor_id = (SELECT actor_id FROM russell)
      AND fa2.actor_id != fa1.actor_id
),

-- Step 3: Actors who acted with Bacall #1 actors (Bacall #2+)
bacall_2_plus AS (
    SELECT DISTINCT fa3.actor_id
    FROM film_actor fa2
    JOIN film_actor fa3 ON fa2.film_id = fa3.film_id
    WHERE fa2.actor_id IN (SELECT actor_id FROM bacall_1)
      AND fa3.actor_id != fa2.actor_id
),

-- Step 4: Remove Bacall #0 and #1
bacall_2_only AS (
    SELECT actor_id
    FROM bacall_2_plus
    WHERE actor_id NOT IN (SELECT actor_id FROM bacall_1)
      AND actor_id != (SELECT actor_id FROM russell)
)

-- Final result: Get names
SELECT DISTINCT a.first_name || ' ' || a.last_name AS "Actor Name"
FROM actor a
JOIN bacall_2_only b2 ON a.actor_id = b2.actor_id
ORDER BY "Actor Name";

