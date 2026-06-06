/*
========================================================================
DDL SCRIPT: Create Bromze Layer
========================================================================
Script Purpose:
			This script creates tables in the 'bronze' schema
			dropping table if it already exists.
			Run this script to redefine the DDL structure of the Bronze
			tables.
========================================================================
*/

USE DataWareHouse;
GO
IF OBJECT_ID('Bronze.crum_cust_info','U') IS NOT NULL
	DROP TABLE Bronze.crum_cust_info;
CREATE TABLE Bronze.crum_cust_info(
 cst_id INT,
 cst_key NVARCHAR(50),
 cst_firstname NVARCHAR(50),
 cst_lastname NVARCHAR(50),
 cst_material_status NVARCHAR(50),
 cst_gnder NVARCHAR(50),
 cst_date DATE 
);
GO


IF OBJECT_ID('Bronze.crum_prd_info','U') IS NOT NULL
	DROP TABLE Bronze.crum_prd_info;
CREATE TABLE Bronze.crum_prd_info(
prd_id INT,
prd_key NVARCHAR(50),
prd_nm NVARCHAR(50),
prd_line NVARCHAR(50),
prd_cost NVARCHAR(50),
prd_start_dt DATETIME,
prd_end_dt DATE
);
GO

IF OBJECT_ID('Bronze.crum_sales_details','U') IS NOT NULL
	DROP TABLE Bronze.crum_sales_details;
CREATE TABLE Bronze.crum_sales_details(
sls_ord_num NVARCHAR(50),
sls_prd_key NVARCHAR(50),
sls_cust_id INT,
sls_order_dt INT,
sls_ship_dt INT,
sls_due_dt INT,
sls_sales INT,
sls_quantity INT,
sls_price INT
);
GO

IF OBJECT_ID('Bronze.erp_CUST_AZ12','U') IS NOT NULL
	DROP TABLE Bronze.erp_CUST_AZ12;
CREATE TABLE Bronze.erp_CUST_AZ12(
CID NVARCHAR(50),
BDATE DATE,
GEN NVARCHAR(50)
);
GO

IF OBJECT_ID('Bronze.erp_LOC_A101','U') IS NOT NULL
	DROP TABLE Bronze.erp_LOC_A101;
CREATE TABLE Bronze.erp_LOC_A101(
CID NVARCHAR(50),
CNTRY NVARCHAR(50)
);
GO
IF OBJECT_ID('Bronze.erp_PX_CAT_G1V2','U') IS NOT NULL
	DROP TABLE Bronze.erp_PX_CAT_G1V2;
CREATE TABLE Bronze.erp_PX_CAT_G1V2(
ID NVARCHAR(50),
CAT NVARCHAR(50),
SUBCAT NVARCHAR(50),
MAINTENANCE NVARCHAR(50)
);

-- INSERT DATA
TRUNCATE TABLE Bronze.crum_cust_info;
BULK INSERT Bronze.crum_cust_info
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
)
GO

SELECT  count(*) FROM Bronze.crum_cust_info;
GO


TRUNCATE TABLE Bronze.crum_prd_info;
BULK INSERT Bronze.crum_prd_info
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
);
GO

TRUNCATE TABLE Bronze.crum_sales_details;
BULK INSERT Bronze.crum_sales_details
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
)
GO

TRUNCATE TABLE Bronze.erp_CUST_AZ12;
BULK INSERT Bronze.erp_CUST_AZ12
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
);
GO

TRUNCATE TABLE Bronze.erp_LOC_A101
BULK INSERT Bronze.erp_LOC_A101
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
);
GO

TRUNCATE TABLE Bronze.erp_PX_CAT_G1V2;
BULK INSERT Bronze.erp_PX_CAT_G1V2
FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
WITH(
 FIRSTROW=2,
 FIELDTERMINATOR=',',
 TABLOCK
);
GO

