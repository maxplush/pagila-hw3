/*
 * Management also wants to create a "best sellers" list for each category.
 *
 * Write a SQL query that:
 * For each category, reports the five films that have been rented the most for each category.
 *
 * Note that in the last query, we were ranking films by the total amount of payments made,
 * but in this query, you are ranking by the total number of times the movie has been rented (and ignoring the price).
 */ 


WITH film_rentals AS (
    SELECT
        c.name,
        f.title,
        COUNT(r.rental_id) AS total_rentals
    FROM
        category c
        JOIN film_category fc ON c.category_id = fc.category_id
        JOIN film f ON fc.film_id = f.film_id
        JOIN inventory i ON f.film_id = i.film_id
        JOIN rental r ON i.inventory_id = r.inventory_id
    GROUP BY
        c.name, f.title
),
ranked_films AS (
    SELECT
        name,
        title,
        total_rentals,
        ROW_NUMBER() OVER (
            PARTITION BY name
            ORDER BY total_rentals DESC, title ASC
        ) AS rank
    FROM film_rentals
)
SELECT
    name,
    title,
    total_rentals AS "total rentals"
FROM ranked_films
WHERE rank <= 5
ORDER BY name, rank;

