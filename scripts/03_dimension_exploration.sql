-- ============================================================
-- 03_dimension_exploration.sql
-- ============================================================
--
-- PURPOSE:
--   Profile the categorical (dimension) columns to understand what unique values exist and how the data is distributed.
--   Covers customers by country and gender, products by category and subcategory, and — importantly — a check for any products in the catalog that have never been sold.
--   This gives a full picture of the data before any numeric analysis starts.
--
-- WARNING:
--   The "products never sold" query uses a LEFT JOIN. 
--   Make sure the join key (product_id) exists and is named the same in both tables before running it — a key mismatch will silently return wrong results, not an error.
--   Also,NULL birthdates or blank country values in dim_customers will show up in these counts — worth noting if the numbers look unexpected.
-- ============================================================


-- ── Customers ────────────────────────────────────────────────

-- How many customers do we have per country?
SELECT
    country,
    COUNT(customer_id) AS total_customers
FROM gold.dim_customers
GROUP BY country
ORDER BY total_customers DESC;

-- Gender split across the customer 
SELECT
    gender,
    COUNT(*) AS total_customers
FROM gold.dim_customers
GROUP BY gender;


-- ── Products ─────────────────────────────────────────────────

-- See how many products sit in each category and subcategory
SELECT
    category,
    subcategory,
    COUNT(product_key) AS product_count
FROM gold.dim_products
GROUP BY category, subcategory
ORDER BY category, product_count DESC;


-- ── Products Never Sold ──────────────────────────────────────

-- LEFT JOIN to catch any catalog items that have zero sales history
-- These either need attention or should be removed
SELECT
    p.product_name,
    p.category,
    p.subcategory
FROM gold.dim_products p
LEFT JOIN gold.fact_sales f ON p.product_key = f.product_key
WHERE f.product_key IS NULL;
