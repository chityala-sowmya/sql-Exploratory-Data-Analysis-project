/*
===============================================================================
Dimensions Exploration
===============================================================================
Purpose:
    - To explore the structure of dimension tables.
	
SQL Functions Used:
    - DISTINCT
    - ORDER BY
===============================================================================
*/


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
