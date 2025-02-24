-- data cleaning
SELECT * FROM RETAIL_SALES
WHERE
transactions_id IS NULL
OR
Sale_date IS NULL
OR
Sale_time IS NULL
OR
Customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
Category IS NULL
OR
Quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;

DELETE FROM RETAIL_SALES
WHERE
transactions_id IS NULL
OR
Sale_date IS NULL
OR
Sale_time IS NULL
OR
Customer_id IS NULL
OR
gender IS NULL
OR
age IS NULL
OR
Category IS NULL
OR
Quantiy IS NULL
OR 
price_per_unit IS NULL
OR 
cogs IS NULL
OR 
total_sale IS NULL;

SELECT * FROM RETAIL_SALES 

--data exploration
--Calculating Sale records
SELECT count (total_sale) total_sale FROM RETAIL_SALES

--Calculating Customers
SELECT COUNT(DISTINCT customer_id) FROM RETAIL_SALES

--Identifying all Categories
SELECT DISTINCT category FROM RETAIL_SALES

--Retriving all transaction have quatity equals or more than 4 from Clothing in November 2022
SELECT * FROM RETAIL_SALES
WHERE
category = 'Clothing'
AND
TO_CHAR (sale_date, 'YYYY-MM') = '2022-11'
AND 
Quantiy >= 4

--Calculating Total sale by each category
SELECT
    category,
    sum(total_sale) as net_sale,
    count(quantiy)as total_order 
 from retail_sales
    GROUP BY category
	
--Calculating avg age of customers purchasing from beauty Category
SELECT
AVG(age)as AVG_AGE
FROM Retail_sales
WHERE Category = 'Beauty'

--Calculate Total transaction made by each gender in each category
SELECT
    category,
    gender,
    COUNT (*) as total_trans
from retail_sales
GROUP
    BY
    category,
    gender
ORDER BY category

--Calculating the avg sale of each month, also finding out the highest sales month in each year
SELECT
    Year,
	month,
	avg_sales
from
(
SELECT
	EXTRACT(YEAR FROM sale_date) AS Year,
    EXTRACT(MONTH FROM sale_date) AS month,
    AVG(total_sale) AS avg_sales,
    RANK() OVER (PARTITION BY EXTRACT(YEAR FROM sale_date) ORDER BY AVG(total_sale) DESC) AS sales_rank
FROM retail_sales
GROUP BY Year, month
) as T1
--ORDER BY 1,3 DESC

select * from retail_sales

--How have total sales, average sales per transaction, or the number of transactions changed over days, weeks, or months?
SELECT 
    sale_date, 
    SUM(total_sale) AS daily_sales
FROM RETAIL_SALES
GROUP BY sale_date
ORDER BY sale_date;

SELECT 
    date_trunc('month', sale_date) AS month, 
    SUM(total_sale) AS monthly_sales
FROM RETAIL_SALES
GROUP BY month
ORDER BY month;

--Which age groups or genders contribute most to sales revenue?

SELECT
    CASE
	    WHEN age < 20 THEN 'UNDER 20'
		WHEN AGE BETWEEN 20 AND 39 THEN '20-39'
		WHEN AGE BETWEEN 40 AND 59 THEN '40-59'
		ELSE '60+'
		END AS age_group,
		SUM(total_sale) AS total_sales,
		ROUND(AVG(total_sale)::numeric, 2) AS avg_sales,
		COUNT(DISTINCT customer_id) AS num_customers
FROM RETAIL_SALES
GROUP BY age_group
ORDER BY age_group;

--Calculating profit by category
SELECT
    category,
    SUM (total_sale) as total_sales,
    SUM(COGS) as total_cogs,
    SUM(total_sale)- SUM(cogs) AS profit
FROM RETAIL_SALES
GROUP BY category;





 
		




