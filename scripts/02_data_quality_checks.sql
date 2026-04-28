-- ============================================================
-- 02_data_quality_checks.sql
-- ============================================================
--
-- PURPOSE:
--   Run this before doing any real analysis. 
--   The goal is to catch obvious data problems early — missing values in key columns, duplicate order records, and sales amounts that shouldn't exist (zero or negative).
--   If anything looks off here, the analysis numbers downstream won't be reliable.
--
-- WARNING:
--   This script only flags problems — it does not fix them.
--   If duplicates or NULLs show up, investigate the source data before proceeding.
--   Do not just ignore the results and move on to analysis.
--   Also note that COUNT(column_name) skips NULLs by design — that's intentional here, not a bug.
-- ============================================================


-- ── NULL Checks ──────────────────────────────────────────────

-- See how many rows are actually complete on the columns that matter
SELECT
    COUNT(*) AS total_rows,
    COUNT(customer_id) AS has_customer,
    COUNT(order_date) AS has_date,
    COUNT(sales_amount) AS has_amount
FROM gold.fact_sales;


-- ── Duplicate Orders ─────────────────────────────────────────

-- Catch any order numbers that show up more than once
SELECT order_number, 
  COUNT(*) AS times_seen
FROM gold.fact_sales
GROUP BY order_number
HAVING COUNT(*) > 1;


-- ── Bad Sales Amounts ────────────────────────────────────────

-- Flag rows where the sales amount is zero or negative — shouldn't happen
SELECT COUNT(*) AS suspicious_rows
FROM gold.fact_sales
WHERE sales_amount <= 0;
