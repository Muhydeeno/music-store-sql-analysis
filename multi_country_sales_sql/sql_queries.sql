-- Multi-Country Sales Analysis
-- Database: PostgreSQL
-- Focus: UNION ALL, data cleaning, profit analysis

--This is a single line comment--
/*This is a multi
line comment*/

--Create Database--
--Create Table sales_us, sales_uk, sales_nigeria, sales_india, sales_china, sales_canada--
--Bringing in Our Datasets--
Create Table Sales_canada (Transaction_ID Varchar(100),	
						"Date" Date,	
						Country Varchar(10),	
						Product_ID Varchar(100),	
						Product_Name Varchar(20),	
						Category Varchar(50),	
						Price_per_Unit numeric,	
						Quantity_Purchased int,	
						Cost_Price numeric,
						Discount_Applied numeric,
						Payment_Method Varchar(20),
						Customer_Age_Group Varchar(15),
						Customer_Gender Varchar(10),
						Store_Location Varchar(20),
						Sales_Rep Varchar(50))


--Viewing our data--
Select
	*
From Sales_canada


--Q1: Appending the six dataset together, and creating a table for it--
Create Table all_sales AS
Select
	*
From sales_us
Union All
Select
	*
From sales_uk
Union All
Select
	*
From sales_nigeria
Union All
Select
	*
From sales_india
Union All
Select
	*
From sales_china
Union All
Select
	*
From sales_canada;


--Viewing our data--
Select
	*
From all_sales


/*Q2: Checking for missing values on columns Country, Price Per Unit, Quantity Purchased, Cost Price,
and Discont Applied*/
Select
	transaction_id,
	country,
	price_per_unit,
	quantity_purchased,
	cost_price,
	discount_applied
From all_sales
Where country is null 
	  or price_per_unit is null
	  or quantity_purchased is null
	  or cost_price is null
	  or discount_applied is null


--Q3: Updating null Quantity Purchased--
Update all_sales
Set quantity_purchased = 3
where transaction_id = '00a30472-89a0-4688-9d33-67ea8ccf7aea'


--Q4: Updating null Price Per Unit to Avg Price Per Unit--
update all_sales
Set price_per_unit = (select avg(price_per_unit) 
From all_sales
where price_per_unit is not null)
where transaction_id = '001898f7-b696-4356-91dc-8f2b73d09c63'


--Checking for our updated null values--
Select
	price_per_unit
From all_sales
where  transaction_id = '001898f7-b696-4356-91dc-8f2b73d09c63'


--Q5: Checking for duplicate values transaction ID--
Select
	Transaction_id,
	count(*)
From all_sales
group by 1
having count(*)>1


--Q6: Adding “Total Amount” column--
Alter table all_sales
add column "total_amount" numeric


--Q7: Updating Total Amount column--
Update all_sales
set total_amount = (price_per_unit*quantity_purchased)-(discount_applied)


--Viewing Our Data--
select
	*
From all_sales


--Q8: Adding “Profit” column--
Alter table all_sales
add column "profit" numeric


--Q9: Updating Profit column--
update all_sales
set profit = (total_amount-(cost_price*quantity_purchased))


--Q10: Sales Revenue & Profit by Country--
select 
	country,
	Round(sum(total_amount),0) total_revenue,
	Round(sum(profit),0) total_profit
From all_sales
group by 1


--Viewing Our Data--
Select
	*
From all_sales


--Q11: Best Selling Products--
Select
	product_name Best_Selling_Product,
	Round(Sum(total_amount),0) Revenue
From all_sales
Group by 1
Order by Revenue Desc


--Q12: Best Sales Representatives
Select
	sales_rep Best_Sales_Representative,
	Round(Sum(total_amount),0) Revenue
From all_sales
Group by 1
Order by Revenue Desc


--Q13: Which store locations generated the highest sales?
Select
	store_location Best_Store_location,
	Round(Sum(total_amount),0) Revenue
From all_sales
Group by 1
Order by Revenue Desc
