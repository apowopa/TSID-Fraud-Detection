-- 02_silver/rebeca/03_dimensional_tables.sql
-- Tablas dimensionales para análisis
USE DATABASE CARD_TRANSACTION;

CREATE OR REPLACE TABLE SILVER.DIM_MERCHANTS AS
SELECT 
    MERCHANT_CLEAN,
    CATEGORY_CLEAN,
    COUNT(*) as transaction_count,
    AVG(AMOUNT) as avg_transaction_amount
FROM SILVER.TRANSACTIONS_ENHANCED
GROUP BY MERCHANT_CLEAN, CATEGORY_CLEAN;