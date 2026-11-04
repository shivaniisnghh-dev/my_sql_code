DROP DATABASE IF EXISTS groupby_exercise;
CREATE DATABASE groupby_exercise;
USE groupby_exercise;
CREATE TABLE sales (
order_id INT PRIMARY KEY,
order_date DATE,
region VARCHAR(20),
category VARCHAR(30),
salesperson VARCHAR(30),
quantity INT,
amount DECIMAL(10,2)
);
	
INSERT INTO sales
(order_id, order_date, region, category, salesperson, quantity, amount)
VALUES
(1, '2026-01-05', 'North', 'Laptop', 'Amit', 2, 120000.00),
(2, '2026-01-08', 'North', 'Mobile', 'Neha', 5, 75000.00),
(3, '2026-01-12', 'South', 'Laptop', 'Ravi', 1, 62000.00),
(4, '2026-01-15', 'East', 'Accessories', 'Pooja', 8, 16000.00),
(5, '2026-01-18', 'West', 'Mobile', 'Karan', 3, 48000.00),
(6, '2026-01-22', 'North', 'Accessories', 'Amit', 10, 22000.00),
(7, '2026-01-25', 'South', 'Mobile', 'Ravi', 4, 60000.00),
(8, '2026-01-28', 'East', 'Laptop', 'Pooja', 2, 118000.00),
(9, '2026-02-02', 'West', 'Accessories', 'Karan', 6, 15000.00),
(10, '2026-02-05', 'North', 'Laptop', 'Neha', 1, 65000.00),
(11, '2026-02-09', 'South', 'Accessories', 'Ravi', 12, 24000.00),
(12, '2026-02-12', 'East', 'Mobile', 'Pooja', 3, 51000.00),
(13, '2026-02-15', 'West', 'Laptop', 'Karan', 2, 126000.00),
(14, '2026-02-18', 'North', 'Mobile', 'Amit', 6, 90000.00),
(15, '2026-02-22', 'South', 'Laptop', 'Ravi', 2, 124000.00),
(16, '2026-02-25', 'East', 'Accessories', 'Pooja', 5, 11000.00),
(17, '2026-03-01', 'West', 'Mobile', 'Karan', 4, 64000.00),
(18, '2026-03-04', 'North', 'Accessories', 'Neha', 7, 17500.00),
(19, '2026-03-08', 'South', 'Mobile', 'Ravi', 5, 78000.00),
(20, '2026-03-12', 'East', 'Laptop', 'Pooja', 1, 60000.00),
(21, '2026-03-16', 'West', 'Accessories', 'Karan', 9, 21000.00),
(22, '2026-03-20', 'North', 'Laptop', 'Amit', 3, 186000.00),
(23, '2026-03-24', 'South', 'Accessories', 'Ravi', 6, 13500.00),
(24, '2026-03-28', 'East', 'Mobile', 'Pooja', 7, 112000.00);

select * from sales;


-- 1 Display the number of orders in each region. Show the region and total number of orders,,
select region , count(*) as total_orders
from sales
group by region;


-- 2 Find the total sales amount for each product category. Show category and total sales amount.
select category , sum(amount) as total_sale_amount
from sales
group by category;


-- 3 Find the average order amount handled by each salesperson. Show salesperson and average amount.
select salesperson , avg(amount) as avg_amount
from sales
group by salesperson;

-- 4. Find the total quantity sold in each region.
select region , sum(quantity) as total_quantity
from sales
group by region;


/* 5 Group the data by region and category, and display the total sales amount for every region-category
   combination*/
select region , category , sum(amount) as sales_amount
from sales
group by region , category;

/* 6. Group the data by region, category, and salesperson. For every combination, display the number of
   orders and total sales amount.*/
 select   region ,category , salesperson , count(*) as total_order , sum(amount) as total_amount
 from sales
 group by region , category , salesperson;
 
-- 7. Display only those regions that have more than 5 orders. Use COUNT() with HAVING. 
 select order_id , region , sum(quantity)
 from sales
 group by order_id
 having count(quantity) > 5;
 
-- 8. Display only those product categories whose total sales amount is greater than 150000.
 select category , sum(amount) as total_sale_amount
 from sales
 group by category
 having total_sale_amount > 150000;
 
 -- 9 Display only those salespersons whose average order amount is greater than 60000.
 select salesperson , avg(amount) as order_amount
 from sales
 group by salesperson
 having order_amount > 60000;
 
 /* 10. Group the data by region and category. Display only those groups where the total quantity sold is at
-- least 12.*/
 
 select region , category , sum(quantity) as total_sale
 from sales
 group by region , category 
 having total_sale > 12;
 
 
/* 11. For orders placed on or after 2026-02-01, group the data by region and salesperson. Display only
   those groups whose total sales amount is greater than 100000. Use WHERE before GROUP BY and
   HAVING after GROUP BY.*/
   
select region , salesperson , sum(amount) as total_sale_amount
from sales
where order_date > 2026-02-01
group by region , salesperson
having total_sale_amount >100000;

/* 12. Group the data by region, category, and salesperson. Display the number of orders, total quantity,
and total sales amount for each group. Show only groups whose total sales amount is at least 50000,
and sort the result from highest to lowest total sales amount.*/

select region , category , salesperson ,count(*) as total_orders ,sum(quantity) as total_quantity , sum(amount) as total_sales_amount
from sales
group by region , category , salesperson
having total_sales_amount > 50000
order by total_sales_amount asc;