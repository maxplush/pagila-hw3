/* 
 * A new James Bond movie will be released soon, and management wants to send promotional material to "action fanatics".
 * They've decided that an action fanatic is any customer where at least 4 of their 5 most recently rented movies are action movies.
 *
 * Write a SQL query that finds all action fanatics.
 */

-- Check what each customer's top 5 rentals and categories are

WITH recent_rentals AS (
  SELECT
    r.rental_id,
    r.customer_id,
    ROW_NUMBER() OVER (PARTITION BY r.customer_id ORDER BY r.rental_date DESC) AS rank
  FROM rental r
)

, rental_categories AS (
  SELECT
    r.rental_id,
    r.customer_id,
    cat.name AS category
  FROM rental r
  JOIN inventory i ON r.inventory_id = i.inventory_id
  JOIN film f ON i.film_id = f.film_id
  JOIN film_category fc ON f.film_id = fc.film_id
  JOIN category cat ON fc.category_id = cat.category_id
)

-- Now join recent rentals to their categories
SELECT c.customer_id, c.first_name, c.last_name
FROM customer c
JOIN recent_rentals rr ON rr.customer_id = c.customer_id
JOIN rental_categories rc ON rc.rental_id = rr.rental_id
WHERE rr.rank <= 5 AND rc.category = 'Action'
GROUP BY c.customer_id, c.first_name, c.last_name
HAVING COUNT(*) >= 4
ORDER BY c.customer_id;

