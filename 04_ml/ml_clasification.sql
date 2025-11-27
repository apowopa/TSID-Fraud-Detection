-----------------------------------------------------------
-- SETUP
-----------------------------------------------------------
use role ACCOUNTADMIN;
use warehouse SNOWFLAKE_LEARNING_WH;
use database CARD_TRANSACTION;
use schema GOLD;
-- Inspect the first 10 rows of your training data. This is the data we'll
-- use to create your model.
select
    *
from
    TRANSACTION_GOLD
limit
    10;
-- Inspect the first 10 rows of your prediction data. This is the data the model
    -- will use to generate predictions.
select
    *
from
    TRANSACTION_GOLD
limit
    10;
-----------------------------------------------------------
    -- CREATE PREDICTIONS
    -----------------------------------------------------------
    -- Create your model.
    CREATE
    OR REPLACE SNOWFLAKE.ML.CLASSIFICATION my_model(
        INPUT_DATA => SYSTEM$REFERENCE('TABLE', 'TRANSACTION_GOLD'),
        TARGET_COLNAME => 'IS_FRAUD',
        CONFIG_OBJECT => { 'ON_ERROR': 'SKIP' }
    );
-- Inspect your logs to ensure training completed successfully.
    CALL my_model ! SHOW_TRAINING_LOGS();
-- Generate predictions as new columns in to your prediction table.
    CREATE TABLE My_classification_2025_11_26 AS
SELECT
    *,
    my_model ! PREDICT(
        OBJECT_CONSTRUCT(*),
        -- This option alows the prediction process to complete even if individual rows must be skipped.
        { 'ON_ERROR': 'SKIP' }
    ) as predictions
from
    TRANSACTION_GOLD;
-- View your predictions.
SELECT
    *
FROM
    My_classification_2025_11_26;
-- Parse the prediction results into separate columns.
    -- Note: This is a just an example. Be sure to update this to reflect
    -- the classes in your dataset.
SELECT
    * EXCLUDE predictions,
    predictions:class AS class,
    round(predictions ['probability'] [class], 3) as probability
FROM
    My_classification_2025_11_26;
-----------------------------------------------------------
-- INSPECT RESULTS
-----------------------------------------------------------
  CALL my_model ! SHOW_EVALUATION_METRICS();
  CALL my_model ! SHOW_GLOBAL_EVALUATION_METRICS();
  CALL my_model ! SHOW_CONFUSION_MATRIX();
-- Inspect the relative importance of your features, including auto-generated features.
    CALL my_model ! SHOW_FEATURE_IMPORTANCE();
