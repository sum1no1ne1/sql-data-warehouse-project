/*
========================================================================
STORED PROCEDURE: Load Bronze Layer (Source -> Bronze)
========================================================================
Script Purpose:
			This stored procedure loads data  into the 'bronze' schema 
			from external csv files.
			It per forms the followinng actions:
			-Truncates the bronze tables.
			-Loads the data from csv files into the tables using 
			 'BULK INSERT' command.
            
Parameters: None
			this stored procedure takes no input or output parameters.

Usage Example: 
            EXEC  Bronze.load_data;
========================================================================
*/

USE DataWareHouse;
GO

CREATE OR ALTER PROCEDURE Bronze.load_data AS
BEGIN
   DECLARE @start_time DATETIME ,@end_time DATETIME ,@batch_start_time DATETIME ,@batch_end_time DATETIME;
   BEGIN TRY
	SET @batch_start_time= GETDATE();
	   PRINT '=================================================================================';
	   PRINT 'Loading Bronze Layer';
	   PRINT '=================================================================================';
	   PRINT '--------------------------------------------------------------------------------- ';
	   PRINT 'Loading CRM Table';
	   PRINT '---------------------------------------------------------------------------------';
	   SET @start_time=GETDATE();
	   PRINT'Truncating Table:Bronze.crum_cust_info';
		TRUNCATE TABLE Bronze.crum_cust_info;
		PRINT'Inserting Data into :Bronze.crum_cust_info';
		BULK INSERT Bronze.crum_cust_info
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\cust_info.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		)
	     SET @end_time=GETDATE();
		 PRINT'>> Data Load Time:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		 PRINT '---------------------------------------------------------------------------------';

	    
		SET @start_time=GETDATE();
		PRINT'Truncating Table:Bronze.crum_prd_info';
		TRUNCATE TABLE Bronze.crum_prd_info;
		PRINT'Inserting Data into :Bronze.crum_prd_info';
		BULK INSERT Bronze.crum_prd_info
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\prd_info.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		);
		 SET @end_time=GETDATE();
		 PRINT'>> Data Load Time:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		 PRINT '---------------------------------------------------------------------------------';
	    
		PRINT'Truncating Table: Bronze.crum_sales_details';
		TRUNCATE TABLE Bronze.crum_sales_details;
		PRINT'Inserting Data into :Bronze.crum_sales_details';
		BULK INSERT Bronze.crum_sales_details
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_crm\sales_details.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		)
	   PRINT '--------------------------------------------------------------------------------- ';
	   PRINT 'Loading ERP Table';
	   PRINT '---------------------------------------------------------------------------------';
	    SET @start_time=GETDATE();
		 PRINT'Truncating Table:Bronze.erp_CUST_AZ12';
		TRUNCATE TABLE Bronze.erp_CUST_AZ12;
		PRINT'Inserting Data into : Bronze.erp_CUST_AZ12';
		BULK INSERT Bronze.erp_CUST_AZ12
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\CUST_AZ12.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		);
		 SET @end_time=GETDATE();
		 PRINT'>> Data Load Time:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		   PRINT '---------------------------------------------------------------------------------';
	    SET @start_time=GETDATE();
		PRINT'Truncating Table: Bronze.erp_LOC_A101';
		TRUNCATE TABLE Bronze.erp_LOC_A101
		PRINT'Inserting Data into :Bronze.erp_LOC_A101 ';
		BULK INSERT Bronze.erp_LOC_A101
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\LOC_A101.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		);
	     SET @end_time=GETDATE();
		 PRINT'>> Data Load Time:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		 PRINT '---------------------------------------------------------------------------------';
         SET @start_time=GETDATE();
		PRINT'Truncating Table: Bronze.erp_PX_CAT_G1V2';
		TRUNCATE TABLE Bronze.erp_PX_CAT_G1V2;
		PRINT'Inserting Data into :Bronze.erp_PX_CAT_G1V2 ';
		BULK INSERT Bronze.erp_PX_CAT_G1V2
		FROM 'C:\Users\Denver\Desktop\data with Bara\sql-data-warehouse-project\datasets\source_erp\PX_CAT_G1V2.csv'
		WITH(
		 FIRSTROW=2,
		 FIELDTERMINATOR=',',
		 TABLOCK
		);
	     PRINT'>> Data Load Time:'+ CAST(DATEDIFF(second,@start_time,@end_time)AS NVARCHAR) +'seconds';
		 SET @batch_end_time= GETDATE();
		 PRINT'>> Batch Data Load Time:'+ CAST(DATEDIFF(second,@batch_start_time,@batch_end_time)AS NVARCHAR) +'seconds';
		 PRINT '---------------------------------------------------------------------------------';
	END TRY
	BEGIN CATCH
	    PRINT '=================================================================================';
		PRINT 'Error Message: '+ ERROR_MESSAGE();
		PRINT'Error Message: ' + CAST(ERROR_NUMBER() AS NVARCHAR);
		PRINT'Error Message: ' + CAST(ERROR_STATE() AS NVARCHAR);
		PRINT '=================================================================================';

	END CATCH
END

EXEC  Bronze.load_data;

DROP PROCEDURE IF EXISTS Bronze.load_data;
GO
