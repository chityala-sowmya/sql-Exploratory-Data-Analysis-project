/*
===============================================================================
Database Exploration
===============================================================================
Purpose:
    - To explore the structure of the database, including the list of tables and their schemas.
    - To inspect the columns and metadata for specific tables.

Table Used:
    - INFORMATION_SCHEMA.TABLES
    - INFORMATION_SCHEMA.COLUMNS
===============================================================================
*/

-- ── Schema/Database Overview ─────────────────────────────────────────

-- See what tables exist and what columns they have
SELECT TABLE_NAME, COLUMN_NAME, DATA_TYPE
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_SCHEMA = 'gold'
ORDER BY TABLE_NAME, ORDINAL_POSITION;


-- ── Row Counts ───────────────────────────────────────────────

-- Quick check on how big each table is before touching anything
SELECT 'fact_sales' AS table_name, 
  COUNT(*) AS row_count 
FROM gold.fact_sales    
UNION ALL
SELECT 'dim_customers',               
  COUNT(*)            
FROM gold.dim_customers  
UNION ALL
SELECT 'dim_products',                
  COUNT(*)              
FROM gold.dim_products;
