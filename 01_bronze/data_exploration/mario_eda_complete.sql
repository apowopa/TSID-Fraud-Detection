-- EDA COMPLETO - Mario
-- Análisis exploratorio de datos para detección de fraude

SELECT *
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
LIMIT 50;

//Cantidad de Registros en la tabla 

SELECT COUNT(*) AS total_rows
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//2.-Buscar NULOS en TODAS las columnas
//Columna ZIP

SELECT 
    COUNT(*) AS total_rows,
    COUNT(ZIP) AS non_null,
    COUNT(*) - COUNT(ZIP) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Columna Merchant

SELECT 
    COUNT(*) AS total_rows,
    COUNT(MERCHANT) AS non_null,
    COUNT(*) - COUNT(MERCHANT) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Category

SELECT 
    COUNT(*) AS total_rows,
    COUNT(CATEGORY) AS non_null,
    COUNT(*) - COUNT(CATEGORY) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//AMT

SELECT 
    COUNT(*) AS total_rows,
    COUNT(AMT) AS non_null,
    COUNT(*) - COUNT(AMT) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Columnas de información personal 
// First Name

SELECT 
    COUNT(*) AS total_rows,
    COUNT(FIRST_NAME) AS non_null,
    COUNT(*) - COUNT(FIRST_NAME) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Last name

SELECT 
    COUNT(*) AS total_rows,
    COUNT(LAST_NAME) AS non_null,
    COUNT(*) - COUNT(LAST_NAME) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Gender

SELECT 
    COUNT(*) AS total_rows,
    COUNT(GENDER) AS non_null,
    COUNT(*) - COUNT(GENDER) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//STREET

SELECT 
    COUNT(*) AS total_rows,
    COUNT(STREET) AS non_null,
    COUNT(*) - COUNT(STREET) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//City

SELECT 
    COUNT(*) AS total_rows,
    COUNT(CITY) AS non_null,
    COUNT(*) - COUNT(CITY) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//State

SELECT 
    COUNT(*) AS total_rows,
    COUNT(STATE) AS non_null,
    COUNT(*) - COUNT(STATE) AS null_count
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Sin datos nulos presentados en las columnas analizadas

//3.-Exploracion de fechas

SELECT
    MIN(TRANS_DATE_TRANS_TIME) AS fecha_minima,
    MAX(TRANS_DATE_TRANS_TIME) AS fecha_maxima
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;


//Revisar los anos que aparecen

SELECT 
    YEAR(TRANS_DATE_TRANS_TIME) AS anio,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY anio
ORDER BY anio;

//Revisar los meses

SELECT
    YEAR(TRANS_DATE_TRANS_TIME) AS anio,
    MONTH(TRANS_DATE_TRANS_TIME) AS mes,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY anio, mes
ORDER BY anio, mes;

//Horas del día

SELECT
    HOUR(TRANS_DATE_TRANS_TIME) AS hora,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY hora
ORDER BY hora;

//4.-Estadisticas descriptivas de montos AMT

SELECT 
    MIN(AMT) AS monto_minimo,
    MAX(AMT) AS monto_maximo
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS;

//Histograma por rangos de montos

SELECT
    CASE
        WHEN AMT < 10 THEN '1. 0 - 10'
        WHEN AMT < 50 THEN '2. 10 - 50'
        WHEN AMT < 100 THEN '3. 50 - 100'
        WHEN AMT < 200 THEN '4. 100 - 200'
        WHEN AMT < 500 THEN '5. 200 - 500'
        WHEN AMT < 1000 THEN '6. 500 - 1000'
        WHEN AMT < 5000 THEN '7. 1000 - 5000'
        ELSE '8. 5000+'
    END AS rango_montos,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY rango_montos
ORDER BY rango_montos;

//Distribución por categoría

SELECT
    CATEGORY,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY CATEGORY
ORDER BY total_transacciones DESC;

//Top 20 de merchants

SELECT 
    MERCHANT,
    COUNT(*) AS total_transacciones
FROM CARD_TRANSACTION.BRONZE.RAW_TRANSACTIONS
GROUP BY MERCHANT
ORDER BY total_transacciones DESC
LIMIT 20;