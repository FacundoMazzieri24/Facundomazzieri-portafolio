-- 1. Total sales by city
SELECT
    city,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY city
ORDER BY total_sales DESC;


-- 2. Monthly sales trend
SELECT
    DATE_TRUNC('month', order_date) AS month,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY month
ORDER BY month;


-- 3. Sales by region and city
SELECT
    region,
    city,
    SUM(sales) AS total_sales
FROM sales_data
GROUP BY region, city
ORDER BY total_sales DESC;
