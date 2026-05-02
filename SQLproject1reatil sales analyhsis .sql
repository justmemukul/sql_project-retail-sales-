-- sql retailsd sales analysis
create database project_sql_1 
-- create tabeles fro data base
drop table if exists retail_sales;
create table retail_sales(
    transactions_id int primary key,
	sale_date date,
	sale_time time,
	customer_id int,
	gender varchar(20),
	age int,
	category varchar(20),
	quantiy int,
	price_per_unit float,
	cogs float,
	total_sale float
);
select * from retail_sales;
select count(*)
 from retail_sales;
  select * from retail_sales
      where
           transactions_id is null
		   or
		   sale_date is null
		   or sale_time is null
		   or customer_id is null 
		   or gender is null
		   or category is null
		   or quantiy is null 
		   or price_per_unit is null 
		   or cogs is null
		   or total_sale is null ;

	delete from  retail_sales
	 where
           transactions_id is null
		   or
		   sale_date is null
		   or sale_time is null
		   or customer_id is null 
		   or gender is null
		   or category is null
		   or quantiy is null 
		   or price_per_unit is null 
		   or cogs is null
		   or total_sale is null ;

select count(*) from  retail_sales; --1987 left from 2000 because 3 values has null 
-- data exploring
-- how mnay sales we have 
select count(*) from retail_sales;
-- how manyb unique  custommers do we have 
select count(distinct customer_id) as total_sales from retail_sales;

-- how many diffrent item of category do we own 
select count(distinct category) as item from retail_sales;
select distinct category as item from retail_sales;


-- data analysis / business key prolems and insides 
-- Q1 Write a SQL query to retrieve all columns for sales made on '2022-11-05:
select * from retail_sales where sale_date ='2022-11-05';
-- Q2 Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022:
select  
   *
from retail_sales
where category = 'Clothing'
and quantiy >='4'
and YEAR(sale_date) = '2022'
and MONTH(sale_date) = '11'
;

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= 4
  AND FORMAT(sale_date, 'yyyy-MM') = '2022-11';

SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= '4'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-11-30';


-- Q3 Write a SQL query to calculate the total sales (total_sale) for each category.
---select *,sum(category) from retail_sales;
select category, 
    sum(total_sale) as net_sales,
	count(*) as total_orders
	from retail_sales 
	group by category ;


--Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.:
select 
   ROUND(avg(age), 2) as avg_age
   from retail_sales
   where category ='Beauty';

   SELECT 
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty';

SELECT 
    category,
    ROUND(AVG(age), 2) AS avg_age
FROM retail_sales
WHERE category = 'Beauty'
GROUP BY category;


SELECT avg(age) as avgage
   FROM retail_sales WHERE category = 'Beauty';

-- Q5 Write a SQL query to find all transactions where the total_sale is greater than 1000.:
select * from retail_sales where total_sale >= 1000 ;

-- Q6 Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.:

select 
	category,
	gender,
	count(*) as total_tr
	from retail_sales 
	group by  category,gender;

-- Write a SQL query to calculate the average sale for each month. Find out best selling month in each year:
select 
YEAR(sale_date) as sales_year,
MONTH(sale_date) as sales_month,
 avg(total_sale) as total_sales_avg
from retail_sales
group by YEAR(sale_date),
    MONTH(sale_date);

SELECT * FROM (
SELECT 
    YEAR(sale_date) AS year_sales,
    MONTH(sale_date) AS month_sales,
    AVG(total_sale) AS avg_total_sale,
	RANK() over(partition by   YEAR(sale_date) order by  AVG(total_sale) desc) as rank
FROM retail_sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date)
) AS  T1
WHERE RANK = 1

SELECT 
year_sales,
month_sales,
Avg_total_sale FROM (
SELECT 
    YEAR(sale_date) AS year_sales,
    MONTH(sale_date) AS month_sales,
    AVG(total_sale) AS avg_total_sale,
	RANK() over(partition by   YEAR(sale_date) order by  AVG(total_sale) desc) as rank
FROM retail_sales
GROUP BY 
    YEAR(sale_date),
    MONTH(sale_date)
) AS  T1
WHERE RANK = 1

--Q8 **Write a SQL query to find the top 5 customers based on the highest total sales **:
SELECT * FROM retail_sales;
SELECT TOP 5
	CUSTOMER_ID,	
		SUM(TOTAL_SALE) AS HIGHEST_SALES 
		FROM retail_sales 
	GROUP BY
		customer_id 
		ORDER BY
		HIGHEST_SALES DESC;

-- Q9 Write a SQL query to find the number of unique customers who purchased items from each category.:
SELECT	CATEGORY,
COUNT(DISTINCT CUSTOMER_ID) AS UNIQE_CUST
FROM retail_sales 
GROUP BY category

--- Q10 Write a SQL query to create each shift and number of orders

;WITH HOURLY_SALES
AS
(
SELECT *,
 CASE WHEN DATEPART(HOUR, sale_time) < 12 THEN 'MORNING'
		WHEN  DATEPART(HOUR, sale_time)BETWEEN 12 AND 17  THEN 'AFFTERNOON' 
		ELSE 'EVENING' END AS SHIFT
 FROM retail_sales);
 --end 