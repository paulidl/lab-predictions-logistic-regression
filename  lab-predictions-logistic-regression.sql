/* Lab | Making predictions with logistic regression: In this lab, you will be using the Sakila database of movie rentals.

In order to optimize our inventory, we would like to know which films will be rented next month and we are asked to create a model to predict it.

Instructions
1. Create a query or queries to extract the information you think may be relevant for building the prediction model. 
It should include some film features and some rental features.
2. Read the data into a Pandas dataframe.
3. Analyze extracted features and transform them. You may need to encode some categorical variables, or scale numerical variables.
4. Create a query to get the list of films and a boolean indicating if it was rented last month. This would be our target variable.
5. Create a logistic regression model to predict this variable from the cleaned data.
6. Evaluate the results.
*/

USE sakila;

-- 1. Create a query or queries to extract the information you think may be relevant for building the prediction model. 
-- It should include some film features and some rental features.

SELECT * FROM sakila.rental;			## rental_id, customer_id, inventory_id
SELECT * FROM sakila.inventory;			## inventory_id, film_id
SELECT * FROM sakila.film;				## film_id, title, rental_rate, length, rental_duration
SELECT * FROM sakila.film_category;		## film_id, category_id
SELECT * FROM sakila.category;			## category_id, name

SELECT 
	f.film_id, 
    f.title, 
    c.category_id,
    c.name AS category, 
    count(r.inventory_id) AS times_rented, 
    f.rental_duration,
    f.rental_rate, 
    f.length, 
    f.rental_duration
FROM sakila.rental r
JOIN sakila.inventory i ON r.inventory_id = i.inventory_id
JOIN sakila.film f ON i.film_id = f.film_id
JOIN sakila.film_category fc ON f.film_id = fc.film_id
JOIN sakila.category c ON fc.category_id = c.category_id
GROUP BY i.film_id, c.name, c.category_id
ORDER BY f.film_id ASC;