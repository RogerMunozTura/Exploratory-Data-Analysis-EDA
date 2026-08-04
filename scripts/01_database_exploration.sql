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

SELECT 
    TABLE_CATALOG, 
    TABLE_SCHEMA, 
    TABLE_NAME, 
    TABLE_TYPE
FROM INFORMATION_SCHEMA.TABLES;

-- Retrieve all columns for the three gold tables
SELECT 
    TABLE_NAME,
    COLUMN_NAME, 
    DATA_TYPE, 
    IS_NULLABLE, 
    CHARACTER_MAXIMUM_LENGTH
FROM INFORMATION_SCHEMA.COLUMNS
WHERE TABLE_NAME IN ('dim_customers', 'dim_products', 'fact_sales')
ORDER BY TABLE_NAME, ORDINAL_POSITION;

/*
===============================================================================
Conclusion
===============================================================================
- The table uses appropriate data types such as INT, NVARCHAR(50), and DATE.
- The columns allow NULL values, indicating that missing data may exist and
  should be considered.
===============================================================================
*/

