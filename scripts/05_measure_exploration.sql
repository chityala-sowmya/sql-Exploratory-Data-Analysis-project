-- ============================================================
-- 05_measures_exploration.sql
-- ============================================================
--
-- PURPOSE:
--   Calculate the core business KPIs in one place — total revenue, total orders, units sold, unique customers,unique products, and average order value.
--   Also pulls basic customer age stats. This is the "big picture" snapshot that gives context for everything else in the analysis.
--
-- WARNING:
--   The avg_order_value calculation uses NULLIF to avoid adivide-by-zero error. 
--   If there are somehow zero orders in the table, it returns NULL instead of crashing that is intentional.
-- ============================================================


-- ── Core KPIs ────────────────────────────────────────────────

-- Revenue, orders, units, customers, products, avg order value — all in one place
SELECT
    SUM(sales_amount) AS total_revenue,
    COUNT(DISTINCT order_number)  AS total_orders,
    SUM(quantity) AS total_units_sold,
    COUNT(DISTINCT customer_key) AS unique_customers,
    COUNT(DISTINCT product_key) AS unique_products,
    ROUND(SUM(sales_amount) * 1.0 / NULLIF(COUNT(DISTINCT order_number), 0), 2)AS avg_order_value
FROM gold.fact_sales;

