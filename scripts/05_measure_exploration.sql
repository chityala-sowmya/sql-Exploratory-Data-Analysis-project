/*
===============================================================================
Measures Exploration (Key Metrics)
===============================================================================
Purpose:
    - To calculate aggregated metrics (e.g., totals, averages) for quick insights.
    - To identify overall trends or spot anomalies.

SQL Functions Used:
    - COUNT(), SUM(), NULLIF(),ROUND()
===============================================================================
*/



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

