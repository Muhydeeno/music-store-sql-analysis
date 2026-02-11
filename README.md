# music-store-sql-analysis
SQL analysis of a digital music store using PostgreSQL
# Music Store SQL Analysis (PostgreSQL)

## Project Overview
This project analyzes a digital music store database to uncover insights
about customer behavior, sales performance, and music preferences across countries
using PostgreSQL.

## Business Questions Answered
### Easy
- Identified the senior most employee based on job title
- Determined countries with the highest number of invoices
- Retrieved top 3 invoice values
- Found the city with the highest total invoice revenue
- Identified the highest-spending customer

### Moderate
- Identified Rock music listeners and ordered them alphabetically by email
- Determined top 10 Rock artists based on number of tracks
- Found tracks longer than the average song length

### Advanced
- Calculated total spending by each customer on artists
- Identified the most popular music genre by country using revenue
- Determined the top-spending customer per country, including ties

## Tools & Skills
- PostgreSQL
- SQL joins and aggregations
- Subqueries and Common Table Expressions (CTEs)
- Window functions (`DENSE_RANK`)
- Revenue analysis using quantity × unit_price
- Data grain awareness to prevent double counting

## Project Structure
queries/ → SQL queries
insights/ → Business insights

## Key Takeaways
- Revenue-based analysis provides more accurate insights than volume-based metrics
- Proper use of window functions ensures correct ranking when ties exist
- Understanding data grain is critical for accurate analysis

### SQL Projects

1. Music-Store-SQL-Analysis  
2. Multi-Country Sales Analysis
