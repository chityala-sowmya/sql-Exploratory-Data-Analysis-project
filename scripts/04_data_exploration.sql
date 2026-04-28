/*
===============================================================================
Date Exploration 
===============================================================================
Purpose:
    - To determine the temporal boundaries of key data points.
    - To understand the range of historical data.

SQL Functions Used:
    - MIN(), MAX(), DATEDIFF()
===============================================================================
*/



-- ── Date Range ───────────────────────────────────────────────

--Find the data of the first and last order
-- How many years of sales are available
SELECT
    MIN(order_date) AS first_order,
    MAX(order_date)  AS last_order,
    DATEDIFF(year, MIN(order_date), MAX(order_date)) AS years_covered
FROM gold.fact_sales;


-- ── Yearly Summary ───────────────────────────────────────────

-- Revenue and order count per year — good for spotting growth or drop-offs
SELECT
    YEAR(order_date) AS order_year,
    COUNT(order_number) AS total_orders,
    SUM(sales_amount) AS total_revenue
FROM gold.fact_sales
GROUP BY YEAR(order_date)
ORDER BY order_year;


-- ── Monthly Order Volume ─────────────────────────────────────

-- Break it down by month to check for seasonal patterns
SELECT
    YEAR(order_date) AS yy,
    MONTH(order_date) AS mm,
    COUNT(order_number) AS orders
FROM gold.fact_sales
GROUP BY YEAR(order_date), MONTH(order_date)
ORDER BY yy, mm;

-- ── Customer Age Stats ───────────────────────────────────────

-- Quick demographic check — average age and the full range
SELECT
    AVG(DATEDIFF(year, birthdate, GETDATE())) AS avg_age,
    MIN(DATEDIFF(year, birthdate, GETDATE())) AS youngest,
    MAX(DATEDIFF(year, birthdate, GETDATE())) AS oldest
FROM gold.dim_customers
WHERE birthdate IS NOT NULL;
