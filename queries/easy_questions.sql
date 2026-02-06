--Q1: Who is the most senior employee based on job title--
SELECT *
FROM employee
ORDER BY levels DESC
LIMIT 1


--Q2: Which Country have the most invoices--
SELECT
	billing_country,
	COUNT(invoice_id) invoices
From invoice
GROUP BY 1
ORDER BY invoices DESC


--Q3: What are the top three values of total invoices--
SELECT
	ROUND(total ::NUMERIC,2)
FROM invoice
ORDER BY total DESC
LIMIT 3


--Q4 Write a query that returns one city that has the highest sum of invoice totals--
SELECT
	billing_city,
	ROUND(SUM(total)::NUMERIC,2) invoice_total
FROM invoice
GROUP BY 1
ORDER BY invoice_total DESC
LIMIT 1


--Q5: Write a query that returns the person who has spent the most money--
SELECT
	c.customer_id,
	CONCAT_WS(' ', first_name, last_name) full_name,
	ROUND(SUM(i.total)::NUMERIC,2) total
FROM customer c
Join invoice i
ON c.customer_id = i.customer_id
GROUP BY c.customer_id
ORDER BY total DESC
LIMIT 1
