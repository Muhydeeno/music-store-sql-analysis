--Q9: Find how much amount spent by each customer on artist--
SELECT
	c.customer_id,
	CONCAT_WS(' ', first_name, last_name) full_name,
	a.name artist_name,
	ROUND(SUM(il.unit_price * il.quantity)::NUMERIC,2) total_spent
FROM customer c
JOIN invoice i
ON c.customer_id = i.customer_id
JOIN invoice_line il
ON il.invoice_id = i.invoice_id
JOIN track t
ON t.track_id = il.track_id
JOIN album ab
ON ab.album_id = t.album_id
JOIN artist a
ON a.artist_id = ab.artist_id 
GROUP BY 1,2,3
ORDER BY 4 DESC


/*Q10: We determine the most popular genre as the genre with the highest amount of purchases. Write a query that returns 
each country along with the top genre. For countries where the maximum number of purchases is shared,
return all genres.*/
WITH popular_genre AS(
	SELECT
		c.country,
		g.name genre_name,
		ROUND(SUM(il.quantity * il.unit_price)::NUMERIC,2) purchases
	FROM customer c
	JOIN invoice i
	ON c.customer_id = i.customer_id
	JOIN invoice_line il
	ON il.invoice_id = i.invoice_id
	JOIN track t
	ON t.track_id = il.track_id
	JOIN genre g
	ON g.genre_id = t.genre_id
	GROUP BY 1,2
	ORDER BY 1 ASC, 3 DESC	
),
ranked_genres AS(
	SELECT
		country,
		genre_name,
		purchases,
    	DENSE_RANK() OVER(
		PARTITION BY country
		ORDER BY purchases DESC) AS genre_rank
	FROM popular_genre
)
SELECT *
FROM ranked_genres
WHERE genre_rank = 1


/*Q11: Write a query that detemines the customer that has spent the most on music for each country. Write a query that
returns the country along with the top customer and how much they spent. For country where the top amount spent is 
shared, provide all customer who spent this amount.*/
WITH customer_spending AS (
      			SELECT
				  c.customer_id,
				  CONCAT_WS(' ', c.first_name, c.last_name) full_name,
				  i.billing_country,
				  ROUND(SUM(i.total)::NUMERIC,2) total_spent
				 FROM customer c
				 JOIN invoice i
				 ON c.customer_id = i.customer_id
				 GROUP BY 1,2,3
				 ORDER BY 3 ASC, 4 DESC				 
),
ranked_customer AS (
		SELECT
			customer_id,
			full_name,
			billing_country,
			total_spent,
			DENSE_RANK() OVER(
			PARTITION BY billing_country
			ORDER BY total_spent DESC) AS spend_rank
		FROM customer_spending
)
SELECT *
FROM ranked_customer
WHERE spend_rank = 1
