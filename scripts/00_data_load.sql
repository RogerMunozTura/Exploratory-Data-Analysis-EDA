/*
=============================================================
Create Database and Schemas
=============================================================
Script Purpose:
    This script creates a new database named 'ExploratoryDataAnalysis' after checking if it already exists. 
    If the database exists, it is dropped and recreated. Additionally, this script creates a schema called gold
	
WARNING:
    Running this script will drop the entire 'ExploratoryDataAnalysis' database if it exists. 
    All data in the database will be permanently deleted. 

BEFORE RUNNING:
    Update the file paths in the BULK INSERT statements below (search for
    <YOUR-LOCAL-PATH>) to match where you cloned this repository on your machine.
*/

USE master;
GO

-- If it already exists, delte any active connections and delete it completely
IF EXISTS (SELECT 1 FROM sys.databases WHERE name = 'ExploratoryDataAnalysis')
BEGIN
    DROP DATABASE ExploratoryDataAnalysis;
END;
GO

-- Create the 'ExploratoryDataAnalysis' database
CREATE DATABASE ExploratoryDataAnalysis;
GO

USE ExploratoryDataAnalysis;
GO

-- Create the 'gold' schema that holds the clean, analysis-ready tables
CREATE SCHEMA gold;
GO

-- Customers table
CREATE TABLE gold.dim_customers(
	customer_key int,
	customer_id int,
	customer_number nvarchar(50),
	first_name nvarchar(50),
	last_name nvarchar(50),
	country nvarchar(50),
	marital_status nvarchar(50),
	gender nvarchar(50),
	birthdate date,
	create_date date
);
GO

-- Products table
CREATE TABLE gold.dim_products(
	product_key int ,
	product_id int ,
	product_number nvarchar(50) ,
	product_name nvarchar(50) ,
	category_id nvarchar(50) ,
	category nvarchar(50) ,
	subcategory nvarchar(50) ,
	maintenance nvarchar(50) ,
	cost int,
	product_line nvarchar(50),
	start_date date 
);
GO

-- Sales table
-- it links back to customers and products through their keys
CREATE TABLE gold.fact_sales(
	order_number nvarchar(50),
	product_key int,
	customer_key int,
	order_date date,
	shipping_date date,
	due_date date,
	sales_amount int,
	quantity tinyint,
	price int 
);
GO

-- Empty the customers table just in case, then load it from the CSV
-- FIRSTROW = 2 skips the header row, FIELDTERMINATOR = ',' means it's comma-separated
TRUNCATE TABLE gold.dim_customers;
GO

BULK INSERT gold.dim_customers
FROM '<YOUR-LOCAL-PATH>\datasets\csv-files\gold.dim_customers.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Same for products
TRUNCATE TABLE gold.dim_products;
GO

BULK INSERT gold.dim_products
FROM '<YOUR-LOCAL-PATH>\datasets\csv-files\gold.dim_products.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO

-- Same for sales
TRUNCATE TABLE gold.fact_sales;
GO

BULK INSERT gold.fact_sales
FROM '<YOUR-LOCAL-PATH>\datasets\csv-files\gold.fact_sales.csv'
WITH (
	FIRSTROW = 2,
	FIELDTERMINATOR = ',',
	TABLOCK
);
GO
