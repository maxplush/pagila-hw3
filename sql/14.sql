/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */ 


WITH film_rental_counts AS (
    SELECT 
        c.name AS category_name,
        f.title,
        COUNT(*) AS total_rentals
    FROM rental r
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film f ON i.film_id = f.film_id
    JOIN film_category fc ON f.film_id = fc.film_id
    JOIN category c ON fc.category_id = c.category_id
    GROUP BY c.name, f.title
),
ranked_films AS (
    SELECT 
        category_name,
        title,
        total_rentals,
        RANK() OVER (PARTITION BY category_name ORDER BY total_rentals DESC, title DESC) AS rank
    FROM film_rental_counts
)
SELECT 
    category_name AS name,
    title,
    total_rentals AS "total rentals"
FROM ranked_films
WHERE rank <= 5
ORDER BY name, "total rentals" DESC, title;

