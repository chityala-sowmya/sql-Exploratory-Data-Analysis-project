/*
===============================================================================
Ranking Analysis
===============================================================================
Purpose:
    - To rank items (e.g., products, customers) based on performance or other metrics.
    - To identify top performers or laggards.

SQL Functions Used:
    - Window Ranking Functions: TOP
    - Clauses: GROUP BY, ORDER BY
===============================================================================
*/


-- ── Top 10 Products by Revenue ───────────────────────────────

-- Who is actually pulling the most weight in terms of sales?
SELECT TOP 10
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
LEFT JOIN gold.dim_products p 
ON f.product_key = p.product_key
GROUP BY p.product_name
ORDER BY total_revenue DESC;


-- ── Bottom 5 Products by Revenue ─────────────────────────────

-- Flip side — which products are barely contributing anything?
SELECT TOP 5
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
JOIN gold.dim_products p 
ON f.product_key = p.product_key
LEFT GROUP BY p.product_name
ORDER BY total_revenue ASC;


-- ── Top 10 Customers by Revenue ──────────────────────────────

-- High-value customers worth keeping track of
SELECT TOP 10
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(f.sales_amount) AS total_revenue,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key
GROUP BY c.first_name, c.last_name
ORDER BY total_revenue DESC;


-- ── Top 5 Countries by Order Count ───────────────────────────

-- Separate from revenue — a country can rank very differently by volume vs. value
SELECT TOP 5
    c.country,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
LEFT JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_orders DESC;
