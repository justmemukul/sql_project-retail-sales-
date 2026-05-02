# Retail Sales Analysis SQL Project

## Project Overview

**Project Title**: Retail Sales Analysis  

## Objectives

1. **Set up a retail sales database**: Create and populate a retail sales database with the provided sales data.
2. **Data Cleaning**: Identify and remove any records with missing or null values.
3. **Exploratory Data Analysis (EDA)**: Perform basic exploratory data analysis to understand the dataset.
4. **Business Analysis**: Use SQL to answer specific business questions and derive insights from the sales data.

## Project Structure

### 1. Database Setup

- **Database Creation**: The project starts by creating a database named `p1_retail_db`.
- **Table Creation**: A table named `retail_sales` is created to store the sales data. The table structure includes columns for transaction ID, sale date, sale time, customer ID, gender, age, product category, quantity sold, price per unit, cost of goods sold (COGS), and total sale amount.

```sql
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
```

### 2. Data Exploration & Cleaning

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
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

```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

1. **Write a SQL query to retrieve all columns for sales made on '2022-11-05**:
```sql
SELECT *
FROM retail_sales
WHERE sale_date = '2022-11-05';
```

2. **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT *
FROM retail_sales
WHERE category = 'Clothing'
  AND quantiy >= '4'
  AND sale_date >= '2022-11-01'
  AND sale_date < '2022-11-30';
```

3. **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
select category, 
    sum(total_sale) as net_sales,
	count(*) as total_orders
	from retail_sales 
	group by category ;
```

4. **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```

5. **Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```

6. **Write a SQL query to find the total number of transactions (transaction_id) made by each gender in each category.**:
```sql
select 
	category,
	gender,
	count(*) as total_tr
	from retail_sales 
	group by  category,gender;
```

7. **Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```

8. **Write a SQL query to find the top 5 customers based on the highest total sales **:
```sql
SELECT * FROM retail_sales;
SELECT TOP 5
	CUSTOMER_ID,	
		SUM(TOTAL_SALE) AS HIGHEST_SALES 
		FROM retail_sales 
	GROUP BY
		customer_id 
		ORDER BY
		HIGHEST_SALES DESC;
```

9. **Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT	CATEGORY,
COUNT(DISTINCT CUSTOMER_ID) AS UNIQE_CUST
FROM retail_sales 
GROUP BY category
```

10. **Write a SQL query to create each shift and number of orders (Example Morning <12, Afternoon Between 12 & 17, Evening >17)**:
```sql
;WITH HOURLY_SALES AS (
    SELECT *,
        CASE 
            -- Notice the CAST function added inside DATEPART
            WHEN DATEPART(HOUR, CAST(sale_time AS TIME)) < 12 THEN 'MORNING'
            WHEN DATEPART(HOUR, CAST(sale_time AS TIME)) BETWEEN 12 AND 17 THEN 'AFTERNOON' 
            ELSE 'EVENING' 
        END AS SHIFT
    FROM retail_sales
)
SELECT 
    SHIFT,
    COUNT(*) AS total_orders
FROM HOURLY_SALES
GROUP BY SHIFT;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category.

## Conclusion

This project serves as a comprehensive introduction to SQL for data analysts, covering database setup, data cleaning, exploratory data analysis, and business-driven SQL queries. The findings from this project can help drive business decisions by understanding sales patterns, customer behavior, and product performance.


## Author - MUKUL

This project is part of my portfolio, showcasing the SQL skills essential for data analyst roles. If you have any questions, feedback, or would like to collaborate, feel free to get in touch!




Thank you for your support, and I look forward to connecting with you!
