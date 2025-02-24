# 🛒 Retail Sales Data Analysis

## 📖 Project Overview
This project focuses on **data cleaning, exploration, and analysis** of a **Retail Sales** database using SQL. The dataset contains transactional records, including sales, customer demographics, and product categories.

## 🚀 Features
- **Data Cleaning**: Identifies and removes null values to ensure data integrity.
- **Data Exploration**: Extracts insights like total sales, unique customers, and product categories.
- **Querying Sales Data**:
  - Retrieves sales records for specific periods.
  - Counts total transactions and unique customers.
  - Identifies popular product categories.

## 🗄️ Database Structure
The dataset includes the following key columns:
- `transactions_id`
- `sale_date`
- `sale_time`
- `customer_id`
- `gender`
- `age`
- `category`
- `quantiy`
- `price_per_unit`
- `cogs` (Cost of Goods Sold)
- `total_sale`
  
## 🔍 SQL Queries Used

- **Record Count**: Determine the total number of records in the dataset.
- **Customer Count**: Find out how many unique customers are in the dataset.
- **Category Count**: Identify all unique product categories in the dataset.
- **Null Value Check**: Check for any null values in the dataset and delete records with missing data.

```sql
SELECT COUNT(*) FROM retail_sales;
SELECT COUNT(DISTINCT customer_id) FROM retail_sales;
SELECT DISTINCT category FROM retail_sales;

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
```

### 3. Data Analysis & Findings

The following SQL queries were developed to answer specific business questions:

 **Write a SQL query to retrieve all transactions where the category is 'Clothing' and the quantity sold is more than 4 in the month of Nov-2022**:
```sql
SELECT 
  *
FROM retail_sales
WHERE 
    category = 'Clothing'
    AND 
    TO_CHAR(sale_date, 'YYYY-MM') = '2022-11'
    AND
    quantity >= 4
```

 **Write a SQL query to calculate the total sales (total_sale) for each category.**:
```sql
SELECT 
    category,
    SUM(total_sale) as net_sale,
    COUNT(*) as total_orders
FROM retail_sales
GROUP BY 1
```

 **Write a SQL query to find the average age of customers who purchased items from the 'Beauty' category.**:
```sql
SELECT
    ROUND(AVG(age), 2) as avg_age
FROM retail_sales
WHERE category = 'Beauty'
```
**Write a SQL query to find all transactions where the total_sale is greater than 1000.**:
```sql
SELECT * FROM retail_sales
WHERE total_sale > 1000
```
**Write a SQL query to Calculate Total transaction made by each gender in each category.**
```sql
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
```

**Write a SQL query to calculate the average sale for each month. Find out best selling month in each year**:
```sql
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
```
**Write a SQL query to find the top 5 customers based on the highest total sales**:
```sql
SELECT 
    customer_id,
    SUM(total_sale) as total_sales
FROM retail_sales
GROUP BY 1
ORDER BY 2 DESC
LIMIT 5
```
**Write a SQL query to find the number of unique customers who purchased items from each category.**:
```sql
SELECT 
    category,    
    COUNT(DISTINCT customer_id) as cnt_unique_cs
FROM retail_sales
GROUP BY category
```

 **Which age groups or genders contribute most to sales revenue?**:
```sql
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
ORDER BY age_group
```
**Calculating profit by category**
```sql
SELECT
    category,
    SUM (total_sale) as total_sales,
    SUM(COGS) as total_cogs,
    SUM(total_sale)- SUM(cogs) AS profit
FROM RETAIL_SALES
GROUP BY category;
```

## Findings

- **Customer Demographics**: The dataset includes customers from various age groups, with sales distributed across different categories such as Clothing and Beauty.
- **High-Value Transactions**: Several transactions had a total sale amount greater than 1000, indicating premium purchases.
- **Sales Trends**: Monthly analysis shows variations in sales, helping identify peak seasons.
- **Customer Insights**: The analysis identifies the top-spending customers and the most popular product categories.

## Reports

- **Sales Summary**: A detailed report summarizing total sales, customer demographics, and category performance.
- **Trend Analysis**: Insights into sales trends across different months and shifts.
- **Customer Insights**: Reports on top customers and unique customer counts per category

