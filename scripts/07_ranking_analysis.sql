-- ============================================================
-- 07_ranking_analysis.sql
-- ============================================================
--
-- PURPOSE:
--   Find the best and worst performers across products and customers.
--   Ranks by revenue to identify who is driving the most value, and flips to order count for countries to check whether volume rankings differ from revenue rankings.
--   The bottom-5 products query is just as useful as the top-10 — underperformers are worth flagging too.
--
-- WARNING:
--   TOP N with ORDER BY gives different results depending on ties. 
--   If two products have the exact same revenue, SQL Server will arbitrarily pick one to include and leave the other out — there is no guarantee which one you get.
--   For the customer ranking, names are concatenated with first_name + ' ' + last_name — if either column has a NULL value, the full name will come back as NULL.
--   Check the dim_customers table for NULL names before using this output anywhere visible.
-- ============================================================


-- ── Top 10 Products by Revenue ───────────────────────────────

-- Who is actually pulling the most weight in terms of sales?
SELECT TOP 10
    p.product_name,
    SUM(f.sales_amount) AS total_revenue
FROM gold.fact_sales f
JOIN gold.dim_products p 
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
GROUP BY p.product_name
ORDER BY total_revenue ASC;


-- ── Top 10 Customers by Revenue ──────────────────────────────

-- High-value customers worth keeping track of
SELECT TOP 10
    c.first_name + ' ' + c.last_name AS customer_name,
    SUM(f.sales_amount) AS total_revenue,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key
GROUP BY c.first_name, c.last_name
ORDER BY total_revenue DESC;


-- ── Top 5 Countries by Order Count ───────────────────────────

-- Separate from revenue — a country can rank very differently by volume vs. value
SELECT TOP 5
    c.country,
    COUNT(DISTINCT f.order_number) AS total_orders
FROM gold.fact_sales f
JOIN gold.dim_customers c 
ON f.customer_key = c.customer_key
GROUP BY c.country
ORDER BY total_orders DESC;
