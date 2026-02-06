/*Q6: Write a query to return the email, first name, last name, and genre of all rock music listeners.
Return your list ordered alphabetically by email starting with A.*/
SELECT
	DISTINCT c.email,
	c.first_name,
	c.last_name,
	g.name genre
From customer c
JOIN invoice i
ON c.customer_id = i.customer_id
JOIN invoice_line il
ON i.invoice_id = il.invoice_id
JOIN track t
ON t.track_id = il.track_id
JOIN genre g
ON g.genre_id = t.genre_id
WHERE g.name LIKE '%Rock%'
ORDER BY email


--Q7: Write a query that returns the artist name and the total track count of the top 10 rock bands--
SELECT
	a.name,
	COUNT(t.track_id) total_track
FROM artist a
JOIN album ab
ON a.artist_id = ab.artist_id
JOIN track t
ON t.album_id = ab.album_id
JOIN genre g
ON g.genre_id = t.genre_id
WHERE g.name LIKE '%Rock%'
GROUP BY a.name
ORDER BY total_track DESC
LIMIT 10


/*Q8: Return all the track names that has a song length longer than the average song length. Return the name
and milliseconds for each track. Order by the song length with the longest song listed first.*/
SELECT
	name track_names,
	milliseconds song_length
FROM track
WHERE milliseconds > (SELECT
						AVG(milliseconds)
					  FROM track)
ORDER BY song_length DESC
