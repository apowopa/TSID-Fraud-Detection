-- 02_silver/rebeca/04_validation_queries.sql
-- Queries de verificación y calidad de datos

-- Verificar distribución de fraudes en Silver
SELECT 
    TRANSACTION_TYPE,
    COUNT(*) as count,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER(), 2) as percentage
FROM SILVER.TRANSACTIONS_ENHANCED
GROUP BY TRANSACTION_TYPE;

-- Verificar features temporales
SELECT 
    HOUR_OF_DAY,
    COUNT(*) as transactions
FROM SILVER.TRANSACTIONS_ENHANCED
GROUP BY HOUR_OF_DAY
ORDER BY HOUR_OF_DAY;

-- Verificar categorías de montos
SELECT 
    AMOUNT_CATEGORY,
    COUNT(*) as transactions
FROM SILVER.TRANSACTIONS_ENHANCED
GROUP BY AMOUNT_CATEGORY;
