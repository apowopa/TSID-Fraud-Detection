use role ACCOUNTADMIN;

CREATE DATABASE IF NOT EXISTS card_transaction;

use database card_transaction;

create schema if not exists bronze;

create schema if not exists silver;

create schema if not exists gold;