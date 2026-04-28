-- ============================================================
-- 05_measures_exploration.sql
-- ============================================================
--
-- PURPOSE:
--   Calculate the core business KPIs in one place — total revenue, total orders, units sold, unique customers,unique products, and average order value.
--   Also pulls basic customer age stats. This is the "big picture" snapshot that gives context for everything else in the analysis.
--
-- WARNING:
--   The avg_order_value calculation uses NULLIF to avoid a
--   divide-by-zero error. If there are somehow zero orders
--   in the table, it returns NULL instead of crashing —
--   that is intentional. For the age calculation, rows where
--   birthdate is NULL are excluded via the WHERE clause.
--   If a large share of customers have no birthdate, the age
--   stats will not represent the full customer base — check
--   the NULL count from script 02 before reading these numbers.
-- ============================================================


-- ── Core KPIs ────────────────────────────────────────────────

-- Revenue, orders, units, customers, products, avg order value — all in one place
SELECT
    SUM(sales_amount)                          AS total_revenue,
    COUNT(DISTINCT order_number)               AS total_orders,
    SUM(quantity)                              AS total_units_sold,
    COUNT(DISTINCT customer_id)                AS unique_customers,
    COUNT(DISTINCT product_id)                 AS unique_products,
    ROUND(
        SUM(sales_amount) * 1.0
        / NULLIF(COUNT(DISTINCT order_number), 0), 2
    )                                          AS avg_order_value
FROM gold.fact_sales;


-- ── Customer Age Stats ───────────────────────────────────────

-- Quick demographic check — average age and the full range
SELECT
    AVG(DATEDIFF(year, birthdate, GETDATE())) AS avg_age,
    MIN(DATEDIFF(year, birthdate, GETDATE())) AS youngest,
    MAX(DATEDIFF(year, birthdate, GETDATE())) AS oldest
FROM gold.dim_customers
WHERE birthdate IS NOT NULL;
