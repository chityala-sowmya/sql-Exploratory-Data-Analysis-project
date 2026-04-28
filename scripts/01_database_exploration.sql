-- ============================================================
-- 01_database_exploration.sql
-- ============================================================
--
-- PURPOSE:
--   Before writing a single analysis query, I need to know what tables exist, what columns they have, and how many rows each table holds. 
--   This is the orientation step —
--   run it first on any new database you haven't worked with before.
--
-- WARNING:
--   This script reads from INFORMATION_SCHEMA, which is schema-specific.
--   Make sure the schema name in the WHERE clause matches your actual schema (here it's 'gold').
--   If your schema is named differently, update that filter or you'll get zero results and wonder why.
-- ============================================================


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
