-- ============================================================
-- 04_date_exploration.sql
-- ============================================================
--
-- PURPOSE:
--   Understand the time boundaries of the dataset before reporting any trends.
--   Checks how many years the data covers, how revenue and orders break down year by year,and how orders are distributed month by month.
--   Knowing this prevents mistakes like treating an incomplete yea as a real decline or missing a seasonal pattern entirely.
--
-- WARNING:
--   The most recent year in the data may be incomplete —
--   for example, if data was extracted mid-year, December numbers for that year don't exist yet. 
--   Comparing an incomplete year to a full one will make it look like a drop-off when it isn't. 
--   Always check the MAX(order_date) from the first query before drawing conclusions from the yearly or monthly breakdowns.
-- ============================================================


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
