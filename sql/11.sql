/* For each customer, find the movie that they have rented most recently.
 *
 * NOTE:
 * This problem can be solved with either a subquery (using techniques we've covered in class),
 * or a new type of join called a LATERAL JOIN.
 * You are not required to use LATERAL JOINs,
 * and we will not cover in class how to use them.
 * Nevertheless, they can greatly simplify your code,
 * and so I recommend that you learn to use them.
 * The website <https://linuxhint.com/postgres-lateral-join/> provides a LATERAL JOIN that solves this problem.
 * All of the subsequent problems in this homework can be solved with LATERAL JOINs
 * (or slightly less conveniently with subqueries).
 */

SELECT
  c.first_name,
  c.last_name,
  recent_rental.title,
  recent_rental.rental_date
FROM customer c
JOIN LATERAL (
    SELECT r.rental_date, f.title
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    WHERE r.customer_id = c.customer_id
    ORDER BY r.rental_date DESC
    LIMIT 1
) AS recent_rental ON true
ORDER BY c.last_name, c.first_name;

