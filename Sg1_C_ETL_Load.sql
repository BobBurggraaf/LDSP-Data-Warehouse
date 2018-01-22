/******************************************************************************
   NAME: COPY TABLES TO PROD 
   PURPOSE: Create PROD tables for Business Objects
   PLATFORM: Sql Server Management Studio

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        11/30/2016      Fams           1. Development script that copies stage table to prod.
   1.1		  12/28/2016      Fams			 2. Added Hierarchy columns to _Drop_Include_Dim
   1.2		  1/4/2017		  Fams			 3. Added Cell_Phone and Current Employment fields to _Donor_Dim
   1.3		  2/21/2017		  Fams			 4. Added columns for the Weekly Appeals Report
   1.4		  2/23/2017		  Fams			 5. Added fact tables and dimension table for the Retention reports

   
   STAGE TO PROD SCRIPT CHANGES:

******************************************************************************/


USE OneAccord_Warehouse
GO


-- --------------------------
-- ALPHA_2
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Alpha_Table_3','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Alpha_Table_3;
GO


CREATE TABLE Alpha_Table_3 (
	Alpha_Key INT IDENTITY(1,1) PRIMARY KEY
	, Alpha_DateTime DATETIME
	, Alpha_Stage NVARCHAR(50)
	, Alpha_Step_Number NVARCHAR(10)
	, Alpha_Step_Name NVARCHAR(200)
	, Alpha_Begin_Time DATETIME
	, Alpha_End_Time DATETIME
	, Alpha_Duration_In_Seconds INT
	, Alpha_Count INT
	, Alpha_Query NVARCHAR(MAX)
	, Alpha_Result BIT DEFAULT 0
	, ErrorNumber INT
	, ErrorSeverity INT
	, ErrorState INT
	, ErrorProcedure NVARCHAR(500)
	, ErrorLine INT
	, ErrorMessage NVARCHAR(MAX)
)              
; 
GO


EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = 'Script Start', @Alpha_Step_Number = '0', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;

-- --------------------------------------------------------------------------------------

IF OBJECT_ID('OneAccord_Warehouse.dbo.Create_Trans_Load_Tables','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Create_Trans_Load_Tables;
GO

CREATE TABLE OneAccord_Warehouse.dbo.Create_Trans_Load_Tables
	(
	Fields_Key  INT IDENTITY(1,1) PRIMARY KEY
	, Dim_Object NVARCHAR(100)
	, Table_Name NVARCHAR(100)
	, Create_Fields NVARCHAR(MAX)
	, Insert_Fields NVARCHAR(MAX)
	, From_Statement NVARCHAR(MAX)
	, Where_Statement NVARCHAR(MAX)
	, Attribute_1 NVARCHAR(MAX)
	, Attribute_2 NVARCHAR(MAX)
	, Attribute_3 NVARCHAR(MAX)
	, Attribute_4 NVARCHAR(MAX)
	, Attribute_5 NVARCHAR(MAX)
	, Attribute_6 NVARCHAR(MAX)
	, Attribute_7 NVARCHAR(MAX)
	, Attribute_8 NVARCHAR(MAX)
	, Attribute_9 NVARCHAR(MAX)
	, Attribute_10 NVARCHAR(MAX)
	, Attribute_11 NVARCHAR(MAX)
	, Attribute_12 NVARCHAR(MAX)
	, Attribute_13 NVARCHAR(MAX)
	, Attribute_14 NVARCHAR(MAX)
	, Attribute_15 NVARCHAR(MAX)
	, Attribute_16 NVARCHAR(MAX)
	, Attribute_17 NVARCHAR(MAX)
	, Attribute_18 NVARCHAR(MAX)
	, Attribute_19 NVARCHAR(MAX)
	, Attribute_20 NVARCHAR(MAX)
	, Active BIT
	, Insert_Date DATETIME
	, Update_Date DATETIME
	);
              
INSERT INTO OneAccord_Warehouse.dbo.Create_Trans_Load_Tables
	(
	Dim_Object
	, Table_Name
	, Create_Fields
	, Insert_Fields
	, From_Statement
	, Where_Statement
	, Attribute_1
	, Attribute_2
	, Attribute_3
	, Attribute_4
	, Attribute_5
	, Attribute_6
	, Attribute_7
	, Attribute_8
	, Attribute_9
	, Attribute_10
	, Attribute_11
	, Attribute_12
	, Attribute_13
	, Attribute_14
	, Attribute_15
	, Attribute_16
	, Attribute_17
	, Attribute_18
	, Attribute_19
	, Attribute_20
	, Active
	, Insert_Date
	, Update_Date
	)
	VALUES
-- --------------------------
-- _Affiliated_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Affiliated_Dim' -- Table_Name
		, 'ContactId  NVARCHAR(100) 
			, Affiliated_Key  INT  PRIMARY KEY
			, Byu_Affiliated_Date DATE
			, Byu_Donor_Affiliated_Date DATE
			, Byu_Education_Affiliated_Date DATE
			, Byu_Interest_Affiliated_Date DATE
			, Byu_Employee_Affiliated_Date DATE
			, Byui_Affiliated_Date DATE
			, Byui_Donor_Affiliated_Date DATE
			, Byui_Education_Affiliated_Date DATE
			, Byui_Interest_Affiliated_Date DATE
			, Byui_Employee_Affiliated_Date DATE
			, Byuh_Affiliated_Date DATE
			, Byuh_Donor_Affiliated_Date DATE
			, Byuh_Education_Affiliated_Date DATE
			, Byuh_Interest_Affiliated_Date DATE
			, Byuh_Employee_Affiliated_Date DATE
			, Ldsbc_Affiliated_Date DATE
			, Ldsbc_Donor_Affiliated_Date DATE
			, Ldsbc_Education_Affiliated_Date DATE
			, Ldsbc_Interest_Affiliated_Date DATE
			, Ldsbc_Employee_Affiliated_Date DATE
			' -- Create_Table
		, 'ContactId 
			, Affiliated_Key
			, Byu_Affiliated_Date
			, Byu_Donor_Affiliated_Date
			, Byu_Education_Affiliated_Date
			, Byu_Interest_Affiliated_Date
			, Byu_Employee_Affiliated_Date
			, Byui_Affiliated_Date
			, Byui_Donor_Affiliated_Date
			, Byui_Education_Affiliated_Date
			, Byui_Interest_Affiliated_Date
			, Byui_Employee_Affiliated_Date
			, Byuh_Affiliated_Date
			, Byuh_Donor_Affiliated_Date
			, Byuh_Education_Affiliated_Date
			, Byuh_Interest_Affiliated_Date
			, Byuh_Employee_Affiliated_Date
			, Ldsbc_Affiliated_Date
			, Ldsbc_Donor_Affiliated_Date
			, Ldsbc_Education_Affiliated_Date
			, Ldsbc_Interest_Affiliated_Date
			, Ldsbc_Employee_Affiliated_Date
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Affiliated_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''1D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Affiliated_Key INT PRIMARY KEY, Affiliated_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''1D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''1D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Affiliated_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Affiliated_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Affiliated_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Affiliated_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Wealth_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Wealth_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Wealth_Key INT   PRIMARY KEY
			, Plus_Institution NVARCHAR(100)
			, Plus_RecencyScore NVARCHAR(20)
			, Plus_FrequencyScore NVARCHAR(20)
			, Plus_ConsecutiveScore NVARCHAR(20)
			, Plus_MonetaryScore NVARCHAR(20)
			, Plus_UpgradeScore NVARCHAR(20)
			, Plus_GiftType NVARCHAR(400)
			, ModifiedOn DATE
			, StatusCode NVARCHAR(400)
			, Plus_GiftCapacityEn NVARCHAR(400)
			, Plus_PlannedGiftTier NVARCHAR(400)
			' -- Create_Table
		, 'ContactId 
			, Wealth_Key
			, Plus_Institution 
			, Plus_RecencyScore
			, Plus_FrequencyScore
			, Plus_ConsecutiveScore
			, Plus_MonetaryScore
			, Plus_UpgradeScore
			, Plus_GiftType
			, ModifiedOn
			, StatusCode
			, Plus_GiftCapacityEn
			, Plus_PlannedGiftTier
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Wealth_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''2D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Wealth_Key INT PRIMARY KEY, Wealth_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''2D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''2D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Wealth_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Wealth_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Wealth_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Wealth_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 0 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Award_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Award_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Award_Key INT  PRIMARY KEY
			, Award_Group_Key INT
			, Award_Type NVARCHAR(400)
			, Award_Affiliate_Type NVARCHAR(400)
			, Award_Start_Dt DATE
			, Award_End_Dt DATE
			, Award_Scholarship_Granting_Office NVARCHAR(25)
			, Award_Scholarship_Term NVARCHAR(15)
			, Award_Scholarship_Code NVARCHAR(100)
			, Award_Scholarship_Amount MONEY
			, Award_Scholarship_Dt DATE
			, Award_Name NVARCHAR(100)
			' -- Create_Table
		, 'ContactId
			, Award_Key
			, Award_Group_Key
			, Award_Type
			, Award_Affiliate_Type
			, Award_Start_Dt
			, Award_End_Dt
			, Award_Scholarship_Granting_Office
			, Award_Scholarship_Term
			, Award_Scholarship_Code
			, Award_Scholarship_Amount
			, Award_Scholarship_Dt
			, Award_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Award_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''3D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Award_Key INT PRIMARY KEY, Award_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''3D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''3D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Award_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Award_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Award_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Award_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Phone_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Phone_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Phone_Key INT  PRIMARY KEY
			, Phone_Group_Key INT
			, Phone_Number NVARCHAR(100)
			, Phone_Country_Code NVARCHAR(100)
			, Phone_Extension NVARCHAR(100)
			, Phone_Active_Yn NVARCHAR(1)
			, Phone_Confirmed_Yn NVARCHAR(1)
			, Phone_Primary_Yn NVARCHAR(1)
			, Phone_Recieve_Text_Yn NVARCHAR(1)
			, Phone_Confidential_Yn NVARCHAR(1)
			--, Phone_Confidential_Reason NVARCHAR(400)  /*Delete from source 5/15/17*/
			, Phone_Type NVARCHAR(400)
			, Phone_Line_Type NVARCHAR(400)
			, Phone_Preferred_Time NVARCHAR(400)
			, Phone_Type_Value INT
			, Phone_Line_Type_Value INT
			, Phone_Preferred_Time_Value INT
			' -- Create_Table
		, 'ContactId
			, Phone_Key
			, Phone_Group_Key
			, Phone_Number
			, Phone_Country_Code
			, Phone_Extension
			, Phone_Active_Yn
			, Phone_Confirmed_Yn
			, Phone_Primary_Yn
			, Phone_Recieve_Text_Yn
			, Phone_Confidential_Yn
			--, Phone_Confidential_Reason   /*Delete from source 5/15/17*/
			, Phone_Type
			, Phone_Line_Type
			, Phone_Preferred_Time
			, Phone_Type_Value
			, Phone_Line_Type_Value
			, Phone_Preferred_Time_Value
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Phone_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''4D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Phone_Key INT PRIMARY KEY, Phone_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''4D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''4D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Phone_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Phone_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Phone_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Phone_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,             
-- --------------------------
-- _Email_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Email_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100) 
			, Email_Key  INT  PRIMARY KEY
			, Email_Group_Key  INT 
			, Email_Address  NVARCHAR(150) 
			, Email_Primary_Yn  NVARCHAR(1) 
			, Email_Type  NVARCHAR(400) 
			, Email_Type_Value  INT 
			, Email_Active_Yn  NVARCHAR(1) 
			, Email_Confirmed_Yn  NVARCHAR(1)
			, Email_Confidential_Yn  NVARCHAR(1) 
			--, Email_Confidential_Reason  NVARCHAR(400)   /*Delete from source 5/15/17*/
			' -- Create_Table
		, 'ContactId  
			, Email_Key 
			, Email_Group_Key 
			, Email_Address
			, Email_Primary_Yn 
			, Email_Type
			, Email_Type_Value 
			, Email_Active_Yn
			, Email_Confirmed_Yn
			, Email_Confidential_Yn
			--, Email_Confidential_Reason   /*Delete from source 5/15/17*/
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Email_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''5D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Email_Key INT PRIMARY KEY, Email_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''5D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''5D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Email_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Email_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Email_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Email_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,             
-- --------------------------
-- _Activity_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Activity_Dim' -- Table_Name
		, 'Activity_Key INT PRIMARY KEY
			, Activity_Group_Key INT
			, Activity_Id NVARCHAR(100)
			, ContactId NVARCHAR(100)
			, ContactName NVARCHAR(4000)
			, Party_Object_Type NVARCHAR(100)
			, Participation_Type NVARCHAR(100)
			, Type NVARCHAR(100)
			, Subject NVARCHAR(200)
			, Regarding NVARCHAR(4000)
			, Face_To_Face NVARCHAR(1)
			, Scheduled_Start DATE
			, Scheduled_Start_Date_Key NUMERIC(10,0)
			, Scheduled_End DATE
			, Scheduled_End_Date_Key NUMERIC(10,0)
			, Completed DATE
			, Completed_Date_Key NUMERIC(10,0)
			, Description NVARCHAR(4000)
			, Attendees NVARCHAR(4000)
			, Owner NVARCHAR(200)
			, Owner_Id NVARCHAR(100)
			, Source NVARCHAR(100)
			, Plus_M11ActivityType NVARCHAR(400)
			, Plus_MllMessageType NVARCHAR(400)
			, StateCode NVARCHAR(400)
			, StatusCode NVARCHAR(400)
			, CreatedOn DATE
			, ModifiedOn DATE
			, DomainName NVARCHAR(1024)
			' -- Create_Table
		, 'Activity_Key
			, Activity_Group_Key
			, Activity_Id
			, ContactId
			, ContactName
			, Party_Object_Type
			, Participation_Type
			, Type
			, Subject
			, Regarding
			, Face_To_Face
			, Scheduled_Start
			, Scheduled_Start_Date_Key
			, Scheduled_End
			, Scheduled_End_Date_Key
			, Completed
			, Completed_Date_Key
			, Description
			, Attendees
			, Owner
			, Owner_Id
			, Source
			, Plus_M11ActivityType
			, Plus_MllMessageType
			, StateCode
			, StatusCode
			, CreatedOn
			, ModifiedOn
			, DomainName
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Activity_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''6D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Activity_Key INT PRIMARY KEY, Activity_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''6D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''6D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Activity_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Activity_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Activity_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Activity_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,             
-- --------------------------
-- _Drop_Include_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Drop_Include_Dim' -- Table_Name
		, 'Drop_Include_Key INT PRIMARY KEY
			, Drop_Include_Instit_Hierarchy  NVARCHAR(100)  
			, Drop_Include_Type  NVARCHAR(400) 
			, Drop_Include_Visit_Yn  NVARCHAR(1) 
			, Drop_Include_Web_Yn  NVARCHAR(1) 
			, Drop_Include_Phone_Yn  NVARCHAR(1) 
			--, Drop_Include_Listing_Yn  NVARCHAR(1) /*Delete from source 5/15/17*/
			, Drop_Include_Email_Yn  NVARCHAR(1) 
			, Drop_Include_Scope  NVARCHAR(400) 
			, Drop_Include_Comm_Type  NVARCHAR(400) 
			, Drop_Include_Type_Value  INT 
			, Drop_Include_Scope_Value  INT 
			, Drop_Include_Comm_Type_Value  INT 
			, Drop_Include_Reason_Value  INT 
			, Drop_Include_Group_Key  INT
			, Drop_Include_Mail_Yn NVARCHAR(1)
			, Drop_Include_Text_Yn NVARCHAR(1)
			, New_StartDate DATE
			, New_EndDate DATE
			, Association NVARCHAR(100)
			, Campaign NVARCHAR(128)
			, New_Inst NVARCHAR(100)
			, Hier_Name NVARCHAR(100)
			' -- Create_Table
		, 'Drop_Include_Key
			, Drop_Include_Instit_Hierarchy 
			, Drop_Include_Type 
			, Drop_Include_Visit_Yn
			, Drop_Include_Web_Yn 
			, Drop_Include_Phone_Yn 
			--, Drop_Include_Listing_Yn  /*Delete from source 5/15/17*/
			, Drop_Include_Email_Yn
			, Drop_Include_Scope 
			, Drop_Include_Comm_Type 
			, Drop_Include_Type_Value
			, Drop_Include_Scope_Value
			, Drop_Include_Comm_Type_Value 
			, Drop_Include_Reason_Value 
			, Drop_Include_Group_Key
			, Drop_Include_Mail_Yn
			, Drop_Include_Text_Yn
			, New_StartDate
			, New_EndDate
			, Association
			, Campaign
			, New_Inst
			, Hier_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Drop_Include_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''7D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Drop_Include_Key INT PRIMARY KEY, Drop_Include_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''7D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''7D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Drop_Include_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Drop_Include_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Drop_Include_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Drop_Include_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Language_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Language_Dim' -- Table_Name
		, 'ContactId  NVARCHAR(100) 
			, Language_Key  INT  PRIMARY KEY
			, Language_Group_Key  INT 
			, Language_Name  NVARCHAR(400) 
			, Language_Speech_Level  NVARCHAR(400) 
			, Language_Read_Level  NVARCHAR(400) 
			, Language_Write_Level  NVARCHAR(400) 
			, Language_Name_Value  INT 
			, Language_Speech_Level_Value  INT 
			, Language_Read_Level_Value  INT 
			, Language_Write_Level_Value  INT 
			, Language_Teacher_Yn  NVARCHAR(1) 
			, Language_Mission_Yn  NVARCHAR(1) 
			, Language_Business_Yn  NVARCHAR(1) 
			, Language_Translator_Yn  NVARCHAR(1)
			, Source NVARCHAR(100)
			' -- Create_Table
		, 'ContactId 
			, Language_Key 
			, Language_Group_Key 
			, Language_Name 
			, Language_Speech_Level 
			, Language_Read_Level 
			, Language_Write_Level 
			, Language_Name_Value 
			, Language_Speech_Level_Value 
			, Language_Read_Level_Value 
			, Language_Write_Level_Value 
			, Language_Teacher_Yn 
			, Language_Mission_Yn 
			, Language_Business_Yn 
			, Language_Translator_Yn
			, Source
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Language_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''8D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Language_Key INT PRIMARY KEY, Language_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''8D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''8D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Language_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Language_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Language_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Language_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Association_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Association_Dim' -- Table_Name
		, 'ContactId  NVARCHAR(100) 
			, Association_Key  INT  PRIMARY KEY
			, Association_Group_Key  INT 
			, Association_Name  NVARCHAR(100) 
			, Association_Acronym  NVARCHAR(100) 
			, Association_Region  NVARCHAR(100) 
			, Association_Chapter_Level  NVARCHAR(100) 
			, Association_Type  NVARCHAR(400) 
			, Association_Type_Value  INT 
			, Association_Sponsor  NVARCHAR(400) 
			, Association_Sponsor_Value  INT 
			, Association_Active_Yn  NVARCHAR(1)
			, New_StartDate DATE
			, New_EndDate DATE
			, StatusCode NVARCHAR(400)
			' -- Create_Table
		, 'ContactId 
			, Association_Key 
			, Association_Group_Key 
			, Association_Name 
			, Association_Acronym 
			, Association_Region
			, Association_Chapter_Level 
			, Association_Type
			, Association_Type_Value 
			, Association_Sponsor
			, Association_Sponsor_Value 
			, Association_Active_Yn
			, New_StartDate
			, New_EndDate
			, StatusCode
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Association_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''9D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Association_Key INT PRIMARY KEY, Association_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''9D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''9D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Association_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Association_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Association_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Association_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Alumni_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Alumni_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Alumni_Key INT  PRIMARY KEY
			, Alumni_Group_Key INT
			, New_StudentAttendanceId NVARCHAR(100)
			, New_Term NVARCHAR(100)
			, New_Year NVARCHAR(100)
			, New_HoursCompleted INT
			, New_ExpectedGraduationDate DATE
			, Plus_Year NVARCHAR(10)
			, Plus_AlumniId NVARCHAR(100)
			, Plus_Name NVARCHAR(100)
			, Plus_ActualGraduationDate DATE
			, Actual_Graduation_Date_Key NUMERIC(10,0)
			, Plus_AlumniStatus NVARCHAR(400)
			, Plus_DgId INT
			, Plus_HoursCredits DECIMAL(20,2)
			, Plus_PreferredGraduationDate DATE
			, Preferred_Graduation_Date_Key NUMERIC(10,0)
			, College_Name NVARCHAR(100)
			, New_CollegeCode NVARCHAR(10)
			, Department NVARCHAR(100)
			, New_Degree NVARCHAR(100)
			, New_DegreeCode NVARCHAR(100)
			, Plus_DegreeLevel NVARCHAR(400)
			, New_University NVARCHAR(100)
			, New_UniversityCode NVARCHAR(10)
			, Plus_UniversityAcronym NVARCHAR(100)
			, New_Major NVARCHAR(100)
			, New_MajorName NVARCHAR(100)
			, New_MajorCode NVARCHAR(10)
			, Program_Code NVARCHAR(10)
			, New_Source NVARCHAR(100)
			, New_LongDescription NVARCHAR(100)
			, Program NVARCHAR(100)
			, Emphasis NVARCHAR(100)
			' -- Create_Table 
		, 'ContactId
			, Alumni_Key
			, Alumni_Group_Key
			, New_StudentAttendanceId
			, New_Term
			, New_Year
			, New_HoursCompleted
			, New_ExpectedGraduationDate
			, Plus_Year
			, Plus_AlumniId
			, Plus_Name
			, Plus_ActualGraduationDate
			, Actual_Graduation_Date_Key
			, Plus_AlumniStatus
			, Plus_DgId
			, Plus_HoursCredits
			, Plus_PreferredGraduationDate
			, Preferred_Graduation_Date_Key
			, College_Name
			, New_CollegeCode
			, Department
			, New_Degree
			, New_DegreeCode
			, Plus_DegreeLevel
			, New_University
			, New_UniversityCode
			, Plus_UniversityAcronym
			, New_Major
			, New_MajorName
			, New_MajorCode
			, Program_Code
			, New_Source
			, New_LongDescription
			, Program
			, Emphasis
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Alumni_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''10D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Alumni_Key INT PRIMARY KEY, Alumni_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''10D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''10D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Alumni_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Alumni_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Alumni_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Alumni_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Employment_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Employment_Dim' -- Table_Name
		, 'ContactId  NVARCHAR(100) 
			, Employment_Key  INT  PRIMARY KEY
			, Employment_Group_Key  INT 
			, Employment_Donor_Yn  NVARCHAR(1) 
			, Employment_Active_Yn  NVARCHAR(1) 
			, Employment_Church_Affil_Dept  NVARCHAR(100)
			, Employer NVARCHAR(100)
			, Job_Title NVARCHAR(100)
			, Job_Code NVARCHAR(100)
			, Industry NVARCHAR(100)
			, Source NVARCHAR(100)
			, Church_Affiliated NVARCHAR(1)
			, Start_Date DATE
			, End_Date         DATE
			, Internship NVARCHAR(1)
			, Church_Employment_Status NVARCHAR(400)
			, Employment_Institutional_Hierarchy NVARCHAR(100)
			, New_InstitutionalHierarchyId NVARCHAR(100)
			, Employer_Ldsp_Id NVARCHAR(100)
			, StatusCode NVARCHAR(400)
			' -- Create_Table
		, 'ContactId 
			, Employment_Key 
			, Employment_Group_Key 
			, Employment_Donor_Yn 
			, Employment_Active_Yn 
			, Employment_Church_Affil_Dept
			, Employer
			, Job_Title
			, Job_Code
			, Industry
			, Source
			, Church_Affiliated
			, Start_Date
			, End_Date         
			, Internship
			, Church_Employment_Status 
			, Employment_Institutional_Hierarchy
			, New_InstitutionalHierarchyId
			, Employer_Ldsp_Id
			, StatusCode
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Employment_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''11D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Employment_Key INT PRIMARY KEY, Employment_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''11D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''11D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Employment_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Employment_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Employment_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Employment_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,             
-- --------------------------
-- _Psa_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Psa_Dim' -- Table_Name
		, 'ContactId  NVARCHAR(100) 
			, Psa_Key  INT  PRIMARY KEY
			, Psa_Group_Key  INT 
			, Psa_Code  NVARCHAR(50) 
			, Psa_Eff_From  DATE 
			, Psa_Eff_Thru  DATE 
			, Psa_Act_Src  NVARCHAR(100) 
			, Psa_Entered_Dt  DATE 
			, Psa_Change_Dt  DATE 
			, Psa_Type  VARCHAR(100) 
			, Psa_Text_Line  NVARCHAR(100)
			' -- Create_Table
		, 'ContactId 
			, Psa_Key 
			, Psa_Group_Key 
			, Psa_Code 
			, Psa_Eff_From 
			, Psa_Eff_Thru 
			, Psa_Act_Src 
			, Psa_Entered_Dt 
			, Psa_Change_Dt 
			, Psa_Type 
			, Psa_Text_Line
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Psa_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''12D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Psa_Key INT PRIMARY KEY, Psa_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''12D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''12D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Psa_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Psa_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Psa_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Psa_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
				-- Prod Index
				IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id(''dbo._Psa_Dim'') AND NAME =''IX_Psa_Code_Eff_From'') 
				DROP INDEX IX_Psa_Code_Eff_From ON dbo._Psa_Dim; 
				IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id(''dbo._Psa_Dim'') AND NAME =''IX_Psa_Code'') 
				DROP INDEX IX_Psa_Code ON dbo._Psa_Dim; 
				IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id(''dbo._Psa_Dim'') AND NAME =''IX_Psa_Eff_From'') 
				DROP INDEX IX_Psa_Eff_From ON dbo._Psa_Dim;
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
				-- Prod Index
				CREATE NONCLUSTERED INDEX IX_Psa_Code_Eff_From 
				ON _Psa_Dim(Psa_Code, Psa_Eff_From ASC)
					INCLUDE (
						ContactId 
						, Psa_Key 
						, Psa_Group_Key 
						, Psa_Eff_Thru 
						, Psa_Act_Src 
						, Psa_Entered_Dt 
						, Psa_Change_Dt 
						, Psa_Type 
						, Psa_Text_Line
					);
				CREATE NONCLUSTERED INDEX IX_Psa_Code
				ON _Psa_Dim(Psa_Code ASC)
					INCLUDE (
						ContactId 
						, Psa_Key 
						, Psa_Group_Key 
						, Psa_Eff_From
						, Psa_Eff_Thru 
						, Psa_Act_Src 
						, Psa_Entered_Dt 
						, Psa_Change_Dt 
						, Psa_Type 
						, Psa_Text_Line
					);
				CREATE NONCLUSTERED INDEX IX_Psa_Eff_From
				ON _Psa_Dim(Psa_Eff_From ASC)
					INCLUDE (
						ContactId 
						, Psa_Key 
						, Psa_Group_Key 
						, Psa_Code
						, Psa_Eff_Thru 
						, Psa_Act_Src 
						, Psa_Entered_Dt 
						, Psa_Change_Dt 
						, Psa_Type 
						, Psa_Text_Line
					);
				UPDATE STATISTICS dbo._Psa_Dim
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Address_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Address_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Address_Key INT  PRIMARY KEY
			, Address_Group_Key INT
			, Address_Primary_Yn NVARCHAR(1)
			, Address_Street_1 NVARCHAR(100)
			, Address_Street_2 NVARCHAR(100)
			, Address_Street_3 NVARCHAR(100)
			, Address_City NVARCHAR(100)
			, Address_County NVARCHAR(100)
			, Address_County_Code NVARCHAR(10)
			, Address_County_Id NVARCHAR(100)
			, Address_State_Province NVARCHAR(50)
			, Address_State_Code NVARCHAR(100)
			, Address_Country NVARCHAR(100)
			, Address_Post_Code_Full NVARCHAR(100)
			, Address_Post_Code_Last_4 NVARCHAR(15)
			, Address_Printing_Line_1 NVARCHAR(606)
			, Address_Printing_Line_2 NVARCHAR(406)
			, Address_Display NVARCHAR(300)
			, Address_Quality_Status NVARCHAR(400)
			, Address_Quality_Status_Value INT
			, Address_Longitude FLOAT
			, Address_Latitude FLOAT
			, Address_Active_Yn NVARCHAR(1)
			, Address_Confirmed_Yn NVARCHAR(1)
			--, Address_Undeliverable_Yn NVARCHAR(1)  /*Delete from source 5/15/17*/
			, Address_Confidential_Yn NVARCHAR(1)
			--, Address_Confidential_Reason NVARCHAR(400)  /*Delete from source 5/15/17*/
			, Address_Type NVARCHAR(400)
			, Address_Type_Value INT
			, Address_Printing_Line_3 NVARCHAR(100)
			, Address_Printing_Line_4 NVARCHAR(100)
			' -- Create_Table
		, 'ContactId
			, Address_Key
			, Address_Group_Key
			, Address_Primary_Yn
			, Address_Street_1
			, Address_Street_2
			, Address_Street_3
			, Address_City
			, Address_County
			, Address_County_Code
			, Address_County_Id
			, Address_State_Province
			, Address_State_Code
			, Address_Country
			, Address_Post_Code_Full
			, Address_Post_Code_Last_4
			, Address_Printing_Line_1
			, Address_Printing_Line_2
			, Address_Display
			, Address_Quality_Status
			, Address_Quality_Status_Value
			, Address_Longitude
			, Address_Latitude
			, Address_Active_Yn
			, Address_Confirmed_Yn
			--, Address_Undeliverable_Yn  /*Delete from source 5/15/17*/
			, Address_Confidential_Yn
			--, Address_Confidential_Reason  /*Delete from source 5/15/17*/
			, Address_Type
			, Address_Type_Value
			, Address_Printing_Line_3
			, Address_Printing_Line_4
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Address_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''13D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Address_Key INT PRIMARY KEY, Address_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''13D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''13D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Address_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Address_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Address_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Address_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Connection_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Connection_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Connection_Key INT PRIMARY KEY
			, Connection_Group_Key INT
			, Contact_Name NVARCHAR(160)
			, Relationship NVARCHAR(100)
			, Relationship_ContactId NVARCHAR(100)
			, Relationship_LdspId NVARCHAR(100)
			, Relationship_Name NVARCHAR(160)
			, Relationship_Phone_Number NVARCHAR(100)
			, Relationship_Email NVARCHAR(150) 
			, Relationship_First_Name NVARCHAR(50)
			, Relationship_Last_Name NVARCHAR(50)
			, Relationship_Birth_Date DATE
			, Relationship_Age INT
			' -- Create_Table 
		, 'ContactId
			, Connection_Key
			, Connection_Group_Key
			, Contact_Name
			, Relationship
			, Relationship_ContactId
			, Relationship_LdspId
			, Relationship_Name
			, Relationship_Phone_Number
			, Relationship_Email
			, Relationship_First_Name
			, Relationship_Last_Name
			, Relationship_Birth_Date
			, Relationship_Age
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Connection_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''14D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Connection_Key INT PRIMARY KEY, Connection_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''14D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''14D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Connection_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Connection_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Connection_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Connection_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Id_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Id_Dim' -- Table_Name
		, 'ContactId NVARCHAR(100)
			, Id_Key INT  PRIMARY KEY
			, Id_Group_Key INT
			, New_Type NVARCHAR(400)
			, Plus_Id NVARCHAR(100)
			, ConstituentId NVARCHAR(100)
			, AccountId NVARCHAR(100)
			, New_Id NVARCHAR(100)
			' -- Create_Table 
		, 'ContactId 
			, Id_Key 
			, Id_Group_Key 
			, New_Type
			, Plus_Id
			, ConstituentId
			, AccountId
			, New_Id
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Id_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''15D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Id_Key INT PRIMARY KEY, Id_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''15D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''15D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Id_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Id_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Id_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Id_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,             
-- --------------------------
-- _Interest_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Interest_Dim' -- Table_Name
		, 'Interest_Key INT PRIMARY KEY
			, Interest_Group_Key INT
			, ContactId NVARCHAR(100)
			, Experience NVARCHAR(400)
			, Emeritus NVARCHAR(1)
			, Study_Abroad NVARCHAR(1)
			, Source  NVARCHAR(100)
			, New_StartDate DATE
			, New_EndDate DATE
			, Interest  NVARCHAR(100)
			, Lds_Position  NVARCHAR(400)
			, Institutional_Hierarchy  NVARCHAR(100)
			, Country  NVARCHAR(100)
			' -- Create_Table 
		, 'Interest_Key
			, Interest_Group_Key
			, ContactId
			, Experience
			, Emeritus
			, Study_Abroad
			, Source
			, New_StartDate
			, New_EndDate
			, Interest
			, Lds_Position
			, Institutional_Hierarchy
			, Country
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Interest_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''16D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Interest_Key INT PRIMARY KEY, Interest_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''16D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''16D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Interest_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Interest_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Interest_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Interest_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Student_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Student_Dim' -- Table_Name
		, 'Student_Key INT PRIMARY KEY
			, Student_Group_Key INT
			, ContactId NVARCHAR(100)
			, New_University NVARCHAR(100)
			, Plus_Year NVARCHAR(10)
			, New_Term NVARCHAR(100)
			, New_HoursCompleted INT
			, New_ExpectedGraduationDate DATE
			, New_Major NVARCHAR(100)
			, Plus_Emphasis NVARCHAR(100)
			, New_College NVARCHAR(100)
			, Plus_Department NVARCHAR(100)
			, Academic_Term_Date DATE
			, Academic_Year INT
			, Current_Academic_Year NVARCHAR(1)
			, Graduated_In_Current_Academic_Year NVARCHAR(1)
			, Current_Year_Plus_4_Student NVARCHAR(1)
			, Current_Year_Plus_4_Graduate NVARCHAR(1)
			' -- Create_Table 
		, 'Student_Key
			, Student_Group_Key
			, ContactId
			, New_University
			, Plus_Year
			, New_Term
			, New_HoursCompleted
			, New_ExpectedGraduationDate
			, New_Major
			, Plus_Emphasis
			, New_College
			, Plus_Department
			, Academic_Term_Date
			, Academic_Year
			, Current_Academic_Year
			, Graduated_In_Current_Academic_Year
			, Current_Year_Plus_4_Student
			, Current_Year_Plus_4_Graduate
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Student_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''17D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Student_Key INT PRIMARY KEY, Student_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''17D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''17D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Student_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Student_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Student_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Student_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Date_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Date_Dim' -- Table_Name
		, 'Date_Key NUMERIC(10,0) PRIMARY KEY
			, Time_Key NUMERIC(38,0)
			, Date_Type NVARCHAR(20)
			, Full_Date DATETIME2(7)
			, Week_Day_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Month_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Quarter_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Year_0_1_Flag NUMERIC(1,0)
			, Day_Nbr_Of_Month NUMERIC(2,0)
			, Month_Nbr_In_Year NUMERIC(2,0)
			, Month_Name NVARCHAR(27)
			, Month_Name_Abbrev NVARCHAR(3)
			, Quarter_Nbr NUMERIC(4,0)
			, Year_Nbr NUMERIC(4,0)
			, Day_Of_Week NVARCHAR(27)
			, Day_Nbr_Of_Week NUMERIC(1,0)
			, Day_Nbr_Of_Year NUMERIC(3,0)
			, Week_Nbr_In_Month NUMERIC(1,0)
			, Week_Nbr_In_Year NUMERIC(2,0)
			, Year_Sun_Sat_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Sun_Sat NUMERIC(2,0)
			, Year_Sat_Fri_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Sat_Fri NUMERIC(2,0)
			, Julian_Days NVARCHAR(384)
			, Full_Date_YYYYMMDD_Txt NVARCHAR(8)
			, Month_Name_Year NVARCHAR(20)
			, Month_Abbrev_Year NVARCHAR(20)
			, Quarter_Year_Txt NVARCHAR(20)
			, Year_Month_Name NVARCHAR(45)
			, Year_Month_Abbrev NVARCHAR(45)
			, Year_Quarter_Txt NVARCHAR(20)
			, Full_Date_MMSDDSYYYY_Txt NVARCHAR(10)
			, Full_Date_Month_Day_Year NVARCHAR(45)
			, Full_Date_Mon_Day_Year NVARCHAR(45)
			, Full_Date_DDPMMPYYYY_Txt NVARCHAR(10)
			, Full_Date_Day_Month_Year NVARCHAR(45)
			, Full_Date_Day_Mon_Year NVARCHAR(45)
			, Full_Date_YYYYPMMPDD_Txt NVARCHAR(10)
			, Full_Date_Year_Month_Day NVARCHAR(45)
			, Full_Date_Year_Mon_Day NVARCHAR(45)
			, Week_Nbr_Within_Month NUMERIC(1,0)
			, Days_In_Month NUMERIC(3,0)
			, Month_Start_Date DATETIME2(7)
			, Month_End_Date DATETIME2(7)
			, Pef_Month_Txt NVARCHAR(60)
			, Days_In_Quarter NUMERIC(3,0)
			, Quarter_Start_Date DATETIME2(7)
			, Quarter_End_Date DATETIME2(7)
			, Days_In_Year NUMERIC(3,0)
			, Leap_Year_0_1_Flag NUMERIC(1,0)
			, Year_Start_Date DATETIME2(7)
			, Year_End_Date DATETIME2(7)
			, Week_Sun_Sat_Start_Date DATETIME2(7)
			, Week_Sun_Sat_End_Date DATETIME2(7)
			, Week_Sat_Fri_Start_Date DATETIME2(7)
			, Week_Sat_Fri_End_Date DATETIME2(7)
			, Week_Nbr_Sat_Fri_Within_Month NUMERIC(1,0)
			, Week_Mon_Sun_Start_Date DATETIME2(7)
			, Week_Mon_Sun_End_Date DATETIME2(7)
			, Week_Nbr_Mon_Sun_Within_Month NUMERIC(1,0)
			, Year_Mon_Sun_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Mon_Sun NUMERIC(2,0)
			, Chq_Holiday_0_1_Flag NUMERIC(1,0)
			, Chq_Holiday_Name NVARCHAR(100)
			, Us_Fed_Holiday_0_1_Flag NUMERIC(1,0)
			, Us_Fed_Holiday_Name NVARCHAR(100)
			, Load_Date DATETIME2(7)
			, Chq_Business_Day_Flag NUMERIC(1,0)
			, Chq_Business_Day_Of_Month NUMERIC(2,0)
			, Chq_Business_Day_Of_Quarter NUMERIC(3,0)
			, Chq_Business_Day_Of_Week NUMERIC(1,0)
			, Chq_Business_Day_Of_Year NUMERIC(3,0)
			, Chq_Business_Days_From_Cur_Day NUMERIC(5,0)
			, Chq_Business_Days_In_Month NUMERIC(2,0)
			, Chq_Business_Days_In_Quarter NUMERIC(3,0)
			, Days_From_Current_Day NUMERIC(5,0)
			, Months_From_Current_Month NUMERIC(4,0)
			, Quarters_From_Current_Quarter NUMERIC(3,0)
			, Weeks_From_Current_Week NUMERIC(5,0)
			, Years_From_Current_Year NUMERIC(3,0)
			' -- Create_Table 
		, 'Date_Key
			, Time_Key
			, Date_Type
			, Full_Date
			, Week_Day_0_1_Flag
			, Last_Day_In_Month_0_1_Flag
			, Last_Day_In_Quarter_0_1_Flag
			, Last_Day_In_Year_0_1_Flag
			, Day_Nbr_Of_Month
			, Month_Nbr_In_Year
			, Month_Name
			, Month_Name_Abbrev
			, Quarter_Nbr
			, Year_Nbr
			, Day_Of_Week
			, Day_Nbr_Of_Week
			, Day_Nbr_Of_Year
			, Week_Nbr_In_Month
			, Week_Nbr_In_Year
			, Year_Sun_Sat_Nbr
			, Week_Nbr_In_Year_Sun_Sat
			, Year_Sat_Fri_Nbr
			, Week_Nbr_In_Year_Sat_Fri
			, Julian_Days
			, Full_Date_YYYYMMDD_Txt
			, Month_Name_Year
			, Month_Abbrev_Year
			, Quarter_Year_Txt
			, Year_Month_Name
			, Year_Month_Abbrev
			, Year_Quarter_Txt
			, Full_Date_MMSDDSYYYY_Txt
			, Full_Date_Month_Day_Year
			, Full_Date_Mon_Day_Year
			, Full_Date_DDPMMPYYYY_Txt
			, Full_Date_Day_Month_Year
			, Full_Date_Day_Mon_Year
			, Full_Date_YYYYPMMPDD_Txt
			, Full_Date_Year_Month_Day
			, Full_Date_Year_Mon_Day
			, Week_Nbr_Within_Month
			, Days_In_Month
			, Month_Start_Date
			, Month_End_Date
			, Pef_Month_Txt
			, Days_In_Quarter
			, Quarter_Start_Date
			, Quarter_End_Date
			, Days_In_Year
			, Leap_Year_0_1_Flag
			, Year_Start_Date
			, Year_End_Date
			, Week_Sun_Sat_Start_Date
			, Week_Sun_Sat_End_Date
			, Week_Sat_Fri_Start_Date
			, Week_Sat_Fri_End_Date
			, Week_Nbr_Sat_Fri_Within_Month
			, Week_Mon_Sun_Start_Date
			, Week_Mon_Sun_End_Date
			, Week_Nbr_Mon_Sun_Within_Month
			, Year_Mon_Sun_Nbr
			, Week_Nbr_In_Year_Mon_Sun
			, Chq_Holiday_0_1_Flag
			, Chq_Holiday_Name
			, Us_Fed_Holiday_0_1_Flag
			, Us_Fed_Holiday_Name
			, Load_Date
			, Chq_Business_Day_Flag
			, Chq_Business_Day_Of_Month
			, Chq_Business_Day_Of_Quarter
			, Chq_Business_Day_Of_Week
			, Chq_Business_Day_Of_Year
			, Chq_Business_Days_From_Cur_Day
			, Chq_Business_Days_In_Month
			, Chq_Business_Days_In_Quarter
			, Days_From_Current_Day
			, Months_From_Current_Month
			, Quarters_From_Current_Quarter
			, Weeks_From_Current_Week
			, Years_From_Current_Year
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Date_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''18D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Date_Key INT PRIMARY KEY, Date_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''18D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''18D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Date_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Date_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Date_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Date_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Date_Dim2 Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Date_Dim2' -- Table_Name
		, 'Date_Key NUMERIC(10,0) PRIMARY KEY
			, Time_Key NUMERIC(38,0)
			, Date_Type NVARCHAR(20)
			, Full_Date DATETIME2(7)
			, Week_Day_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Month_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Quarter_0_1_Flag NUMERIC(1,0)
			, Last_Day_In_Year_0_1_Flag NUMERIC(1,0)
			, Day_Nbr_Of_Month NUMERIC(2,0)
			, Month_Nbr_In_Year NUMERIC(2,0)
			, Month_Name NVARCHAR(27)
			, Month_Name_Abbrev NVARCHAR(3)
			, Quarter_Nbr NUMERIC(4,0)
			, Year_Nbr NUMERIC(4,0)
			, Day_Of_Week NVARCHAR(27)
			, Day_Nbr_Of_Week NUMERIC(1,0)
			, Day_Nbr_Of_Year NUMERIC(3,0)
			, Week_Nbr_In_Month NUMERIC(1,0)
			, Week_Nbr_In_Year NUMERIC(2,0)
			, Year_Sun_Sat_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Sun_Sat NUMERIC(2,0)
			, Year_Sat_Fri_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Sat_Fri NUMERIC(2,0)
			, Julian_Days NVARCHAR(384)
			, Full_Date_YYYYMMDD_Txt NVARCHAR(8)
			, Month_Name_Year NVARCHAR(20)
			, Month_Abbrev_Year NVARCHAR(20)
			, Quarter_Year_Txt NVARCHAR(20)
			, Year_Month_Name NVARCHAR(45)
			, Year_Month_Abbrev NVARCHAR(45)
			, Year_Quarter_Txt NVARCHAR(20)
			, Full_Date_MMSDDSYYYY_Txt NVARCHAR(10)
			, Full_Date_Month_Day_Year NVARCHAR(45)
			, Full_Date_Mon_Day_Year NVARCHAR(45)
			, Full_Date_DDPMMPYYYY_Txt NVARCHAR(10)
			, Full_Date_Day_Month_Year NVARCHAR(45)
			, Full_Date_Day_Mon_Year NVARCHAR(45)
			, Full_Date_YYYYPMMPDD_Txt NVARCHAR(10)
			, Full_Date_Year_Month_Day NVARCHAR(45)
			, Full_Date_Year_Mon_Day NVARCHAR(45)
			, Week_Nbr_Within_Month NUMERIC(1,0)
			, Days_In_Month NUMERIC(3,0)
			, Month_Start_Date DATETIME2(7)
			, Month_End_Date DATETIME2(7)
			, Pef_Month_Txt NVARCHAR(60)
			, Days_In_Quarter NUMERIC(3,0)
			, Quarter_Start_Date DATETIME2(7)
			, Quarter_End_Date DATETIME2(7)
			, Days_In_Year NUMERIC(3,0)
			, Leap_Year_0_1_Flag NUMERIC(1,0)
			, Year_Start_Date DATETIME2(7)
			, Year_End_Date DATETIME2(7)
			, Week_Sun_Sat_Start_Date DATETIME2(7)
			, Week_Sun_Sat_End_Date DATETIME2(7)
			, Week_Sat_Fri_Start_Date DATETIME2(7)
			, Week_Sat_Fri_End_Date DATETIME2(7)
			, Week_Nbr_Sat_Fri_Within_Month NUMERIC(1,0)
			, Week_Mon_Sun_Start_Date DATETIME2(7)
			, Week_Mon_Sun_End_Date DATETIME2(7)
			, Week_Nbr_Mon_Sun_Within_Month NUMERIC(1,0)
			, Year_Mon_Sun_Nbr NUMERIC(4,0)
			, Week_Nbr_In_Year_Mon_Sun NUMERIC(2,0)
			, Chq_Holiday_0_1_Flag NUMERIC(1,0)
			, Chq_Holiday_Name NVARCHAR(100)
			, Us_Fed_Holiday_0_1_Flag NUMERIC(1,0)
			, Us_Fed_Holiday_Name NVARCHAR(100)
			, Load_Date DATETIME2(7)
			, Chq_Business_Day_Flag NUMERIC(1,0)
			, Chq_Business_Day_Of_Month NUMERIC(2,0)
			, Chq_Business_Day_Of_Quarter NUMERIC(3,0)
			, Chq_Business_Day_Of_Week NUMERIC(1,0)
			, Chq_Business_Day_Of_Year NUMERIC(3,0)
			, Chq_Business_Days_From_Cur_Day NUMERIC(5,0)
			, Chq_Business_Days_In_Month NUMERIC(2,0)
			, Chq_Business_Days_In_Quarter NUMERIC(3,0)
			, Days_From_Current_Day NUMERIC(5,0)
			, Months_From_Current_Month NUMERIC(4,0)
			, Quarters_From_Current_Quarter NUMERIC(3,0)
			, Weeks_From_Current_Week NUMERIC(5,0)
			, Years_From_Current_Year NUMERIC(3,0)
			' -- Create_Table 
		, 'Date_Key
			, Time_Key
			, Date_Type
			, Full_Date
			, Week_Day_0_1_Flag
			, Last_Day_In_Month_0_1_Flag
			, Last_Day_In_Quarter_0_1_Flag
			, Last_Day_In_Year_0_1_Flag
			, Day_Nbr_Of_Month
			, Month_Nbr_In_Year
			, Month_Name
			, Month_Name_Abbrev
			, Quarter_Nbr
			, Year_Nbr
			, Day_Of_Week
			, Day_Nbr_Of_Week
			, Day_Nbr_Of_Year
			, Week_Nbr_In_Month
			, Week_Nbr_In_Year
			, Year_Sun_Sat_Nbr
			, Week_Nbr_In_Year_Sun_Sat
			, Year_Sat_Fri_Nbr
			, Week_Nbr_In_Year_Sat_Fri
			, Julian_Days
			, Full_Date_YYYYMMDD_Txt
			, Month_Name_Year
			, Month_Abbrev_Year
			, Quarter_Year_Txt
			, Year_Month_Name
			, Year_Month_Abbrev
			, Year_Quarter_Txt
			, Full_Date_MMSDDSYYYY_Txt
			, Full_Date_Month_Day_Year
			, Full_Date_Mon_Day_Year
			, Full_Date_DDPMMPYYYY_Txt
			, Full_Date_Day_Month_Year
			, Full_Date_Day_Mon_Year
			, Full_Date_YYYYPMMPDD_Txt
			, Full_Date_Year_Month_Day
			, Full_Date_Year_Mon_Day
			, Week_Nbr_Within_Month
			, Days_In_Month
			, Month_Start_Date
			, Month_End_Date
			, Pef_Month_Txt
			, Days_In_Quarter
			, Quarter_Start_Date
			, Quarter_End_Date
			, Days_In_Year
			, Leap_Year_0_1_Flag
			, Year_Start_Date
			, Year_End_Date
			, Week_Sun_Sat_Start_Date
			, Week_Sun_Sat_End_Date
			, Week_Sat_Fri_Start_Date
			, Week_Sat_Fri_End_Date
			, Week_Nbr_Sat_Fri_Within_Month
			, Week_Mon_Sun_Start_Date
			, Week_Mon_Sun_End_Date
			, Week_Nbr_Mon_Sun_Within_Month
			, Year_Mon_Sun_Nbr
			, Week_Nbr_In_Year_Mon_Sun
			, Chq_Holiday_0_1_Flag
			, Chq_Holiday_Name
			, Us_Fed_Holiday_0_1_Flag
			, Us_Fed_Holiday_Name
			, Load_Date
			, Chq_Business_Day_Flag
			, Chq_Business_Day_Of_Month
			, Chq_Business_Day_Of_Quarter
			, Chq_Business_Day_Of_Week
			, Chq_Business_Day_Of_Year
			, Chq_Business_Days_From_Cur_Day
			, Chq_Business_Days_In_Month
			, Chq_Business_Days_In_Quarter
			, Days_From_Current_Day
			, Months_From_Current_Month
			, Quarters_From_Current_Quarter
			, Weeks_From_Current_Week
			, Years_From_Current_Year
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Date2_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''19D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Date_Key INT PRIMARY KEY, Date_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''19D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''19D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Date_Dim2'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Date2_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Date_Dim2)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Date2_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,


-- --------------------------
-- DONOR DIM (_Donor_Dim)
-- --------------------------
	('Dim'
		, '_Donor_Dim'
		, 'Donor_Key  NVARCHAR(100)  PRIMARY KEY
			, Activity_Group_Key  INT 
			, Address_Group_Key  INT 
			, Alumni_Group_Key  INT 
			, Association_Group_Key  INT 
			, Award_Group_Key  INT 
			, Drop_Include_Group_Key  INT 
			, Email_Group_Key  INT 
			, Employment_Group_Key  INT 
			, Language_Group_Key  INT 
			, Phone_Group_Key  INT 
			, Psa_Group_Key  INT 
			, Connection_Group_Key INT
			, Id_Group_Key INT
			, Interest_Group_Key INT
			, Affiliated_Key INT
			--, Wealth_Key INT
			, Student_Group_Key INT
			, Donor_Ldsp_Id  NVARCHAR(100) 
			, Donor_Contact_Type  NVARCHAR(100) 
			, Donor_Organization_Id  NVARCHAR(100) 
			, Donor_Name  NVARCHAR(160) 
			, Donor_First_Name  NVARCHAR(50) 
			, Donor_Middle_Name  NVARCHAR(50) 
			, Donor_Last_Name  NVARCHAR(50) 
			, Donor_Nick_Name  NVARCHAR(50) 
			, Donor_Middle_Name2  NVARCHAR(100) 
			, Donor_Last_Name2  NVARCHAR(100) 
			, Donor_Preferred_Name  NVARCHAR(100) 
			, Donor_Display_Name  NVARCHAR(100) 
			, Donor_Maiden_Name  NVARCHAR(100) 
			, Donor_Title  NVARCHAR(100) 
			, Donor_Professional_Suffix  NVARCHAR(100) 
			, Donor_Personal_Suffix  NVARCHAR(400) 
			, Donor_Marriage_Status  NVARCHAR(400) 
			, Donor_Spouses_Name  NVARCHAR(100) 
			, Donor_Gender  NVARCHAR(400) 
			--, Donor_Ethnicity  NVARCHAR(400)  /*Delete from source 5/15/17*/
			, Donor_Lds_Member  NVARCHAR(400) 
			, Donor_Current_Student_Yn  VARCHAR(1) 
			, Donor_Birth_Dt  DATE 
			, Donor_Birth_Dt_Day  NVARCHAR(100) 
			, Donor_Birth_Dt_Month  NVARCHAR(100) 
			, Donor_Birth_Dt_Year  NVARCHAR(100) 
			, Donor_Deceased_Dt  DATE 
			, Donor_Deceased_Dt_Day  NVARCHAR(100) 
			, Donor_Deceased_Dt_Month  NVARCHAR(100) 
			, Donor_Deceased_Dt_Year  NVARCHAR(100)  
			, Donor_Wealth_Dt  DATE 
			, Donor_Major_Gift_Propen  NVARCHAR(400) 
			, Donor_Annual_Gift  NVARCHAR(400) 
			, Donor_Planned_Gift  NVARCHAR(400) 
			, Donor_Gift_Capacity_Enp  NVARCHAR(400) 
			, Donor_Gift_Capacity_En  NVARCHAR(400) 
			, Donor_Philan_Cap_Rating  NVARCHAR(400) 
			, Donor_Est_Household_Income  NVARCHAR(400) 
			, Donor_Est_Home_Market_Val  NVARCHAR(400) 
			, Donor_Block_Clusters  NVARCHAR(400) 
			, Donor_Individual_Infor_Envel  NVARCHAR(300) 
			, Donor_Couple_Infor_Envel  NVARCHAR(300) 
			, Donor_Individual_Form_Envel  NVARCHAR(300) 
			, Donor_Couple_Form_Envel  NVARCHAR(300) 
			, Donor_Country  NVARCHAR(100) 
			, Donor_Org_Matches_Gifts_Yn  NVARCHAR(1)
			--, Donor_Org_Graduate_Prof_Yn  NVARCHAR(1)  /*Delete from source 5/15/17*/
			--, Donor_Org_Alumni_Assoc_Yn  NVARCHAR(1)  /*Delete from source 5/15/17*/
			--, Donor_Org_Athletics_Yn  NVARCHAR(1)  /*Delete from source 5/15/17*/ 
			--, Donor_Org_Four_Year_Yn  NVARCHAR(1)  /*Delete from source 5/15/17*/ 
			, Donor_Deceased_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Mail_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Bulk_Mail_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Email_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Bulk_Email_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Phone_Yn  NVARCHAR(1) 
			, Donor_Org_Allow_Fax_Yn  NVARCHAR(1) 
			, Donor_Org_Class_Code  NVARCHAR(400) 
			, Donor_Org_Retiree_Ratio  NVARCHAR(400) 
			, Donor_Org_Split_Ratio  NVARCHAR(400) 
			, Donor_Org_Matching_Ratio  NVARCHAR(400) 
			, Donor_Org_Pref_Cont_Meth  NVARCHAR(400) 
			, Donor_Org_Description  NVARCHAR(4000) 
			, Donor_Marriage_Status_Value  INT 
			--, Donor_Ethnicity_Value  INT  /*Delete from source 5/15/17*/
			, Donor_Lds_Member_Value  INT 
			, Donor_Personal_Suffix_Value  INT 
			, Donor_Major_Gift_Propen_Value  INT 
			, Donor_Annual_Gift_Value  INT 
			, Donor_Planned_Gift_Value  INT 
			, Donor_Gift_Capacity_Enp_Value  INT 
			, Donor_Gift_Capacity_En_Value  INT 
			, Donor_Philan_Cap_Rating_Value  INT 
			, Donor_Est_Household_Income_Value  INT 
			, Donor_Est_Home_Market_Val_Value  INT 
			, Donor_Block_Clusters_Value  INT 
			, Donor_Org_Class_Code_Value  INT 
			, Donor_Org_Retiree_Ratio_Value  INT 
			, Donor_Org_Split_Ratio_Value  INT 
			, Donor_Org_Matching_Ratio_Value  INT 
			, Donor_Org_Pref_Cont_Meth_Val  INT
			, All_Personal_Connections NVARCHAR(4000)
			, Byu_Student_Id NVARCHAR(100)
			, ByuI_Student_Id NVARCHAR(100)
			, ByuH_Student_Id NVARCHAR(100)
			, Ldsbc_Student_Id NVARCHAR(100)
			, Byu_Employee_Id NVARCHAR(100)
			, ByuI_Employee_Id NVARCHAR(100)
			, ByuH_Employee_Id NVARCHAR(100)
			, Ldsbc_Employee_Id NVARCHAR(100)
			, Spouse_Name NVARCHAR(100)
			, Spouse_LdspId INT
			, Ces_Id NVARCHAR(100)
			, Church_Payroll_Id NVARCHAR(100)
			, Donor_Total_Name  NVARCHAR(200)
			, Donor_Total_Donation NVARCHAR(50)
			, Plus_PreferredFirstName NVARCHAR(100)
			, Plus_PreferredMiddleName NVARCHAR(100)
			, Plus_PreferredLastName NVARCHAR(100)
			, Plus_PreferredFullName NVARCHAR(100)
			, Plus_SpousePreferredFirstName NVARCHAR(100)
			, Plus_SpousePreferredMiddleName NVARCHAR(100)
			, Plus_SpousePreferredLastName NVARCHAR(100)
			, Plus_SpousePreferredFullName NVARCHAR(100)
			, Plus_CoordinatingLiaison NVARCHAR(200)
			, Plus_ConnectedLiaison NVARCHAR(200)
			, Plus_PendingLiaison NVARCHAR(200)
			, Byu_Degrees NVARCHAR(4000)
			, ByuI_Degrees NVARCHAR(4000)
			, ByuH_Degrees NVARCHAR(4000)
			, Ldsbc_Degrees NVARCHAR(4000)
			, Donor_Age INT
			, General_Authority NVARCHAR(1)
			, Emeritus_General_Authority NVARCHAR(1)
			, Mission_President NVARCHAR(1)
			, Temple_President NVARCHAR(1)
			, All_Employment NVARCHAR(4000) 
			, Current_Employment NVARCHAR(4000)
			, Former_Employment NVARCHAR(4000)
			, Spouse_Phone_Number NVARCHAR(100)
			, Spouse_Email NVARCHAR(100) 
			, Spouse_First_Name NVARCHAR(100)
			, Spouse_Last_Name NVARCHAR(100)
			, Spouse_Birth_Date NVARCHAR(100)
			, Spouse_Age INT
			, Byu_Donor NVARCHAR(1)
			, ByuI_Donor NVARCHAR(1)
			, ByuH_Donor NVARCHAR(1)
			, Ldsbc_Donor NVARCHAR(1)
			, Cell_Phone NVARCHAR(100)
			, Current_Employer_Name NVARCHAR(160)
			, Current_Job_Title NVARCHAR(100)
			, Current_Job_Code NVARCHAR(100)
			, Current_Job_Date_Started DATE
			, Current_Job_Work_Phone NVARCHAR(100)
			, Current_Job_Work_Address NVARCHAR(300)
			, Donor_Total_Giving_Current_Year MONEY
			, Donor_Total_Giving_Current_Year_Minus_1 MONEY
			, Donor_Total_Giving_Current_Year_Minus_2 MONEY
			, Donor_Total_Giving_Current_Year_Minus_3 MONEY
			, Donor_Any_School_Current_Student NVARCHAR(1)
			, Donor_BYU_Current_Student NVARCHAR(1)
			, Donor_BYUI_Current_Student NVARCHAR(1)
			, Donor_BYUH_Current_Student NVARCHAR(1)
			, Donor_LDSBC_Current_Student NVARCHAR(1)
			, Donor_Given_This_Year_To_Byu NVARCHAR(1)
			, Donor_Given_This_Year_To_ByuI NVARCHAR(1)
			, Donor_Given_This_Year_To_ByuH NVARCHAR(1)
			, Donor_Given_This_Year_To_LDSBC NVARCHAR(1)
			, Donor_Byu_Plc NVARCHAR(1)
			, Donor_Byuh_Plc NVARCHAR(1)
			, Donor_Nac NVARCHAR(1)
			, Donor_Byu_Law_Grads NVARCHAR(1)
			, Donor_Byu_Msm_Grads NVARCHAR(1)
			, Donor_Open_Byu_Telefund_Pledge NVARCHAR(1)
			, Donor_Open_Byui_Telefund_Pledge NVARCHAR(1)
			, Donor_Open_Byuh_Telefund_Pledge NVARCHAR(1)
			, Donor_Open_Ldsbc_Telefund_Pledge NVARCHAR(1)
			, Donor_Byu_Recurring_Donor NVARCHAR(1)
			, Donor_Byui_Recurring_Donor NVARCHAR(1)
			, Donor_Byuh_Recurring_Donor NVARCHAR(1)
			, Donor_Ldsbc_Recurring_Donor NVARCHAR(1)
			, Donor_Ldsp_Text_Lines NVARCHAR(4000)
			, Donor_Largest_Gift_Amt_Byu MONEY
			, Donor_Largest_Gift_Amt_Byui MONEY
			, Donor_Largest_Gift_Amt_Byuh MONEY
			, Donor_Largest_Gift_Amt_Ldsbc MONEY
			, Donor_Retention_Type_Code_Byu NVARCHAR(2)
			, Donor_Retention_Type_Code_Byui NVARCHAR(2)
			, Donor_Retention_Type_Code_Byuh NVARCHAR(2)
			, Donor_Retention_Type_Code_Ldsbc NVARCHAR(2)
			, Donor_Total_Giving_To_Byu_Current_Year_Amt MONEY
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_1_Amt  MONEY
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_2_Amt  MONEY
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_3_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_1_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_2_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_3_Amt  MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Amt  MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_1_Amt MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_2_Amt MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_3_Amt  MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Amt  MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_1_Amt  MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_2_Amt  MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_3_Amt  MONEY
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_4_Amt  MONEY
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_5_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_4_Amt  MONEY
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_5_Amt  MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_4_Amt MONEY
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_5_Amt MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_4_Amt  MONEY
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_5_Amt  MONEY
			, Donor_Total_Giving_Current_Year_Minus_4_Amt  MONEY
			, Donor_Total_Giving_Current_Year_Minus_5_Amt  MONEY
			, Donor_Total_Giving_Byu_High_Flag NVARCHAR(1)
			, Donor_Total_Giving_Byui_High_Flag NVARCHAR(1)
			, Donor_Total_Giving_Byuh_High_Flag NVARCHAR(1)
			, Donor_Total_Giving_Ldsbc_High_Flag NVARCHAR(1)
			, Current_Byu_Employment_Yn NVARCHAR(1)
			, Current_Byui_Employment_Yn NVARCHAR(1)
			, Current_Byuh_Employment_Yn NVARCHAR(1)
			, Current_Ldsbc_Employment_Yn NVARCHAR(1)
			, Informal_Mailing_Name NVARCHAR(300)
			, Informal_Salutation NVARCHAR(200)
			, Byu_Night_Society_Member NVARCHAR(1)
			, Byui_Legacy_Society_Member NVARCHAR(1)
			, Byuh_Cowley_Society_Member NVARCHAR(1)
			, Ldsbc_Fox_Society_Member NVARCHAR(1)
			, Donor_Spouse_Coordinating_Liaison NVARCHAR(400)
			, Donor_Previously_Contacted_Byu_Yn NVARCHAR(1)
			, Donor_Previously_Contacted_ByuI_Yn NVARCHAR(1)
			, Donor_Previously_Contacted_ByuH_Yn NVARCHAR(1)
			, Donor_Previously_Contacted_Ldsbc_Yn NVARCHAR(1)
			, Donor_Given_Last_3_Months_To_Byu NVARCHAR(1)
			, Donor_Given_Last_3_Months_To_Byui NVARCHAR(1)
			, Donor_Given_Last_3_Months_To_Byuh NVARCHAR(1)
			, Donor_Given_Last_3_Months_To_Ldsbc NVARCHAR(1)
			, Donor_Given_Last_3_Months_To_Church NVARCHAR(1)
			, Donor_Liaison_Connections NVARCHAR(4000)
			, Donor_Total_Lifetime_Giving MONEY
			, Donor_Total_Lifetime_Giving_Last_5_Years MONEY
			, Donor_Total_Lifetime_Giving_Byu MONEY
			, Donor_Total_Lifetime_Giving_Byui MONEY
			, Donor_Total_Lifetime_Giving_Byuh MONEY
			, Donor_Total_Lifetime_Giving_Ldsbc MONEY
			, Donor_Total_Lifetime_Giving_Church MONEY
			, Donor_Total_Lifetime_Giving_Pcc MONEY
			, Donor_Total_Lifetime_Giving_Ces MONEY
			, Donor_Most_Recent_Gift_Date_Ldsp DATE
			, Donor_Most_Recent_Gift_Date_Byu DATE
			, Donor_Most_Recent_Gift_Date_Byui DATE
			, Donor_Most_Recent_Gift_Date_Byuh DATE
			, Donor_Most_Recent_Gift_Date_Ldsbc DATE
			, Donor_Most_Recent_Gift_Date_Church DATE
			, Donor_Ldsp_Largest_Gift MONEY
			, Donor_First_Gift_Post_Date_Byu DATE
			, Donor_First_Gift_Post_Date_Byui DATE
			, Donor_First_Gift_Post_Date_Byuh DATE
			, Donor_First_Gift_Post_Date_Ldsbc DATE
			, Donor_Furthest_Initiative_Stage NVARCHAR(400)
			, Donor_Number_Of_Open_Initiatives INT
			, Donor_Total_Lifetime_Giving_To_Byu_Last_5_Years MONEY
			, Donor_Total_Lifetime_Giving_To_Byui_Last_5_Years MONEY
			, Donor_Total_Lifetime_Giving_To_Byuh_Last_5_Years MONEY
			, Donor_Total_Lifetime_Giving_To_Ldsbc_Last_5_Years MONEY
			, Donor_Total_Lifetime_Giving_To_Church_Last_5_Years MONEY
			, Donor_Most_Recent_Gift_To_Ldsp_Amt MONEY
			, Donor_Most_Recent_Gift_To_Byu_Amt MONEY
			, Donor_Most_Recent_Gift_To_Byui_Amt MONEY
			, Donor_Most_Recent_Gift_To_Byuh_Amt MONEY
			, Donor_Most_Recent_Gift_To_Ldsbc_Amt MONEY
			, Donor_Most_Recent_Gift_To_Church_Amt MONEY
			, Donor_Last_F2F_Visit_Date DATE
			, Donor_Type_Code_Ldsp NVARCHAR(2)
			, Donor_Largest_Gift_Amt_Church MONEY
			, Donor_Largest_Gift_Date_Ldsp DATE
			, Donor_Largest_Gift_Date_Byu DATE
			, Donor_Largest_Gift_Date_Byui DATE
			, Donor_Largest_Gift_Date_Byuh DATE
			, Donor_Largest_Gift_Date_Ldsbc DATE
			, Donor_Largest_Gift_Date_Church DATE
			, Donor_Institution_Giving_Areas NVARCHAR(1000)
			, Donor_Byu_Giving_Areas NVARCHAR(2000)
			, Donor_Church_Giving_Areas NVARCHAR(2000) 
			, Donor_Pledge_Reminder_Email_Content_Byu NVARCHAR(2000)
			, Donor_Pledge_Reminder_Email_Content_Byui NVARCHAR(2000)
			, Donor_Pledge_Reminder_Email_Content_Byuh NVARCHAR(2000)
			, Donor_Pledge_Reminder_Email_Content_Ldsbc NVARCHAR(2000)
			, Donor_Total_Name_Display NVARCHAR(200)
			, Plus_CoordinatingLiaison_DomainName NVARCHAR(1024)
			, Plus_PendingLiaison_DomainName NVARCHAR(1024)
			, Plus_ConnectedLiaison_DomainName NVARCHAR(1024)
			, Donor_Gift_Count_Previous_5_Years INT
			, Donor_Average_Single_Gift_Previous_5_Years MONEY
			, Donor_Is_Qualified NVARCHAR(1)
			, Donor_Qualified_On DATE 
			, Donor_Qualified_By NVARCHAR(200)
			' -- Create_Table 
		, 'Donor_Key      
			, Activity_Group_Key 
			, Address_Group_Key 
			, Alumni_Group_Key 
			, Association_Group_Key 
			, Award_Group_Key 
			, Drop_Include_Group_Key 
			, Email_Group_Key 
			, Employment_Group_Key 
			, Language_Group_Key 
			, Phone_Group_Key 
			, Psa_Group_Key 
			, Connection_Group_Key
			, Id_Group_Key
			, Interest_Group_Key
			, Affiliated_Key
			--, Wealth_Key
			, Student_Group_Key
			, Donor_Ldsp_Id 
			, Donor_Contact_Type 
			, Donor_Organization_Id 
			, Donor_Name 
			, Donor_First_Name
			, Donor_Middle_Name
			, Donor_Last_Name 
			, Donor_Nick_Name 
			, Donor_Middle_Name2 
			, Donor_Last_Name2
			, Donor_Preferred_Name
			, Donor_Display_Name
			, Donor_Maiden_Name
			, Donor_Title
			, Donor_Professional_Suffix 
			, Donor_Personal_Suffix 
			, Donor_Marriage_Status 
			, Donor_Spouses_Name 
			, Donor_Gender 
			--, Donor_Ethnicity  /*Delete from source 5/15/17*/
			, Donor_Lds_Member 
			, Donor_Current_Student_Yn 
			, Donor_Birth_Dt 
			, Donor_Birth_Dt_Day 
			, Donor_Birth_Dt_Month 
			, Donor_Birth_Dt_Year 
			, Donor_Deceased_Dt
			, Donor_Deceased_Dt_Day 
			, Donor_Deceased_Dt_Month
			, Donor_Deceased_Dt_Year 
			, Donor_Wealth_Dt
			, Donor_Major_Gift_Propen 
			, Donor_Annual_Gift 
			, Donor_Planned_Gift
			, Donor_Gift_Capacity_Enp 
			, Donor_Gift_Capacity_En 
			, Donor_Philan_Cap_Rating 
			, Donor_Est_Household_Income 
			, Donor_Est_Home_Market_Val 
			, Donor_Block_Clusters
			, Donor_Individual_Infor_Envel
			, Donor_Couple_Infor_Envel 
			, Donor_Individual_Form_Envel 
			, Donor_Couple_Form_Envel 
			, Donor_Country
			, Donor_Org_Matches_Gifts_Yn
			--, Donor_Org_Graduate_Prof_Yn  /*Delete from source 5/15/17*/
			--, Donor_Org_Alumni_Assoc_Yn  /*Delete from source 5/15/17*/
			--, Donor_Org_Athletics_Yn  /*Delete from source 5/15/17*/
			--, Donor_Org_Four_Year_Yn  /*Delete from source 5/15/17*/
			, Donor_Deceased_Yn
			, Donor_Org_Allow_Mail_Yn
			, Donor_Org_Allow_Bulk_Mail_Yn
			, Donor_Org_Allow_Email_Yn
			, Donor_Org_Allow_Bulk_Email_Yn 
			, Donor_Org_Allow_Phone_Yn
			, Donor_Org_Allow_Fax_Yn
			, Donor_Org_Class_Code
			, Donor_Org_Retiree_Ratio 
			, Donor_Org_Split_Ratio
			, Donor_Org_Matching_Ratio
			, Donor_Org_Pref_Cont_Meth
			, Donor_Org_Description 
			, Donor_Marriage_Status_Value
			--, Donor_Ethnicity_Value  /*Delete from source 5/15/17*/
			, Donor_Lds_Member_Value 
			, Donor_Personal_Suffix_Value 
			, Donor_Major_Gift_Propen_Value 
			, Donor_Annual_Gift_Value
			, Donor_Planned_Gift_Value
			, Donor_Gift_Capacity_Enp_Value 
			, Donor_Gift_Capacity_En_Value
			, Donor_Philan_Cap_Rating_Value
			, Donor_Est_Household_Income_Value
			, Donor_Est_Home_Market_Val_Value
			, Donor_Block_Clusters_Value 
			, Donor_Org_Class_Code_Value
			, Donor_Org_Retiree_Ratio_Value 
			, Donor_Org_Split_Ratio_Value 
			, Donor_Org_Matching_Ratio_Value
			, Donor_Org_Pref_Cont_Meth_Val
			, All_Personal_Connections
			, Byu_Student_Id
			, ByuI_Student_Id
			, ByuH_Student_Id
			, Ldsbc_Student_Id
			, Byu_Employee_Id
			, ByuI_Employee_Id
			, ByuH_Employee_Id
			, Ldsbc_Employee_Id
			, Spouse_Name
			, Spouse_LdspId
			, Ces_Id
			, Church_Payroll_Id
			, Donor_Total_Name
			, Donor_Total_Donation
			, Plus_PreferredFirstName
			, Plus_PreferredMiddleName
			, Plus_PreferredLastName
			, Plus_PreferredFullName
			, Plus_SpousePreferredFirstName
			, Plus_SpousePreferredMiddleName
			, Plus_SpousePreferredLastName
			, Plus_SpousePreferredFullName
			, Plus_CoordinatingLiaison
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Byu_Degrees
			, ByuI_Degrees
			, ByuH_Degrees
			, Ldsbc_Degrees
			, Donor_Age
			, General_Authority
			, Emeritus_General_Authority
			, Mission_President
			, Temple_President
			, All_Employment 
			, Current_Employment
			, Former_Employment
			, Spouse_Phone_Number
			, Spouse_Email 
			, Spouse_First_Name
			, Spouse_Last_Name
			, Spouse_Birth_Date
			, Spouse_Age
			, Byu_Donor
			, ByuI_Donor
			, ByuH_Donor
			, Ldsbc_Donor
			, Cell_Phone
			, Current_Employer_Name
			, Current_Job_Title
			, Current_Job_Code
			, Current_Job_Date_Started
			, Current_Job_Work_Phone
			, Current_Job_Work_Address
			, Donor_Total_Giving_Current_Year
			, Donor_Total_Giving_Current_Year_Minus_1
			, Donor_Total_Giving_Current_Year_Minus_2
			, Donor_Total_Giving_Current_Year_Minus_3
			, Donor_Any_School_Current_Student
			, Donor_BYU_Current_Student
			, Donor_BYUI_Current_Student
			, Donor_BYUH_Current_Student
			, Donor_LDSBC_Current_Student
			, Donor_Given_This_Year_To_Byu
			, Donor_Given_This_Year_To_ByuI
			, Donor_Given_This_Year_To_ByuH
			, Donor_Given_This_Year_To_LDSBC
			, Donor_Byu_Plc
			, Donor_Byuh_Plc
			, Donor_Nac
			, Donor_Byu_Law_Grads
			, Donor_Byu_Msm_Grads
			, Donor_Open_Byu_Telefund_Pledge
			, Donor_Open_Byui_Telefund_Pledge
			, Donor_Open_Byuh_Telefund_Pledge
			, Donor_Open_Ldsbc_Telefund_Pledge
			, Donor_Byu_Recurring_Donor
			, Donor_Byui_Recurring_Donor
			, Donor_Byuh_Recurring_Donor
			, Donor_Ldsbc_Recurring_Donor
			, Donor_Ldsp_Text_Lines
			, Donor_Largest_Gift_Amt_Byu
			, Donor_Largest_Gift_Amt_Byui
			, Donor_Largest_Gift_Amt_Byuh
			, Donor_Largest_Gift_Amt_Ldsbc
			, Donor_Retention_Type_Code_Byu
			, Donor_Retention_Type_Code_Byui
			, Donor_Retention_Type_Code_Byuh
			, Donor_Retention_Type_Code_Ldsbc
			, Donor_Total_Giving_To_Byu_Current_Year_Amt
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_1_Amt
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_2_Amt
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_3_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_1_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_2_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_3_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_1_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_2_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_3_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_1_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_2_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_3_Amt
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_4_Amt
			, Donor_Total_Giving_To_Byu_Current_Year_Minus_5_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_4_Amt
			, Donor_Total_Giving_To_Byui_Current_Year_Minus_5_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_4_Amt
			, Donor_Total_Giving_To_Byuh_Current_Year_Minus_5_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_4_Amt
			, Donor_Total_Giving_To_Ldsbc_Current_Year_Minus_5_Amt
			, Donor_Total_Giving_Current_Year_Minus_4_Amt
			, Donor_Total_Giving_Current_Year_Minus_5_Amt
			, Donor_Total_Giving_Byu_High_Flag
			, Donor_Total_Giving_Byui_High_Flag
			, Donor_Total_Giving_Byuh_High_Flag
			, Donor_Total_Giving_Ldsbc_High_Flag
			, Current_Byu_Employment_Yn
			, Current_Byui_Employment_Yn
			, Current_Byuh_Employment_Yn
			, Current_Ldsbc_Employment_Yn
			, Informal_Mailing_Name
			, Informal_Salutation
			, Byu_Night_Society_Member
			, Byui_Legacy_Society_Member
			, Byuh_Cowley_Society_Member
			, Ldsbc_Fox_Society_Member
			, Donor_Spouse_Coordinating_Liaison
			, Donor_Previously_Contacted_Byu_Yn
			, Donor_Previously_Contacted_ByuI_Yn
			, Donor_Previously_Contacted_ByuH_Yn
			, Donor_Previously_Contacted_Ldsbc_Yn
			, Donor_Given_Last_3_Months_To_Byu
			, Donor_Given_Last_3_Months_To_Byui
			, Donor_Given_Last_3_Months_To_Byuh
			, Donor_Given_Last_3_Months_To_Ldsbc
			, Donor_Given_Last_3_Months_To_Church
			, Donor_Liaison_Connections
			, Donor_Total_Lifetime_Giving
			, Donor_Total_Lifetime_Giving_Last_5_Years
			, Donor_Total_Lifetime_Giving_Byu
			, Donor_Total_Lifetime_Giving_Byui
			, Donor_Total_Lifetime_Giving_Byuh
			, Donor_Total_Lifetime_Giving_Ldsbc
			, Donor_Total_Lifetime_Giving_Church
			, Donor_Total_Lifetime_Giving_Pcc
			, Donor_Total_Lifetime_Giving_Ces
			, Donor_Most_Recent_Gift_Date_Ldsp
			, Donor_Most_Recent_Gift_Date_Byu
			, Donor_Most_Recent_Gift_Date_Byui
			, Donor_Most_Recent_Gift_Date_Byuh
			, Donor_Most_Recent_Gift_Date_Ldsbc
			, Donor_Most_Recent_Gift_Date_Church
			, Donor_Ldsp_Largest_Gift
			, Donor_First_Gift_Post_Date_Byu
			, Donor_First_Gift_Post_Date_Byui
			, Donor_First_Gift_Post_Date_Byuh
			, Donor_First_Gift_Post_Date_Ldsbc
			, Donor_Furthest_Initiative_Stage
			, Donor_Number_Of_Open_Initiatives
			, Donor_Total_Lifetime_Giving_To_Byu_Last_5_Years
			, Donor_Total_Lifetime_Giving_To_Byui_Last_5_Years
			, Donor_Total_Lifetime_Giving_To_Byuh_Last_5_Years
			, Donor_Total_Lifetime_Giving_To_Ldsbc_Last_5_Years
			, Donor_Total_Lifetime_Giving_To_Church_Last_5_Years
			, Donor_Most_Recent_Gift_To_Ldsp_Amt
			, Donor_Most_Recent_Gift_To_Byu_Amt
			, Donor_Most_Recent_Gift_To_Byui_Amt
			, Donor_Most_Recent_Gift_To_Byuh_Amt
			, Donor_Most_Recent_Gift_To_Ldsbc_Amt
			, Donor_Most_Recent_Gift_To_Church_Amt
			, Donor_Last_F2F_Visit_Date
			, Donor_Type_Code_Ldsp
			, Donor_Largest_Gift_Amt_Church
			, Donor_Largest_Gift_Date_Ldsp
			, Donor_Largest_Gift_Date_Byu
			, Donor_Largest_Gift_Date_Byui
			, Donor_Largest_Gift_Date_Byuh
			, Donor_Largest_Gift_Date_Ldsbc
			, Donor_Largest_Gift_Date_Church
			, Donor_Institution_Giving_Areas
			, Donor_Byu_Giving_Areas
			, Donor_Church_Giving_Areas
			, Donor_Pledge_Reminder_Email_Content_Byu
			, Donor_Pledge_Reminder_Email_Content_Byui
			, Donor_Pledge_Reminder_Email_Content_Byuh
			, Donor_Pledge_Reminder_Email_Content_Ldsbc
			, Donor_Total_Name_Display
			, Plus_CoordinatingLiaison_DomainName
			, Plus_PendingLiaison_DomainName
			, Plus_ConnectedLiaison_DomainName
			, Donor_Gift_Count_Previous_5_Years
			, Donor_Average_Single_Gift_Previous_5_Years
			, Donor_Is_Qualified
			, Donor_Qualified_On 
			, Donor_Qualified_By
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Donor_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''20D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Donor_Key INT PRIMARY KEY, Donor_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''20D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''20D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Donor_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Donor_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donor_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donor_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
				-- Prod Index
				IF EXISTS(SELECT * FROM sys.indexes WHERE object_id = object_id(''dbo._Donor_Dim'') AND NAME =''IX_Donor_Ldsp_Id'') 
				DROP INDEX IX_Donor_Ldsp_Id ON dbo._Donor_Dim; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
				CREATE NONCLUSTERED INDEX IX_Donor_Ldsp_Id 
					ON _Donor_Dim(Donor_Ldsp_Id ASC);
				UPDATE STATISTICS dbo._Donor_Dim
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)             
	,
-- --------------------------
-- _Fund_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Fund_Dim' -- Table_Name
		, 'Fund_Key  NVARCHAR(100)  PRIMARY KEY
			, Fund_Name  NVARCHAR(100) 
			, Fund_Institution_Name  NVARCHAR(100) 
			, Fund_Account_Number  NVARCHAR(100)
			, Plus_GiftPurposeSubtype NVARCHAR(400)
			, Plus_GiftPurposeType NVARCHAR(400)
			, Plus_LdspAccountNumberInt INT
			, New_FormalAccountName NVARCHAR(100)
			, New_InstitutionalHierarchy NVARCHAR(100)
			, New_InstitutionAccountNumber NVARCHAR(100)
			, Plus_Unrestricted NVARCHAR(1)
			, Plus_Scholarship NVARCHAR(1)
			, New_Endowment NVARCHAR(1)
			, Plus_EffectiveFrom DATE
			, Plus_EffectiveTo DATE
			, New_CaePurpose NVARCHAR(400)
			, Plus_SubClassAccountNumber NVARCHAR(100)
			, New_Description NVARCHAR(300)
			, Plus_Notes NVARCHAR(200)
			, Plus_AwardRestrictionGender NVARCHAR(400)
			, Plus_AwardRestrictionClassYear NVARCHAR(400)
			, Plus_AwardRestrictionCollege NVARCHAR(100)
			, Plus_AwardRestrictionEthnicity NVARCHAR(400)
			, Plus_AwardRestrictionGPA DECIMAL
			, Plus_AwardRestrictionMajor NVARCHAR(100)
			, Plus_GeographicArea NVARCHAR(100)
			, Plus_AwardRestrictionSeminaryGraduate NVARCHAR(1)
			, Plus_NeedBased NVARCHAR(1)
			, Plus_AwardRestrictionSingleParent NVARCHAR(1)
			, Plus_AwardRestrictionReturnedMissionary NVARCHAR(1)
			, Plus_PayItForward NVARCHAR(1)
			, Plus_AwardRestrictionNotes NVARCHAR(4000)
			, Plus_Athletics NVARCHAR(1)
			, Plus_FourYear NVARCHAR(1)
			, Plus_GraduateProfessional NVARCHAR(1)
			, Plus_TvRadio NVARCHAR(1)
			, Plus_TechnologySpec NVARCHAR(1)
			, Plus_AlumniAssociation NVARCHAR(1)
			, Plus_MatchingGiftText NVARCHAR(4000)
			, Plus_PrincipalAccountNumber NVARCHAR(100)
			, Plus_Spendable NVARCHAR(25)
			, Plus_ProposedEndowment NVARCHAR(400)
			, Plus_ReportFrequency NVARCHAR(400)
			, StatusCode NVARCHAR(400)
			, Hier_New_Inst NVARCHAR(100)
			, New_AllowGifts NVARCHAR(1)
			' -- Create_Table
		, 'Fund_Key
			, Fund_Name 
			, Fund_Institution_Name
			, Fund_Account_Number
			, Plus_GiftPurposeSubtype
			, Plus_GiftPurposeType
			, Plus_LdspAccountNumberInt
			, New_FormalAccountName
			, New_InstitutionalHierarchy
			, New_InstitutionAccountNumber
			, Plus_Unrestricted
			, Plus_Scholarship
			, New_Endowment
			, Plus_EffectiveFrom
			, Plus_EffectiveTo
			, New_CaePurpose
			, Plus_SubClassAccountNumber
			, New_Description
			, Plus_Notes
			, Plus_AwardRestrictionGender
			, Plus_AwardRestrictionClassYear
			, Plus_AwardRestrictionCollege
			, Plus_AwardRestrictionEthnicity
			, Plus_AwardRestrictionGPA
			, Plus_AwardRestrictionMajor
			, Plus_GeographicArea
			, Plus_AwardRestrictionSeminaryGraduate
			, Plus_NeedBased
			, Plus_AwardRestrictionSingleParent
			, Plus_AwardRestrictionReturnedMissionary
			, Plus_PayItForward
			, Plus_AwardRestrictionNotes
			, Plus_Athletics
			, Plus_FourYear
			, Plus_GraduateProfessional
			, Plus_TvRadio
			, Plus_TechnologySpec
			, Plus_AlumniAssociation
			, Plus_MatchingGiftText
			, Plus_PrincipalAccountNumber
			, Plus_Spendable
			, Plus_ProposedEndowment
			, Plus_ReportFrequency
			, StatusCode
			, Hier_New_Inst
			, New_AllowGifts
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Fund_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''21D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Fund_Key INT PRIMARY KEY, Fund_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''21D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''21D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Fund_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Fund_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Fund_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Fund_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Hier_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Hier_Dim' -- Table_Name
		, 'Hier_Key  NVARCHAR(100)  PRIMARY KEY
			, Hier_Name  NVARCHAR(100) 
			, Hier_Parent  NVARCHAR(100) 
			, Hier_Level_1  NVARCHAR(100) 
			, Hier_Level_2  NVARCHAR(100) 
			, Hier_Level_3  NVARCHAR(100) 
			, Hier_Avail_To_Alumni_Yn  NVARCHAR(1) 
			, Hier_Avail_To_Student_Yn  NVARCHAR(1) 
			, Hier_End_Node_Yn  NVARCHAR(1) 
			, Hier_Education_Usage_Yn  NVARCHAR(1) 
			--, Hier_Employee_Usage_Yn  NVARCHAR(1)  /*Delete from source 5/15/17*/
			, Hier_Association_Usage_Yn  NVARCHAR(1) 
			, Hier_Donation_Usage_Yn  NVARCHAR(1)
			, New_Inst NVARCHAR(100)
			' -- Create_Table
		, 'Hier_Key 
			, Hier_Name
			, Hier_Parent 
			, Hier_Level_1
			, Hier_Level_2 
			, Hier_Level_3
			, Hier_Avail_To_Alumni_Yn 
			, Hier_Avail_To_Student_Yn 
			, Hier_End_Node_Yn 
			, Hier_Education_Usage_Yn 
			--, Hier_Employee_Usage_Yn  /*Delete from source 5/15/17*/
			, Hier_Association_Usage_Yn 
			, Hier_Donation_Usage_Yn
			, New_Inst
		' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Hier_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''22D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Hier_Key INT PRIMARY KEY, Hier_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''22D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''22D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Hier_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Hier_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Hier_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Hier_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _User_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_User_Dim' -- Table_Name
		, 'User_Key NVARCHAR(100) PRIMARY KEY
			, User_Full_Name NVARCHAR(200)
			, User_First_Name NVARCHAR(64)
			, User_Last_Name NVARCHAR(64)
			, User_Personal_Email NVARCHAR(100)
			, User_Title NVARCHAR(128)
			, User_Internal_Email NVARCHAR(100)
			, User_Mobile_Phone NVARCHAR(64)
			, User_Domain_Name NVARCHAR(1024)
			' -- Create_Table 
		, 'User_Key
			, User_Full_Name
			, User_First_Name
			, User_Last_Name
			, User_Personal_Email
			, User_Title
			, User_Internal_Email
			, User_Mobile_Phone
			, User_Domain_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_User_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), User_Key INT PRIMARY KEY, User_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_User_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_User_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	, 
-- --------------------------
-- _User_Coordinating_Liaison_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_User_Coordinating_Liaison_Dim' -- Table_Name
		, 'User_Coordinating_Liaison_Key NVARCHAR(100) PRIMARY KEY
			, User_Full_Name NVARCHAR(200)
			, User_First_Name NVARCHAR(64)
			, User_Last_Name NVARCHAR(64)
			, User_Personal_Email NVARCHAR(100)
			, User_Title NVARCHAR(128)
			, User_Internal_Email NVARCHAR(100)
			, User_Mobile_Phone NVARCHAR(64)
			, User_Domain_Name NVARCHAR(1024)
			' -- Create_Table 
		, 'User_Coordinating_Liaison_Key
			, User_Full_Name
			, User_First_Name
			, User_Last_Name
			, User_Personal_Email
			, User_Title
			, User_Internal_Email
			, User_Mobile_Phone
			, User_Domain_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_User_Coordinating_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), User_Coordinating_Liaison_Key INT PRIMARY KEY, User_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_User_Coordinating_Liaison_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_User_Coordinating_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Coordinating_Liaison_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Coordinating_Liaison_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	, 
-- --------------------------
-- _User_Pending_Liaison_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_User_Pending_Liaison_Dim' -- Table_Name
		, 'User_Pending_Liaison_Key NVARCHAR(100) PRIMARY KEY
			, User_Full_Name NVARCHAR(200)
			, User_First_Name NVARCHAR(64)
			, User_Last_Name NVARCHAR(64)
			, User_Personal_Email NVARCHAR(100)
			, User_Title NVARCHAR(128)
			, User_Internal_Email NVARCHAR(100)
			, User_Mobile_Phone NVARCHAR(64)
			, User_Domain_Name NVARCHAR(1024)
			' -- Create_Table 
		, 'User_Pending_Liaison_Key
			, User_Full_Name
			, User_First_Name
			, User_Last_Name
			, User_Personal_Email
			, User_Title
			, User_Internal_Email
			, User_Mobile_Phone
			, User_Domain_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_User_Pending_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), User_Pending_Liaison_Key INT PRIMARY KEY, User_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_User_Pending_Liaison_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_User_Pending_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Pending_Liaison_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Pending_Liaison_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	, 	
-- --------------------------
-- _User_Connected_Liaison_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_User_Connected_Liaison_Dim' -- Table_Name
		, 'User_Connected_Liaison_Key NVARCHAR(100) PRIMARY KEY
			, User_Full_Name NVARCHAR(200)
			, User_First_Name NVARCHAR(64)
			, User_Last_Name NVARCHAR(64)
			, User_Personal_Email NVARCHAR(100)
			, User_Title NVARCHAR(128)
			, User_Internal_Email NVARCHAR(100)
			, User_Mobile_Phone NVARCHAR(64)
			, User_Domain_Name NVARCHAR(1024)
			' -- Create_Table 
		, 'User_Connected_Liaison_Key
			, User_Full_Name
			, User_First_Name
			, User_Last_Name
			, User_Personal_Email
			, User_Title
			, User_Internal_Email
			, User_Mobile_Phone
			, User_Domain_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_User_Connected_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), User_Connected_Liaison_Key INT PRIMARY KEY, User_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_User_Connected_Liaison_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_User_Connected_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Connected_Liaison_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Connected_Liaison_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	, 
-- --------------------------
-- _User_Initiative_Liaison_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_User_Initiative_Liaison_Dim' -- Table_Name
		, 'User_Initiative_Liaison_Key NVARCHAR(100) PRIMARY KEY
			, User_Full_Name NVARCHAR(200)
			, User_First_Name NVARCHAR(64)
			, User_Last_Name NVARCHAR(64)
			, User_Personal_Email NVARCHAR(100)
			, User_Title NVARCHAR(128)
			, User_Internal_Email NVARCHAR(100)
			, User_Mobile_Phone NVARCHAR(64)
			, User_Domain_Name NVARCHAR(1024)
			' -- Create_Table 
		, 'User_Initiative_Liaison_Key
			, User_Full_Name
			, User_First_Name
			, User_Last_Name
			, User_Personal_Email
			, User_Title
			, User_Internal_Email
			, User_Mobile_Phone
			, User_Domain_Name
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_User_Initiative_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), User_Initiative_Liaison_Key INT PRIMARY KEY, User_Initiative_Liaison_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_User_Initiative_Liaison_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_User_Initiative_Liaison_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Initiative_Liaison_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _User_Initiative_Liaison_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	, 
-- --------------------------
-- _Donation_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Donation_Dim' -- Table_Name
		, 'Donation_Key NVARCHAR(100) PRIMARY KEY
			, New_ConstituentDonor NVARCHAR(100)
			, New_OrganizationDonor NVARCHAR(100)
			, New_BatchNumber NVARCHAR(100)
			, New_GiftNumber NVARCHAR(50)
			, StatusCode NVARCHAR(400)
			, Plus_ReceiptText NVARCHAR(4000)
			, Plus_SpecialGiftInstructions NVARCHAR(4000)
			, Plus_CheckNumber NVARCHAR(50)
			, Plus_GiftSource NVARCHAR(400)
			, Plus_Kind NVARCHAR(400)
			, New_TenderType NVARCHAR(400)
			, New_AccountingDate DATE
			, Accounting_Date_Key NUMERIC(10,0)
			, New_ReceiptDate DATE
			, Receipt_Date_Key NUMERIC(10,0)
			, New_PostDate DATE
			, Post_Date_Key NUMERIC(10,0)
			, Plus_PlannedGift NVARCHAR(1)
			--, New_MatchingDonation NVARCHAR(1)  /*Delete from source 5/15/17*/
			--, Plus_GiftInKindProceeds NVARCHAR(1)  /*Delete from source 5/15/17*/
			, New_Transmitted NVARCHAR(1)
			, Plus_AnonymousGift NVARCHAR(1)
			, Plus_ReceiptDeliveryMethod NVARCHAR(400)
			, Plus_GiftInstructions NVARCHAR(4000)
			, Plus_AcknowledgementInstructions NVARCHAR(4000)
			, Plus_ExcludeFromReport NVARCHAR(1)
			, Plus_IncludeOnYearEndReceipt NVARCHAR(1)
			, Plus_GoodsServicesProvided NVARCHAR(1)
			-- , Plus_EntitledBenefitValue MONEY
			, Plus_AcknowledgeContact NVARCHAR(100)
			, Plus_ContactRole NVARCHAR(400)
			, Plus_Salutation NVARCHAR(400)
			, Plus_Signer NVARCHAR(100)
			, Plus_NoAcknowledgement NVARCHAR(1)
			, Match_Gift_Number NVARCHAR(50)
			, Plus_MatchExpected NVARCHAR(1)
			, Recurring_Gift NVARCHAR(1)
			, Recurring_Gift_Expectancy NVARCHAR(1)
			, Recognition_Credit_Recipients NVARCHAR(4000)
			, Donation_Receipt_Ytd_Last_Week NVARCHAR(1)
			, Donation_Receipt_Ytd_Last_Week_Last_Year NVARCHAR(1)
			, Donation_Receipt_Ytd_Two_Weeks_Ago NVARCHAR(1)
			, Donation_Description NVARCHAR(4000)
			, Lds_BatchType NVARCHAR(400)
			' -- Create_Table
		, 'Donation_Key 
			, New_ConstituentDonor
			, New_OrganizationDonor
			, New_BatchNumber
			, New_GiftNumber
			, StatusCode
			, Plus_ReceiptText
			, Plus_SpecialGiftInstructions
			, Plus_CheckNumber
			, Plus_GiftSource 
			, Plus_Kind 
			, New_TenderType 
			, New_AccountingDate
			, Accounting_Date_Key
			, New_ReceiptDate
			, Receipt_Date_Key
			, New_PostDate
			, Post_Date_Key
			, Plus_PlannedGift 
			--, New_MatchingDonation  /*Delete from source 5/15/17*/
			--, Plus_GiftInKindProceeds  /*Delete from source 5/15/17*/
			, New_Transmitted 
			, Plus_AnonymousGift 
			, Plus_ReceiptDeliveryMethod
			, Plus_GiftInstructions
			, Plus_AcknowledgementInstructions
			, Plus_ExcludeFromReport
			, Plus_IncludeOnYearEndReceipt
			, Plus_GoodsServicesProvided
			-- , Plus_EntitledBenefitValue
			, Plus_AcknowledgeContact
			, Plus_ContactRole
			, Plus_Salutation
			, Plus_Signer
			, Plus_NoAcknowledgement
			, Match_Gift_Number
			, Plus_MatchExpected
			, Recurring_Gift
			, Recurring_Gift_Expectancy
			, Recognition_Credit_Recipients
			, Donation_Receipt_Ytd_Last_Week
			, Donation_Receipt_Ytd_Last_Week_Last_Year
			, Donation_Receipt_Ytd_Two_Weeks_Ago
			, Donation_Description
			, Lds_BatchType
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Donation_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''24D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Donation_Key INT PRIMARY KEY, Donation_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''24D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''24D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Donation_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Donation_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donation_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donation_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Appeal_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Appeal_Dim' -- Table_Name
		, 'Appeal_Key NVARCHAR(100) PRIMARY KEY
			, Appeal_Name NVARCHAR(100)
			, Appeal_Code NVARCHAR(20)
			, Campaign_Institutional_Hierarchy NVARCHAR(100)
			, Campaign_Name NVARCHAR(128)
			, Delivery_Type NVARCHAR(400)
			, Communication_Type NVARCHAR(400)
			, Scheduled_Start DATE
			, Scheduled_End DATE
			, Actual_Start DATE
			, Actual_End DATE
			, Appeal_Format INT
			, Campaign_Type NVARCHAR(400)
			, Campaign_Status INT
			, Scope NVARCHAR(400)
			, Requester NVARCHAR(100)
			, Representing NVARCHAR(100)
			, Department_Owner NVARCHAR(400)   
			, Cause INT        
			, Campaign_Notes NVARCHAR(4000)
			, Budget_Allocated NVARCHAR(50)
			, Estimated_Revenue NVARCHAR(50)
			, Miscellaneous_Cost NVARCHAR(50)
			, Total_Cost_Of_Campaign_Activity NVARCHAR(50)
			, Total_Cost_Of_Campaign NVARCHAR(50)
			, Cost_To_Raise_1_Dollar NVARCHAR(50)
			, Total_Gift_Revenue_From_Campaign NVARCHAR(50)
			, Campaign_Profit NVARCHAR(50)
			, Appeal_Delivery_Type_Sort_Value INT
			, Appeal_Long_Name NVARCHAR(200)
			, Appeal_Reporting_Status NVARCHAR(100)
			' -- Create_Table 
		, 'Appeal_Key
			, Appeal_Name
			, Appeal_Code
			, Campaign_Institutional_Hierarchy
			, Campaign_Name
			, Delivery_Type
			, Communication_Type
			, Scheduled_Start
			, Scheduled_End
			, Actual_Start
			, Actual_End
			, Appeal_Format
			, Campaign_Type
			, Campaign_Status
			, Scope
			, Requester
			, Representing
			, Department_Owner    
			, Cause 
			, Campaign_Notes
			, Budget_Allocated
			, Estimated_Revenue
			, Miscellaneous_Cost
			, Total_Cost_Of_Campaign_Activity
			, Total_Cost_Of_Campaign
			, Cost_To_Raise_1_Dollar
			, Total_Gift_Revenue_From_Campaign
			, Campaign_Profit
			, Appeal_Delivery_Type_Sort_Value
			, Appeal_Long_Name
			, Appeal_Reporting_Status
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Appeal_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''25D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Appeal_Key INT PRIMARY KEY, Appeal_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''25D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''25D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Appeal_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Appeal_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Appeal_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Appeal_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Expectancy_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Expectancy_Dim' -- Table_Name
		, 'Expectancy_Key NVARCHAR(100) PRIMARY KEY
			, Plus_Kind NVARCHAR(400)
			, Plus_TenderType NVARCHAR(400)
			, Plus_GiftSource NVARCHAR(400)
			, Plus_PlannedGift NVARCHAR(400)
			, Plus_CheckNumber NVARCHAR(50)
			, New_Confidential NVARCHAR(400)
			, Plus_AcknowledgementInstructions NVARCHAR(4000)
			, Plus_NewAccountInstructions NVARCHAR(4000)
			, Plus_SpecialGiftInstructions NVARCHAR(4000)
			, Plus_TelefundRep NVARCHAR(100)
			, Plus_PlannedGivingPaymentFrequency NVARCHAR(400)
			, New_Bookable NVARCHAR(400)
			, Plus_MatchExpected NVARCHAR(400)
			, Plus_GiftRevocability NVARCHAR(400)
			, Plus_RemainderBeneficiary NVARCHAR(400)
			, New_Documentation NVARCHAR(400)
			, Plus_Designation NVARCHAR(4000)
			, Plus_NameOfTrust  NVARCHAR(200)
			, plus_PlannedGivingType NVARCHAR(400)
			, Plus_VehicleType NVARCHAR(400)
			, Plus_VehicleSubType NVARCHAR(400)
			, Plus_PayoutRate DECIMAL
			, Plus_Duration NVARCHAR(400)
			, Plus_LivesType NVARCHAR(400)
			, Plus_Years INT
			, Plus_Lives DECIMAL
			, Plus_TermBeneficiaryLives DECIMAL
			, Plus_TermBeneficiaryYears INT
			, Plus_Cri DECIMAL
			, Plus_GpsNotes NVARCHAR(4000)
			, New_PledgeNumber NVARCHAR(100)
			, Status INT
			, Status_Reason NVARCHAR(400)
			, New_TotalPledged MONEY
			, New_BalanceDue_Base MONEY
			, New_TotalPaid_Base MONEY
			, New_PaymentsToMake INT
			, New_PaymentsReceived INT
			, New_InstallmentAmount_Base MONEY
			, Plus_FairMarketValue_Base MONEY
			, Plus_PresentValue_Base MONEY
			, Plus_PaymentAmount_Base MONEY
			, Plus_AnnualAmount_Base MONEY
			, New_BeginDate DATE
			, New_EndDate DATE
			, Plus_InstallmentDate DATE
			, New_SignatureDate DATE
			, New_NotificationDate DATE
			, Plus_FundingDate DATE
			, Plus_EstimatedMaturityDate DATE
			, Plus_PaymentStartDate DATE
			, Lds_ExpectancyType NVARCHAR(400)
			' -- Create_Table 
		, 'Expectancy_Key
			, Plus_Kind
			, Plus_TenderType
			, Plus_GiftSource
			, Plus_PlannedGift
			, Plus_CheckNumber
			, New_Confidential
			, Plus_AcknowledgementInstructions
			, Plus_NewAccountInstructions
			, Plus_SpecialGiftInstructions
			, Plus_TelefundRep
			, Plus_PlannedGivingPaymentFrequency
			, New_Bookable
			, Plus_MatchExpected
			, Plus_GiftRevocability
			, Plus_RemainderBeneficiary
			, New_Documentation
			, Plus_Designation
			, Plus_NameOfTrust
			, plus_PlannedGivingType
			, Plus_VehicleType
			, Plus_VehicleSubType
			, Plus_PayoutRate
			, Plus_Duration
			, Plus_LivesType
			, Plus_Years
			, Plus_Lives
			, Plus_TermBeneficiaryLives
			, Plus_TermBeneficiaryYears
			, Plus_Cri
			, Plus_GpsNotes
			, New_PledgeNumber
			, Status
			, Status_Reason
			, New_TotalPledged
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, New_InstallmentAmount_Base
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, New_BeginDate
			, New_EndDate
			, Plus_InstallmentDate
			, New_SignatureDate
			, New_NotificationDate
			, Plus_FundingDate
			, Plus_EstimatedMaturityDate
			, Plus_PaymentStartDate
			, Lds_ExpectancyType
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Expectancy_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''26D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Expectancy_Key INT PRIMARY KEY, Expectancy_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''26D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''26D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Expectancy_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Expectancy_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Expectancy_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Expectancy_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,

-- --------------------------
-- _Donation_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Donation_Fact' -- Table_Name
		, 'Donor_Key  NVARCHAR(100) 
			, Acitivity_Group_Key  INT 
			, Address_Group_Key  INT 
			, Alumni_Group_Key  INT 
			, Association_Group_Key  INT 
			, Award_Group_Key  INT 
			, Drop_Include_Group_Key  INT 
			, Email_Group_Key  INT 
			, Employment_Group_Key  INT 
			, Language_Group_Key  INT 
			, Phone_Group_Key  INT 
			, Psa_Group_Key  INT 
			, Connection_Group_Key INT
			, Id_Group_Key INT
			, Interest_Group_Key INT
			, Student_Group_Key INT
			, Hier_Key  NVARCHAR(100) 
			, Fund_Key  NVARCHAR(100) 
			, User_Key  NVARCHAR(100) 
			, Donor_Primary_Yn  NVARCHAR(1)                                      
			, Donation_Credit_Amt  MONEY 
			, Donation_Primary_Amt  MONEY 
			--, Donation_Matching_Proposed_Amt  MONEY  /*Delete from source 5/15/17*/
			, Plus_EntitledBenefitValue MONEY
			, Donation_Key NVARCHAR(100)
			, Plus_Type NVARCHAR(500)
			, Plus_SharedCreditType NVARCHAR(500)
			, Appeal_Key NVARCHAR(100)
			, Donation_Receipt_Ytd_Last_Week_Amt MONEY
			, Donation_Receipt_Ytd_Last_Week_Last_Year_Amt MONEY
			, Donation_Receipt_Ytd_Two_Weeks_Ago_Amt MONEY
			, Inspired_Learning_Yearly_Goal MONEY
			, Inspired_Learning_Yearly_Goal_by_Account MONEY
			, Inspired_Learning_Total_Initiative_Goal MONEY
			, Inspired_Learning_Total_Initiative_Goal_by_Account MONEY
			, Initiative_Key NVARCHAR(100)
			, Expectancy_Key NVARCHAR(100)
			, User_Coordinating_Liaison_Key NVARCHAR(100)
			, User_Pending_Liaison_Key NVARCHAR(100)
			, User_Connected_Liaison_Key NVARCHAR(100)
			' -- Create_Table
		, 'Donor_Key
			, Acitivity_Group_Key 
			, Address_Group_Key 
			, Alumni_Group_Key 
			, Association_Group_Key 
			, Award_Group_Key 
			, Drop_Include_Group_Key 
			, Email_Group_Key 
			, Employment_Group_Key 
			, Language_Group_Key 
			, Phone_Group_Key 
			, Psa_Group_Key 
			, Connection_Group_Key
			, Id_Group_Key
			, Interest_Group_Key
			, Student_Group_Key
			, Hier_Key
			, Fund_Key
			, User_Key 
			, Donor_Primary_Yn 
			, Donation_Credit_Amt 
			, Donation_Primary_Amt
			--, Donation_Matching_Proposed_Amt  /*Delete from source 5/15/17*/
			, Plus_EntitledBenefitValue
			, Donation_Key
			, Plus_Type
			, Plus_SharedCreditType
			, Appeal_Key
			, Donation_Receipt_Ytd_Last_Week_Amt
			, Donation_Receipt_Ytd_Last_Week_Last_Year_Amt
			, Donation_Receipt_Ytd_Two_Weeks_Ago_Amt
			, Inspired_Learning_Yearly_Goal
			, Inspired_Learning_Yearly_Goal_by_Account
			, Inspired_Learning_Total_Initiative_Goal
			, Inspired_Learning_Total_Initiative_Goal_by_Account
			, Initiative_Key
			, Expectancy_Key
			, User_Coordinating_Liaison_Key
			, User_Pending_Liaison_Key
			, User_Connected_Liaison_Key
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''Donation_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''27D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Donoation_Key INT PRIMARY KEY, Donation_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''27D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''27D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Donation_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Donation_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donation_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donation_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Expectancy_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Expectancy_Fact' -- Table_Name
		, 'Expectancy_Key NVARCHAR(100)
			, New_TotalPledged MONEY
			, New_BeginDate DATE
			, Begin_Date_Key NUMERIC(10,0)
			, New_EndDate DATE
			, End_Date_Key NUMERIC(10,0)
			, New_BalanceDue_Base MONEY
			, New_TotalPaid_Base MONEY
			, New_PaymentsToMake INT
			, New_PaymentsReceived INT
			, New_InstallmentAmount_Base MONEY
			, Plus_InstallmentDate DATE
			, Installment_Date_Key NUMERIC(10,0)
			, Donation_Key NVARCHAR(100)
			, User_Key NVARCHAR(100)
			, Plus_FairMarketValue_Base MONEY
			, Plus_PresentValue_Base MONEY
			, New_SignatureDate DATE
			, Signature_Date_Key NUMERIC(10,0)
			, New_NotificationDate DATE
			, Notification_Date_Key NUMERIC(10,0)
			, Plus_FundingDate DATE
			, Funding_Date_Key NUMERIC(10,0)
			, Plus_EstimatedMaturityDate DATE
			, Estimated_Maturity_Date_Key NUMERIC(10,0)
			, Plus_PaymentAmount_Base MONEY
			, Plus_AnnualAmount_Base MONEY
			, Plus_PaymentStartDate DATE
			, Payment_Start_Date_Key NUMERIC(10,0)
			, Appeal_Key NVARCHAR(100)
			, Fund_Key NVARCHAR(100)
			, Hier_Key NVARCHAR(100)
			, Donor_Key NVARCHAR(100)
			, Initiative_Key NVARCHAR(100)
			' -- Create_Table
		, 'Expectancy_Key
			, New_TotalPledged
			, New_BeginDate
			, Begin_Date_Key
			, New_EndDate
			, End_Date_Key
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, New_InstallmentAmount_Base
			, Plus_InstallmentDate
			, Installment_Date_Key
			, Donation_Key
			, User_Key
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, New_SignatureDate
			, Signature_Date_Key
			, New_NotificationDate
			, Notification_Date_Key
			, Plus_FundingDate
			, Funding_Date_Key
			, Plus_EstimatedMaturityDate
			, Estimated_Maturity_Date_Key
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, Plus_PaymentStartDate
			, Payment_Start_Date_Key
			, Appeal_Key
			, Fund_Key
			, Hier_Key
			, Donor_Key
			, Initiative_Key
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Expectancy_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''28D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Expectancy_Key INT PRIMARY KEY, Expectancy_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''28D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''28D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Expectancy_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Expectancy_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Expectancy_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Expectancy_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Accounting_Fact' -- Table_Name
		, 'Donor_Key  NVARCHAR(100) 
			, Acitivity_Group_Key  INT 
			, Address_Group_Key  INT 
			, Alumni_Group_Key  INT 
			, Association_Group_Key  INT 
			, Award_Group_Key  INT 
			, Drop_Include_Group_Key  INT 
			, Email_Group_Key  INT 
			, Employment_Group_Key  INT 
			, Language_Group_Key  INT 
			, Phone_Group_Key  INT 
			, Psa_Group_Key  INT 
			, Connection_Group_Key INT
			, Id_Group_Key INT
			, Interest_Group_Key INT
			, Student_Group_Key INT
			, Fund_Key  NVARCHAR(100) 
			, User_Key  NVARCHAR(100) 
			, Donation_Key NVARCHAR(100)
			, Accounting_Amt  MONEY 	
			, New_AccountingDate DATE
			, Accounting_Date_Key NUMERIC(10,0)
			, Table_Source NVARCHAR(100)
			, Record_Status NVARCHAR(100)
			, Accounting_Through_Previous_Month_Current_Year_Amt MONEY
			, Accounting_Through_Previous_Month_Previous_Year_Amt MONEY
			, Accounting_Previous_Year_Amt MONEY
			, Accounting_Through_Previous_Month_Two_Years_Ago_Amt MONEY
			, Accounting_Two_Years_Ago_Amt MONEY
			, Accounting_Fact_Key BIGINT PRIMARY KEY
			, Accounting_Key NVARCHAR(100)
			, Hier_Key NVARCHAR(100)
			, Accounting_Dim_Key INT
			, Accounting_Tender_Type_Key INT
			, Accounting_Kind_Key INT
			, Accounting_Transmitted_Key INT
			, Accounting_Text_Key INT
			, Net_Recorded MONEY
			, Net_Not_Recorded MONEY
			, Net_Recorded_Monthly MONEY
			, Net_Not_Recorded_Monthly MONEY
			, Net_Recorded_Ytd MONEY
			, Net_Not_Recorded_Ytd MONEY
			, Net_Recorded_Prior_Years MONEY
			, Net_Not_Recorded_Prior_Years MONEY
			, Accounting_Month_Key INT
			, Reporting_Group_Key INT
			, Reporting_All_Group_Key INT
			, Accounting_Month_Date DATE
			, Accounting_Month_All_Goal MONEY
			, Accounting_Month_Goal MONEY
			, Accounting_Week_Key INT
			, Accounting_Last_Week_Ytd_Amt MONEY
			, Accounting_Last_Week_Minus_1_Ytd_Amt MONEY
			, Accounting_Last_Week_Last_Year_Ytd_Amt MONEY
			, Appeal_Key NVARCHAR(100)
			' -- Create_Table
		, 'Donor_Key 
			, Acitivity_Group_Key 
			, Address_Group_Key 
			, Alumni_Group_Key 
			, Association_Group_Key 
			, Award_Group_Key 
			, Drop_Include_Group_Key 
			, Email_Group_Key 
			, Employment_Group_Key 
			, Language_Group_Key 
			, Phone_Group_Key 
			, Psa_Group_Key 
			, Connection_Group_Key
			, Id_Group_Key
			, Interest_Group_Key
			, Student_Group_Key
			, Fund_Key 
			, User_Key
			, Donation_Key
			, Accounting_Amt 	
			, New_AccountingDate
			, Accounting_Date_Key
			, Table_Source
			, Record_Status
			, Accounting_Through_Previous_Month_Current_Year_Amt
			, Accounting_Through_Previous_Month_Previous_Year_Amt
			, Accounting_Previous_Year_Amt
			, Accounting_Through_Previous_Month_Two_Years_Ago_Amt
			, Accounting_Two_Years_Ago_Amt
			, Accounting_Fact_Key
			, Accounting_Key
			, Hier_Key
			, Accounting_Dim_Key
			, Accounting_Tender_Type_Key
			, Accounting_Kind_Key
			, Accounting_Transmitted_Key
			, Accounting_Text_Key
			, Net_Recorded
			, Net_Not_Recorded
			, Net_Recorded_Monthly
			, Net_Not_Recorded_Monthly
			, Net_Recorded_Ytd
			, Net_Not_Recorded_Ytd
			, Net_Recorded_Prior_Years
			, Net_Not_Recorded_Prior_Years
			, Accounting_Month_Key
			, Reporting_Group_Key
			, Reporting_All_Group_Key
			, Accounting_Month_Date
			, Accounting_Month_All_Goal
			, Accounting_Month_Goal
			, Accounting_Week_Key
			, Accounting_Last_Week_Ytd_Amt
			, Accounting_Last_Week_Minus_1_Ytd_Amt
			, Accounting_Last_Week_Last_Year_Ytd_Amt
			, Appeal_Key
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Accounting_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''29D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Accounting_Key INT PRIMARY KEY, Accounting_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''29D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''29D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Accounting_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Retention_Byu_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Retention_Byu_Fact' -- Table_Name
		, '	Donor_Key UNIQUEIDENTIFIER
			, Donor_Retention_Type_Key INT
			, Retention_Year INT
			, Retention_Donated_In_Year INT
			, Retention_Donated_This_Year INT
			, Retention_Donated_Last_Year INT
			, Retention_Donated_Cnt_Last_Year_Ytd INT
			' -- Create_Table
		, '	Donor_Key
			, Donor_Retention_Type_Key
			, Retention_Year
			, Retention_Donated_In_Year
			, Retention_Donated_This_Year
			, Retention_Donated_Last_Year
			, Retention_Donated_Cnt_Last_Year_Ytd
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Retention_Byu_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''30D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Retention_Byu_Key INT PRIMARY KEY, Retention_Byu_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''30D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''30D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Retention_Byu_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Retention_Byu_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byu_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byu_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30X'', @Alpha_Step_Name = ''Fact Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Retention_Byui_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Retention_Byui_Fact' -- Table_Name
		, '	Donor_Key UNIQUEIDENTIFIER
			, Donor_Retention_Type_Key INT
			, Retention_Year INT
			, Retention_Donated_In_Year INT
			, Retention_Donated_This_Year INT
			, Retention_Donated_Last_Year INT
			, Retention_Donated_Cnt_Last_Year_Ytd INT
			' -- Create_Table
		, '	Donor_Key
			, Donor_Retention_Type_Key
			, Retention_Year
			, Retention_Donated_In_Year
			, Retention_Donated_This_Year
			, Retention_Donated_Last_Year
			, Retention_Donated_Cnt_Last_Year_Ytd
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Retention_Byui_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''31D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Retention_Byui_Key INT PRIMARY KEY, Retention_Byui_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''31D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''31D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Retention_Byui_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Retention_Byui_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byui_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byui_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31X'', @Alpha_Step_Name = ''Fact Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Retention_Byuh_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Retention_Byuh_Fact' -- Table_Name
		, '	Donor_Key UNIQUEIDENTIFIER
			, Donor_Retention_Type_Key INT
			, Retention_Year INT
			, Retention_Donated_In_Year INT
			, Retention_Donated_This_Year INT
			, Retention_Donated_Last_Year INT
			, Retention_Donated_Cnt_Last_Year_Ytd INT
			' -- Create_Table
		, '	Donor_Key
			, Donor_Retention_Type_Key
			, Retention_Year
			, Retention_Donated_In_Year
			, Retention_Donated_This_Year
			, Retention_Donated_Last_Year
			, Retention_Donated_Cnt_Last_Year_Ytd
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Retention_Byuh_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''32D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Retention_Byuh_Key INT PRIMARY KEY, Retention_Byuh_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''32D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''32D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Retention_Byuh_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Retention_Byuh_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byuh_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Byuh_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32X'', @Alpha_Step_Name = ''Fact Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Retention_Ldsbc_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Retention_Ldsbc_Fact' -- Table_Name
		, '	Donor_Key UNIQUEIDENTIFIER
			, Donor_Retention_Type_Key INT
			, Retention_Year INT
			, Retention_Donated_In_Year INT
			, Retention_Donated_This_Year INT
			, Retention_Donated_Last_Year INT
			, Retention_Donated_Cnt_Last_Year_Ytd INT
			' -- Create_Table
		, '	Donor_Key
			, Donor_Retention_Type_Key
			, Retention_Year
			, Retention_Donated_In_Year
			, Retention_Donated_This_Year
			, Retention_Donated_Last_Year
			, Retention_Donated_Cnt_Last_Year_Ytd
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Retention_Ldsbc_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''33D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Retention_Ldsbc_Key INT PRIMARY KEY, Retention_Ldsbc_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''33D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''33D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Retention_Ldsbc_Fact'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Retention_Ldsbc_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Ldsbc_Fact)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Retention_Ldsbc_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33X'', @Alpha_Step_Name = ''Fact Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Donor_Retention_Type_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Donor_Retention_Type_Dim' -- Table_Name
		, ' Donor_Retention_Type_Key INT PRIMARY KEY
			, Donor_Retention_Type_Code NVARCHAR(2)
			, Donor_Retention_Type_Description NVARCHAR(100)
			, Donor_Retention_Type_National_Average NUMERIC(10,4)
			, Donor_Retention_Type_Ldsp_Description NVARCHAR(200)
			, Donor_Retention_Type_Other_Description NVARCHAR(200)
			' -- Create_Table
		, ' Donor_Retention_Type_Key
			, Donor_Retention_Type_Code
			, Donor_Retention_Type_Description
			, Donor_Retention_Type_National_Average
			, Donor_Retention_Type_Ldsp_Description
			, Donor_Retention_Type_Other_Description
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @SQL_2 NVARCHAR(MAX)
			DECLARE @TABLE_NAME_B NVARCHAR(100)
			SET @TABLE_NAME_B = ''_Donor_Retention_Type_Bridge''                                                                                                                  ---->  Hard Code  <----
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''34D'', @Alpha_Step_Name = ''Bridge Table Creation - Begin'', @Alpha_Result = 1;
					SET @SQL_2 = '' ''''OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + '''''', ''''U'''' ''
					SET @SQL_1 = ''
					IF OBJECT_ID('' + @SQL_2 + '') IS NOT NULL
					DROP TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''                                               
					CREATE TABLE OneAccord_Warehouse.dbo.'' + @TABLE_NAME_B + ''(ContactId NVARCHAR(100), Donor_Retention_Type_Key INT PRIMARY KEY, Donor_Retention_Type_Group_Key INT)''   ---->  Hard Code  <----                                             
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''34D'', @Alpha_Step_Name = ''Bridge Table Creation - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''34D'', @Alpha_Step_Name = ''Bridge Table Creation - End'', @Alpha_Result = 1;
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Donor_Retention_Type_Dim'' ;                                                                                                                     ---->  Hard Code  <----				
			SET @TABLE_NAME_B = ''_Donor_Retention_Type_Bridge''                                                                                                                  ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				DECLARE @TABLE_CNT2 AS VARCHAR(100) 
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
					SET @SQL_2 = ''INSERT INTO '' + @TABLE_NAME_B + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME_B + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Load Bridge Table - Query'', @Alpha_Query = @SQL_2, @Alpha_Result = 1;                                        
					-- EXEC(@SQL_2)                                                                                                                                    ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donor_Retention_Type_Dim)                                                                 ---->  Hard Code  <----	
					SELECT @TABLE_CNT2 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Donor_Retention_Type_Bridge)                                                              ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_B, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Bridge Table - Count'', @Alpha_Count = @TABLE_CNT2, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Dim' -- Table_Name
		, ' Accounting_Dim_Key INT PRIMARY KEY
			, Donation_Key NVARCHAR(100)
			, Accounting_Key NVARCHAR(100)
			, Accounting_Date DATE
			, Accounting_Receipt_Date DATE
			, Accounting_Post_Date DATE
			, Accounting_Gift_Number NVARCHAR(50)
			, Accounting_Related_Gift_Number NVARCHAR(50)
			, Accounting_Fact_Key BIGINT
			, Accounting_Gift_Source NVARCHAR(400)
			, Accounting_Adjustment_Yn NVARCHAR(1)
			, Accounting_Same_Month_Adj_Yn NVARCHAR(1)
			, Accounting_Current_Year_Adj_Yn NVARCHAR(1)
			, Accounting_Recognition_Credit_Recipients NVARCHAR(4000)
			' -- Create_Table
		, '  Accounting_Dim_Key
			, Donation_Key 
			, Accounting_Key 
			, Accounting_Date 
			, Accounting_Receipt_Date 
			, Accounting_Post_Date 
			, Accounting_Gift_Number 
			, Accounting_Related_Gift_Number 
			, Accounting_Fact_Key
			, Accounting_Gift_Source
			, Accounting_Adjustment_Yn
			, Accounting_Same_Month_Adj_Yn
			, Accounting_Current_Year_Adj_Yn
			, Accounting_Recognition_Credit_Recipients
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                  ---->  Comment out if there is no bridge table  <----
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	
	,
-- --------------------------
-- _Accounting_Tender_Type_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Tender_Type_Dim' -- Table_Name
		, ' Accounting_Tender_Type_Key INT PRIMARY KEY
			, Accounting_Tender_Type_Id INT
			, Accounting_Tender_Type_Desc NVARCHAR(400)
			' -- Create_Table
		, ' Accounting_Tender_Type_Key
			, Accounting_Tender_Type_Id
			, Accounting_Tender_Type_Desc
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Tender_Type_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Tender_Type_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	
	,
-- --------------------------
-- _Accounting_Kind_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Kind_Dim' -- Table_Name
		, '	Accounting_Kind_Key INT PRIMARY KEY
			, Accounting_Kind_Id INT
			, Accounting_Kind_Desc NVARCHAR(400)
			' -- Create_Table
		, '	Accounting_Kind_Key
			, Accounting_Kind_Id
			, Accounting_Kind_Desc
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Kind_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Kind_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_Transmitted_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Transmitted_Dim' -- Table_Name
		, 'Accounting_Transmitted_Key INT PRIMARY KEY
			, Accounting_Transmitted_Id INT
			, Accounting_Transmitted_Desc NVARCHAR(400)
			' -- Create_Table
		, 'Accounting_Transmitted_Key
			, Accounting_Transmitted_Id
			, Accounting_Transmitted_Desc
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Transmitted_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Transmitted_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	
	,
-- --------------------------
-- _Accounting_Text_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Text_Dim' -- Table_Name
		, 'Accounting_Text_Key INT PRIMARY KEY
			, Accounting_Text_Description_Text NVARCHAR(4000)
			, Accounting_Text_Receipt_Text NVARCHAR(4000)
			, Accounting_Text_Gift_Adjustment_Text NVARCHAR(4000)
			' -- Create_Table
		, 'Accounting_Text_Key
			, Accounting_Text_Description_Text
			, Accounting_Text_Receipt_Text
			, Accounting_Text_Gift_Adjustment_Text
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Text_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Text_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Primary_Contact_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Primary_Contact_Dim' -- Table_Name
		, 'Donor_Key NVARCHAR(100) PRIMARY KEY
			, Address_Primary_Yn NVARCHAR(1)
			, Address_Street_1 NVARCHAR(100)
			, Address_Street_2 NVARCHAR(100)
			, Address_Street_3 NVARCHAR(100)
			, Address_City NVARCHAR(100)
			, Address_County NVARCHAR(100)
			, Address_County_Code NVARCHAR(10)
			, Address_County_Id NVARCHAR(100)
			, Address_State_Province NVARCHAR(50)
			, Address_State_Code NVARCHAR(100)
			, Address_Country NVARCHAR(100)
			, Address_Post_Code_Full NVARCHAR(100)
			, Address_Post_Code_Last_4 NVARCHAR(15)
			, Address_Printing_Line_1 NVARCHAR(606)
			, Address_Printing_Line_2 NVARCHAR(406)
			, Address_Display NVARCHAR(300)
			, Address_Quality_Status NVARCHAR(400)
			, Address_Quality_Status_Value INT
			, Address_Longitude FLOAT
			, Address_Latitude FLOAT
			, Address_Active_Yn NVARCHAR(1)
			, Address_Confirmed_Yn NVARCHAR(1)
			--, Address_Undeliverable_Yn NVARCHAR(1)  /*Delete from source 5/15/17*/
			, Address_Confidential_Yn NVARCHAR(1)
			--, Address_Confidential_Reason NVARCHAR(400)  /*Delete from source 5/15/17*/
			, Address_Type NVARCHAR(400)
			, Address_Type_Value INT
			, Address_Printing_Line_3 NVARCHAR(100)
			, Address_Printing_Line_4 NVARCHAR(100)
			, Phone_Number NVARCHAR(100)
			, Phone_Country_Code NVARCHAR(100)
			, Phone_Extension NVARCHAR(100)
			, Phone_Active_Yn NVARCHAR(1)
			, Phone_Confirmed_Yn NVARCHAR(1)
			, Phone_Primary_Yn NVARCHAR(1)
			, Phone_Recieve_Text_Yn NVARCHAR(1)
			, Phone_Confidential_Yn NVARCHAR(1)
			--, Phone_Confidential_Reason NVARCHAR(400)   /*Delete from source 5/15/17*/
			, Phone_Type NVARCHAR(400)
			, Phone_Line_Type NVARCHAR(400)
			, Phone_Preferred_Time NVARCHAR(400)
			, Phone_Type_Value INT
			, Phone_Line_Type_Value INT
			, Phone_Preferred_Time_Value INT
			, Email_Address NVARCHAR(150)
			, Email_Primary_Yn NVARCHAR(1)
			, Email_Type NVARCHAR(400)
			, Email_Type_Value INT
			, Email_Active_Yn NVARCHAR(1)
			, Email_Confirmed_Yn NVARCHAR(1)
			, Email_Confidential_Yn NVARCHAR(1)
			--, Email_Confidential_Reason NVARCHAR(400)   /*Delete from source 5/15/17*/
			' -- Create_Table
		, 'Donor_Key
			, Address_Primary_Yn
			, Address_Street_1
			, Address_Street_2
			, Address_Street_3
			, Address_City
			, Address_County
			, Address_County_Code
			, Address_County_Id
			, Address_State_Province
			, Address_State_Code
			, Address_Country
			, Address_Post_Code_Full
			, Address_Post_Code_Last_4
			, Address_Printing_Line_1
			, Address_Printing_Line_2
			, Address_Display
			, Address_Quality_Status
			, Address_Quality_Status_Value
			, Address_Longitude
			, Address_Latitude
			, Address_Active_Yn
			, Address_Confirmed_Yn
			--, Address_Undeliverable_Yn  /*Delete from source 5/15/17*/
			, Address_Confidential_Yn
			--, Address_Confidential_Reason  /*Delete from source 5/15/17*/
			, Address_Type
			, Address_Type_Value
			, Address_Printing_Line_3
			, Address_Printing_Line_4
			, Phone_Number
			, Phone_Country_Code
			, Phone_Extension
			, Phone_Active_Yn
			, Phone_Confirmed_Yn
			, Phone_Primary_Yn
			, Phone_Recieve_Text_Yn
			, Phone_Confidential_Yn
			--, Phone_Confidential_Reason   /*Delete from source 5/15/17*/
			, Phone_Type
			, Phone_Line_Type
			, Phone_Preferred_Time
			, Phone_Type_Value
			, Phone_Line_Type_Value
			, Phone_Preferred_Time_Value
			, Email_Address
			, Email_Primary_Yn
			, Email_Type
			, Email_Type_Value
			, Email_Active_Yn
			, Email_Confirmed_Yn
			, Email_Confidential_Yn
			--, Email_Confidential_Reason   /*Delete from source 5/15/17*/
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Primary_Contact_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Primary_Contact_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Drop_Logic_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Drop_Logic_Dim' -- Table_Name
		, 'Donor_Key NVARCHAR(100) PRIMARY KEY
			, Drop_Byu_Mail_Ag NVARCHAR(1)
			, Drop_Byu_Email_Ag NVARCHAR(1)
			, Drop_Byu_Phone_Ag NVARCHAR(1)
			, Drop_Byui_Mail_Ag NVARCHAR(1)
			, Drop_Byui_Email_Ag NVARCHAR(1)
			, Drop_Byui_Phone_Ag NVARCHAR(1)
			, Drop_Byuh_Mail_Ag NVARCHAR(1)
			, Drop_Byuh_Email_Ag NVARCHAR(1)
			, Drop_Byuh_Phone_Ag NVARCHAR(1)
			, Drop_Ldsbc_Mail_Ag NVARCHAR(1)
			, Drop_Ldsbc_Email_Ag NVARCHAR(1)
			, Drop_Ldsbc_Phone_Ag NVARCHAR(1)
			, Drop_Byu_Mail_Acknowledgement NVARCHAR(1) 
			, Drop_Byu_Email_Acknowledgement NVARCHAR(1) 
			, Drop_Byu_Phone_Acknowledgement NVARCHAR(1) 
			, Drop_Byui_Mail_Acknowledgement NVARCHAR(1)
			, Drop_Byui_Email_Acknowledgement NVARCHAR(1)
			, Drop_Byui_Phone_Acknowledgement NVARCHAR(1)
			, Drop_Byuh_Mail_Acknowledgement NVARCHAR(1)
			, Drop_Byuh_Email_Acknowledgement NVARCHAR(1)
			, Drop_Byuh_Phone_Acknowledgement NVARCHAR(1)
			, Drop_Ldsbc_Mail_Acknowledgement NVARCHAR(1)
			, Drop_Ldsbc_Email_Acknowledgement NVARCHAR(1)
			, Drop_Ldsbc_Phone_Acknowledgement NVARCHAR(1)
			, Drop_Church_Mail_Acknowledgement NVARCHAR(1) 
			, Drop_Church_Email_Acknowledgement NVARCHAR(1) 
			, Drop_Church_Phone_Acknowledgement NVARCHAR(1)
			, Drop_Pcc_Mail_Acknowledgement NVARCHAR(1) 
			, Drop_Pcc_Email_Acknowledgement NVARCHAR(1) 
			, Drop_Pcc_Phone_Acknowledgement NVARCHAR(1)
			, Drop_Byu_Mail_All NVARCHAR(1)
			, Drop_Byui_Mail_All NVARCHAR(1)
			, Drop_Byuh_Mail_All NVARCHAR(1)
			, Drop_Ldsbc_Mail_All NVARCHAR(1)
			, Drop_Church_Mail_All NVARCHAR(1)
			, Drop_Byu_Email_All NVARCHAR(1)
			, Drop_Byui_Email_All NVARCHAR(1)
			, Drop_Byuh_Email_All NVARCHAR(1)
			, Drop_Ldsbc_Email_All NVARCHAR(1)
			, Drop_Church_Email_All NVARCHAR(1)
			, Drop_Byu_Phone_All NVARCHAR(1)
			, Drop_Byui_Phone_All NVARCHAR(1)
			, Drop_Byuh_Phone_All NVARCHAR(1)
			, Drop_Ldsbc_Phone_All NVARCHAR(1)
			, Drop_Church_Phone_All NVARCHAR(1)
			, Drop_Byu_Overall NVARCHAR(1)
			, Drop_Byui_Overall NVARCHAR(1)
			, Drop_Byuh_Overall NVARCHAR(1)
			, Drop_Ldsbc_Overall NVARCHAR(1)
			, Drop_Church_Overall NVARCHAR(1)
			' -- Create_Table
		, 'Donor_Key 
			, Drop_Byu_Mail_Ag 
			, Drop_Byu_Email_Ag
			, Drop_Byu_Phone_Ag
			, Drop_Byui_Mail_Ag 
			, Drop_Byui_Email_Ag
			, Drop_Byui_Phone_Ag
			, Drop_Byuh_Mail_Ag 
			, Drop_Byuh_Email_Ag
			, Drop_Byuh_Phone_Ag
			, Drop_Ldsbc_Mail_Ag 
			, Drop_Ldsbc_Email_Ag
			, Drop_Ldsbc_Phone_Ag
			, Drop_Byu_Mail_Acknowledgement
			, Drop_Byu_Email_Acknowledgement
			, Drop_Byu_Phone_Acknowledgement
			, Drop_Byui_Mail_Acknowledgement
			, Drop_Byui_Email_Acknowledgement
			, Drop_Byui_Phone_Acknowledgement
			, Drop_Byuh_Mail_Acknowledgement
			, Drop_Byuh_Email_Acknowledgement
			, Drop_Byuh_Phone_Acknowledgement
			, Drop_Ldsbc_Mail_Acknowledgement
			, Drop_Ldsbc_Email_Acknowledgement
			, Drop_Ldsbc_Phone_Acknowledgement
			, Drop_Church_Mail_Acknowledgement 
			, Drop_Church_Email_Acknowledgement 
			, Drop_Church_Phone_Acknowledgement
			, Drop_Pcc_Mail_Acknowledgement 
			, Drop_Pcc_Email_Acknowledgement 
			, Drop_Pcc_Phone_Acknowledgement
			, Drop_Byu_Mail_All
			, Drop_Byui_Mail_All
			, Drop_Byuh_Mail_All
			, Drop_Ldsbc_Mail_All
			, Drop_Church_Mail_All
			, Drop_Byu_Email_All
			, Drop_Byui_Email_All
			, Drop_Byuh_Email_All
			, Drop_Ldsbc_Email_All
			, Drop_Church_Email_All
			, Drop_Byu_Phone_All
			, Drop_Byui_Phone_All
			, Drop_Byuh_Phone_All
			, Drop_Ldsbc_Phone_All
			, Drop_Church_Phone_All
			, Drop_Byu_Overall
			, Drop_Byui_Overall
			, Drop_Byuh_Overall
			, Drop_Ldsbc_Overall
			, Drop_Church_Overall
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Drop_Logic_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Drop_Logic_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Reporting_Group_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Reporting_Group_Dim' -- Table_Name
		, 'Reporting_Group_Key INT PRIMARY KEY
			, Reporting_Group_Name NVARCHAR(100)
			, Reporting_Group_Tab INT
			, Reporting_Group_Inst NVARCHAR(100)
			, Reporting_Group_Primary_Hier_Name NVARCHAR(100)
			, Reporting_Group_Additional_Hier_Names NVARCHAR(4000)
			, Reporting_Group_Cip_Yearly_Goal_Amt MONEY
			' -- Create_Table
		, 'Reporting_Group_Key
			, Reporting_Group_Name
			, Reporting_Group_Tab
			, Reporting_Group_Inst
			, Reporting_Group_Primary_Hier_Name
			, Reporting_Group_Additional_Hier_Names
			, Reporting_Group_Cip_Yearly_Goal_Amt
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Reporting_Group_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Reporting_Group_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_Goals_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_Goals_Dim' -- Table_Name
		, 'Accounting_Goals_Key INT
			 , Accounting_Group_Key INT
			 , Accounting_Month_Key INT
			 , Month_Order INT
			 , Accounting_Goal MONEY
			' -- Create_Table
		, 'Accounting_Goals_Key
			 , Accounting_Group_Key
			 , Accounting_Month_Key
			 , Month_Order
			 , Accounting_Goal
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Goals_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Goals_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_All_Groups_Goals_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Accounting_All_Groups_Goals_Dim' -- Table_Name
		, 'Accounting_All_Groups_Goals_Key INT
			, Reporting_All_Group_Key INT
			, Accounting_All_Groups_Month_Key INT
			, Month_Order INT
			, Accounting_All_Groups_Goal MONEY
			' -- Create_Table
		, 'Accounting_All_Groups_Goals_Key
			, Reporting_All_Group_Key
			, Accounting_All_Groups_Month_Key
			, Month_Order
			, Accounting_All_Groups_Goal
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_All_Groups_Goals_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_All_Groups_Goals_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44X'', @Alpha_Step_Name = ''Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Initiative_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Initiative_Fact' -- Table_Name
		, 'Initiative_Fact_Key INT PRIMARY KEY
			, Initiative_Key NVARCHAR(100) -- OpportunityID
			, Donor_Key NVARCHAR(100) -- CustomerId
			, Fund_Account_Key NVARCHAR(100) -- Plus_FundAccount
			, Expectancy_Key NVARCHAR(100)  -- New_PledgeId (Connect using New_PledgeBase.New_Opportunity)  Zero Key
			, Donation_Donor_Key NVARCHAR(100)  -- Zero Key
			, Initiative_Proposal_Amt MONEY
			, Initiative_Total_Given_Amt MONEY
			, Initiative_Proposal_Date DATE
			, Initiative_Targeted_Commitment_Date DATE
			, Initiative_Committed_Date DATE
			, Initiative_Cultivation_Proc_Stg_1_Date DATE
			, Initiative_Cultivation_Proc_Stg_2_Date DATE
			, Initiative_Cultivation_Proc_Stg_3_Date DATE
			, Initiative_Cultivation_Proc_Stg_4_Date DATE
			, Initiative_Gift_Notice_Created_Date DATE
			, Initiative_Proposal_Status_Change_Date DATE
			, Expectancy_Total_Pledged_Amt MONEY
			, Expectancy_Balance_Due_Amt MONEY
			, Expectancy_Total_Paid_Amt MONEY
			, Expectancy_Installment_Amt MONEY
			, Expectancy_Payment_Amt MONEY
			, Expectancy_Annual_Amt MONEY
			, Expectancy_PaymentsToMake INT
			, Expectancy_PaymentsReceived INT
			, Expectancy_BeginDate DATE
			, Expectancy_EndDate DATE
			, Expectancy_InstallmentDate DATE
			, Expectancy_SignatureDate DATE
			, Expectancy_NotificationDate DATE
			, Expectancy_FundingDate DATE
			, Expectancy_EstimatedMaturityDate DATE
			, Expectancy_PaymentStartDate DATE
			, Donation_Donor_Primary NVARCHAR(1)
			, Donation_Primary_Amt MONEY
			, Donation_Credit_Amt MONEY	
			, Donation_Receipt_Date DATE
			, Initiative_Total_Committed_Amt MONEY
			, Hier_Key NVARCHAR(100)
			, User_Initiative_Liaison_Key NVARCHAR(100)
			, User_Coordinating_Liaison_Key NVARCHAR(100)
			' -- Create_Table
		, 'Initiative_Key
			, Donor_Key
			, Fund_Account_Key
			, Expectancy_Key
			, Donation_Key
			, Initiative_Proposal_Amt
			, Initiative_Total_Given_Amt
			, Initiative_Proposal_Date
			, Initiative_Targeted_Commitment_Date
			, Initiative_Committed_Date
			, Initiative_Cultivation_Proc_Stg_1_Date
			, Initiative_Cultivation_Proc_Stg_2_Date
			, Initiative_Cultivation_Proc_Stg_3_Date
			, Initiative_Cultivation_Proc_Stg_4_Date
			, Initiative_Gift_Notice_Created_Date
			, Initiative_Proposal_Status_Change_Date
			, Expectancy_Total_Pledged_Amt
			, Expectancy_Balance_Due_Amt
			, Expectancy_Total_Paid_Amt
			, Expectancy_Installment_Amt
			, Expectancy_Payment_Amt
			, Expectancy_Annual_Amt
			, Expectancy_PaymentsToMake
			, Expectancy_PaymentsReceived
			, Expectancy_BeginDate
			, Expectancy_EndDate
			, Expectancy_InstallmentDate
			, Expectancy_SignatureDate
			, Expectancy_NotificationDate
			, Expectancy_FundingDate
			, Expectancy_EstimatedMaturityDate
			, Expectancy_PaymentStartDate
			, Donation_Donor_Primary
			, Donation_Primary_Amt
			, Donation_Credit_Amt
			, Donation_Receipt_Date 
			, Initiative_Total_Committed_Amt
			, Hier_Key
			, User_Initiative_Liaison_Key
			, User_Coordinating_Liaison_Key
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Initiative_Fact'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Initiative_Fact)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45X'', @Alpha_Step_Name = ''Initiative Fact Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Initiative_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Initiative_Dim' -- Table_Name
		, 'Initiative_Key NVARCHAR(100) PRIMARY KEY-- OpportunityID
			, Initiative_Name NVARCHAR(600)
			, Initiative_Step_Name NVARCHAR(400)
			, Initiative_State_Code NVARCHAR(400)
			, Initiative_Status_Code NVARCHAR(400)
			, Initiative_Proposal_Status NVARCHAR(400)
			, Initiative_New_Account NVARCHAR(400)
			, Initiative_Liaison NVARCHAR(200)
			, Initiative_Supporting_Liaisons NVARCHAR(1000)
			, Initiative_Gift_Planning_Serv_Team NVARCHAR(1000)
			, Initiative_Team NVARCHAR(1000)
			, Initiative_Coordinating_Liaison NVARCHAR(200)
			, Initiative_Name_Donor_Name NVARCHAR(1000)
			, Initiative_Proposal_Date DATE
			, Initiative_Targeted_Commitment_Date DATE
			, Initiative_Committed_Date DATE
			, Initiative_Cultivation_Proc_Stg_1_Date DATE
			, Initiative_Cultivation_Proc_Stg_2_Date DATE
			, Initiative_Cultivation_Proc_Stg_3_Date DATE
			, Initiative_Cultivation_Proc_Stg_4_Date DATE
			, Initiative_Gift_Notice_Created_Date DATE
			, Initiative_Proposal_Status_Change_Date DATE
			, Initiative_Primary_Initiative NVARCHAR(1)
			, Initiative_Parent_Initiative NVARCHAR(600)
			' -- Create_Table
		, 'Initiative_Key
			, Initiative_Name
			, Initiative_Step_Name
			, Initiative_State_Code
			, Initiative_Status_Code
			, Initiative_Proposal_Status
			, Initiative_New_Account
			, Initiative_Liaison
			, Initiative_Supporting_Liaisons
			, Initiative_Gift_Planning_Serv_Team
			, Initiative_Team 
			, Initiative_Coordinating_Liaison
			, Initiative_Name_Donor_Name
			, Initiative_Proposal_Date
			, Initiative_Targeted_Commitment_Date
			, Initiative_Committed_Date
			, Initiative_Cultivation_Proc_Stg_1_Date
			, Initiative_Cultivation_Proc_Stg_2_Date
			, Initiative_Cultivation_Proc_Stg_3_Date
			, Initiative_Cultivation_Proc_Stg_4_Date
			, Initiative_Gift_Notice_Created_Date
			, Initiative_Proposal_Status_Change_Date
			, Initiative_Primary_Initiative
			, Initiative_Parent_Initiative
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Initiative_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Initiative_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46X'', @Alpha_Step_Name = ''Initiative Dim Table - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Accounting_Week Table
-- --------------------------
	('Support' -- Dim_Object
		, '_Accounting_Week' -- Table_Name
		, 'Accounting_Week_Key INT
			, Accounting_Week_Date DATE
			, Accounting_Week_Number INT
			, Accounting_Week_Day_Of_Week INT
			, Accounting_Week_Number_Date DATE -- Friday
			, Accounting_Week_Last_Week_Yn NVARCHAR(1) -- Number week prior to this week
			, Accounting_Week_Last_Week_Minus_1_Yn NVARCHAR(1) -- Number week prior to last week
			, Accounting_Week_Current_Week_Number_Last_Year_Yn NVARCHAR(1)
			' -- Create_Table
		, 'Accounting_Week_Key
			, Accounting_Week_Date
			, Accounting_Week_Number
			, Accounting_Week_Day_Of_Week
			, Accounting_Week_Number_Date
			, Accounting_Week_Last_Week_Yn
			, Accounting_Week_Last_Week_Minus_1_Yn
			, Accounting_Week_Current_Week_Number_Last_Year_Yn
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Accounting_Week'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Accounting_Week)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47X'', @Alpha_Step_Name = ''_Accounting_Week - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)		
	,
-- --------------------------
-- _Recurring_Gift_Fact Table
-- --------------------------
	('Fact' -- Dim_Object
		, '_Recurring_Gift_Fact' -- Table_Name
		, '	Recurring_Gift_Key NVARCHAR(100)
			, Donor_Key NVARCHAR(100)
			, Fund_Key NVARCHAR(100)
			, Hier_Key NVARCHAR(100)
			, Appeal_Key NVARCHAR(100)
			, Recurring_Gift_Amt MONEY
			' -- Create_Table
		, '	Recurring_Gift_Key
			, Donor_Key
			, Fund_Key
			, Hier_Key
			, Appeal_Key
			, Recurring_Gift_Amt
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Recurring_Gift_Fact'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Recurring_Gift_Fact)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48X'', @Alpha_Step_Name = ''_Recurring_Gift_Fact - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)
	,
-- --------------------------
-- _Recurring_Gift_Dim Table
-- --------------------------
	('Dim' -- Dim_Object
		, '_Recurring_Gift_Dim' -- Table_Name
		, '	Recurring_Gift_Key NVARCHAR(100)
			, Recurring_Gift_Status_Code NVARCHAR(400)
			, Recurring_Gift_State_Code NVARCHAR(400)
			, Recurring_Gift_Type NVARCHAR(400)
			, Recurring_Gift_Amt MONEY
			, Recurring_Gift_Frequency NVARCHAR(400)
			, Recurring_Gift_Payment_Start_Date DATE
			, Recurring_Gift_Payment_Stop_Date DATE
			, Recurring_Gift_Group NVARCHAR(100)
			' -- Create_Table
		, '	Recurring_Gift_Key
			, Recurring_Gift_Status_Code
			, Recurring_Gift_State_Code
			, Recurring_Gift_Type
			, Recurring_Gift_Amt
			, Recurring_Gift_Frequency
			, Recurring_Gift_Payment_Start_Date
			, Recurring_Gift_Payment_Stop_Date
			, Recurring_Gift_Group
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''_Recurring_Gift_Dim'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM _Recurring_Gift_Dim)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49X'', @Alpha_Step_Name = ''_Recurring_Gift_Dim - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	
	,
-- --------------------------
-- View_Portfolio_Management Table
-- --------------------------
	('View_Table' -- Dim_Object
		, 'View_Portfolio_Management' -- Table_Name
		, '	Ldsp_Id NVARCHAR(100)
			, Donor_Full_Name NVARCHAR(160)
			, Donor_Display_Name NVARCHAR(100)
			, Couple_Name NVARCHAR(200)
			, Couple_Display_Name NVARCHAR(200)
			, Coordinating_Liaison NVARCHAR(200)
			, Pending_Liaison NVARCHAR(200)
			, Connected_Liaison NVARCHAR(200)
			, Coordinating_Liaison_Domain_Name NVARCHAR(1024)
			, Pending_Liaison_Domain_Name NVARCHAR(1024)
			, Connected_Liaison_Domain_Name NVARCHAR(1024)
			, Contact_Type NVARCHAR(100)
			, Ldsp_Donor_Type NVARCHAR(2)
			, Age INT
			, Birthdate DATE
			, Birth_Year NVARCHAR(100)
			, Address_Type NVARCHAR(400)
			, Street_Line_1 NVARCHAR(100)
			, Street_Line_2 NVARCHAR(100)
			, City NVARCHAR(100)
			, County NVARCHAR(100)
			, State_Abbreviation NVARCHAR(100)
			, Zip_Code NVARCHAR(100)
			, Country NVARCHAR(100)
			, Phone_Number NVARCHAR(100)
			, Email_Address NVARCHAR(150)
			, Spouse_Email NVARCHAR(100)
			, Total_Lifetime_Giving MONEY
			, Total_Lifetime_Giving_Last_5_Years MONEY
			, Total_Giving_Current_Year MONEY
			, Total_Giving_1_Years_Ago MONEY
			, Total_Giving_2_Years_Ago MONEY
			, Total_Giving_3_Years_Ago MONEY
			, Total_Giving_4_Years_Ago MONEY
			, Total_Giving_5_Years_Ago MONEY
			, Gift_Capacity_2016_To_2020 NVARCHAR(400)
			, Gift_Count_Previous_5_Years INT
			, Average_Single_Gift_Previous_5_Years MONEY
			, Ldsp_Largest_Gift MONEY
			, Ldsp_Largest_Gift_Date DATE
			, Ldsp_Most_Recent_Gift MONEY
			, Ldsp_Most_Recent_Gift_Date DATE
			, Institution_Giving_Areas NVARCHAR(1000)
			, Byu_Giving_Areas NVARCHAR(2000)
			, Church_Giving_Areas NVARCHAR(2000)
			, Is_Qualified NVARCHAR(1)
			, Qualified_On DATE 
			, Qualified_By NVARCHAR(200)
			' -- Create_Table
		, '	Ldsp_Id
			, Donor_Full_Name
			, Donor_Display_Name
			, Couple_Name
			, Couple_Display_Name
			, Coordinating_Liaison
			, Pending_Liaison
			, Connected_Liaison
			, Coordinating_Liaison_Domain_Name 
			, Pending_Liaison_Domain_Name
			, Connected_Liaison_Domain_Name
			, Contact_Type
			, Ldsp_Donor_Type
			, Age
			, Birthdate
			, Birth_Year
			, Address_Type
			, Street_Line_1
			, Street_Line_2
			, City
			, County
			, State_Abbreviation
			, Zip_Code
			, Country
			, Phone_Number
			, Email_Address
			, Spouse_Email
			, Total_Lifetime_Giving
			, Total_Lifetime_Giving_Last_5_Years
			, Total_Giving_Current_Year
			, Total_Giving_1_Years_Ago
			, Total_Giving_2_Years_Ago
			, Total_Giving_3_Years_Ago
			, Total_Giving_4_Years_Ago
			, Total_Giving_5_Years_Ago
			, Gift_Capacity_2016_To_2020
			, Gift_Count_Previous_5_Years
			, Average_Single_Gift_Previous_5_Years
			, Ldsp_Largest_Gift
			, Ldsp_Largest_Gift_Date
			, Ldsp_Most_Recent_Gift
			, Ldsp_Most_Recent_Gift_Date
			, Institution_Giving_Areas
			, Byu_Giving_Areas
			, Church_Giving_Areas
			, Is_Qualified
			, Qualified_On 
			, Qualified_By
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''View_Portfolio_Management'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM View_Portfolio_Management)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50X'', @Alpha_Step_Name = ''View_Portfolio_Management - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	
	,
-- --------------------------
-- View_Liaison_Initiative Table
-- --------------------------
	('View_Table' -- Dim_Object
		, 'View_Liaison_Initiative' -- Table_Name
		, '	Liaison_Initiative_Id INT
			, Liaison NVARCHAR(200) 
			, Liaison_Role NVARCHAR(100) 
			, Initiative_Id NVARCHAR(100)
			, Initiative_Name NVARCHAR(600) 
			, Initiative_Name_Donor_Name NVARCHAR(1000) 
			, Ldsp_Id NVARCHAR(100)
			, Donor_Name NVARCHAR(160) 
			, Initiative_Stage NVARCHAR(400)
			, Fund_Account_Name NVARCHAR(100)
			, Proposal_Status NVARCHAR(400) 
			, Proposal_Amt MONEY
			, Total_Committed_Amt MONEY
			, Total_Given_Amt MONEY
			, Supporting_Liaison_Credit_Amt MONEY
			' -- Create_Table
		, '	Liaison_Initiative_Id
			, Liaison
			, Liaison_Role 
			, Initiative_Id
			, Initiative_Name
			, Initiative_Name_Donor_Name
			, Ldsp_Id 
			, Donor_Name
			, Initiative_Stage
			, Fund_Account_Name
			, Proposal_Status
			, Proposal_Amt
			, Total_Committed_Amt
			, Total_Given_Amt
			, Supporting_Liaison_Credit_Amt
			' -- Insert_Fields
		, ' ' -- From_Statement
		, ' ' -- Where_Statement
		, '
			' -- Attribute_1 (Create Bridge Table)
		, 'DECLARE @SQL_1 NVARCHAR(MAX)
			DECLARE @TABLE_NAME NVARCHAR(100) 
			SET @TABLE_NAME = ''View_Liaison_Initiative'' ;                                                                                                                     ---->  Hard Code  <----				                                                                                                                 ---->  Hard Code  <----
			BEGIN TRY                                      
				DECLARE @TABLE_CNT1 AS VARCHAR(100)  
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51E'', @Alpha_Step_Name = ''Dim Tables - Copy - Begin'', @Alpha_Result = 1;                                          
					SET @SQL_1 = ''INSERT INTO '' + @TABLE_NAME + '' SELECT * FROM [MSSQL12336\S01].[OneAccord_Warehouse].[dbo].'' + @TABLE_NAME + ''''
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51E'', @Alpha_Step_Name = ''Load Table - Query'', @Alpha_Query = @SQL_1, @Alpha_Result = 1;                                        
					EXEC(@SQL_1)                                                                                                                                 
					SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM View_Liaison_Initiative)                                                                 ---->  Hard Code  <----	                                                             ---->  Hard Code  <----	
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51E'', @Alpha_Step_Name = ''Dim Table - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51E'', @Alpha_Step_Name = ''Dim Tables - Copy - End'', @Alpha_Result = 1;                                            
			END TRY 
			BEGIN CATCH   
				DECLARE @ERROR_NUMBER INT
				DECLARE @ERROR_SEVERITY INT
				DECLARE @ERROR_STATE INT
				DECLARE @ERROR_PROCEDURE NVARCHAR(500)
				DECLARE @ERROR_LINE INT
				DECLARE @ERROR_MESSAGE NVARCHAR(MAX)
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51X'', @Alpha_Step_Name = ''View_Liaison_Initiative - Copy - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_2 (Copy Tables)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51F'', @Alpha_Step_Name = ''Drop Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51F'', @Alpha_Step_Name = ''Drop Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_3 (Drop Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51G'', @Alpha_Step_Name = ''Add Indexes - Begin'', @Alpha_Result = 1; 
			EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51G'', @Alpha_Step_Name = ''Add Indexes - End'', @Alpha_Result = 1;
			' -- Attribute_4 (Add Indexes)
		, 'EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_5 (End)
		, ' ' -- Attribute_6
		, ' ' -- Attribute_7
		, ' ' -- Attribute_8
		, ' ' -- Attribute_9
		, ' ' -- Attribute_10
		, ' ' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, ' ' -- Attribute_19
		, ' ' -- Attribute_20
		, 1 -- Active
		, GETDATE() -- Insert_Date
		, NULL  -- Update_Date                
	)	

	
-- --------------------------------------------------------------------------------------          

	DECLARE @Main_Total_Loop_Num INT
		SELECT @Main_Total_Loop_Num = (
			SELECT MAX(Fields_Key) AS Max_Field
				FROM CREATE_TRANS_LOAD_TABLES
				WHERE 1 = 1
					AND Active = 1
		)
	DECLARE @Main_LOOP_NUM INT
	SET @Main_LOOP_NUM = 1
		WHILE  @Main_LOOP_NUM <= @Main_Total_Loop_Num 
		BEGIN

			DECLARE @IsActive INT
			SELECT @IsActive = (
				SELECT Active 
					FROM CREATE_TRANS_LOAD_TABLES
					WHERE 1 = 1
						AND Fields_Key = @Main_LOOP_NUM
			)
			DECLARE @Table_Name_By_Loop NVARCHAR(200)
			SELECT @Table_Name_By_Loop = (
				SELECT Table_Name
					FROM CREATE_TRANS_LOAD_TABLES
					WHERE 1 = 1
						AND Fields_Key = @Main_LOOP_NUM
			)

			IF @IsActive = 1
				BEGIN

					BEGIN TRY

-- -----------------------------
-- Create Table
-- -----------------------------

						DECLARE @TABLE_NAME VARCHAR(100)
						DECLARE @CREATE_FIELDS VARCHAR(MAX)
						DECLARE @INSERT_FIELDS VARCHAR(MAX)
						DECLARE @SQL_1 VARCHAR(MAX)
						DECLARE @SQL_2 VARCHAR(MAX)

						SELECT @TABLE_NAME = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);

						EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

						SET @SQL_2 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME + ''', ''U'' '
						SET @SQL_1 = '
						IF OBJECT_ID(' + @SQL_2 + ') IS NOT NULL
						DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '

						CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '(' + @CREATE_FIELDS + ')'

						EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1, @Alpha_Result = 1;

						EXEC(@SQL_1)

						EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


					END TRY             
					BEGIN CATCH

						DECLARE @ERROR_NUMBER INT
						DECLARE @ERROR_SEVERITY INT
						DECLARE @ERROR_STATE INT
						DECLARE @ERROR_PROCEDURE NVARCHAR(500)
						DECLARE @ERROR_LINE INT
						DECLARE @ERROR_MESSAGE NVARCHAR(MAX)

						SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
						SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
						SELECT @ERROR_STATE = (SELECT ERROR_STATE())
						SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
						SELECT @ERROR_LINE = (SELECT ERROR_LINE())
						SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())

						EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
						, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;

					END CATCH

					DECLARE @SQL_ATTRIBUTE1 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE2 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE3 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE4 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE5 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE6 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE7 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE8 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE9 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE10 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE11 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE12 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE13 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE14 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE15 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE16 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE17 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE18 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE19 NVARCHAR(MAX);
					DECLARE @SQL_ATTRIBUTE20 NVARCHAR(MAX);

					SELECT @SQL_ATTRIBUTE1 = (SELECT ATTRIBUTE_1 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE2 = (SELECT ATTRIBUTE_2 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE3 = (SELECT ATTRIBUTE_3 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE4 = (SELECT ATTRIBUTE_4 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE5 = (SELECT ATTRIBUTE_5 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE6 = (SELECT ATTRIBUTE_6 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE7 = (SELECT ATTRIBUTE_7 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE8 = (SELECT ATTRIBUTE_8 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE9 = (SELECT ATTRIBUTE_9 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE10 = (SELECT ATTRIBUTE_10 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE11 = (SELECT ATTRIBUTE_11 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE12 = (SELECT ATTRIBUTE_12 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);          
					SELECT @SQL_ATTRIBUTE13 = (SELECT ATTRIBUTE_13 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);          
					SELECT @SQL_ATTRIBUTE14 = (SELECT ATTRIBUTE_14 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE15 = (SELECT ATTRIBUTE_15 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE16 = (SELECT ATTRIBUTE_16 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);          
					SELECT @SQL_ATTRIBUTE17 = (SELECT ATTRIBUTE_17 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE18 = (SELECT ATTRIBUTE_18 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);          
					SELECT @SQL_ATTRIBUTE19 = (SELECT ATTRIBUTE_19 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					SELECT @SQL_ATTRIBUTE20 = (SELECT ATTRIBUTE_20 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);


					EXEC(@SQL_ATTRIBUTE1 + ' ' + @SQL_ATTRIBUTE2 + ' ' + @SQL_ATTRIBUTE3 + ' ' + 
					@SQL_ATTRIBUTE4 + ' ' + @SQL_ATTRIBUTE5 + ' ' + @SQL_ATTRIBUTE6 + ' ' + 
					@SQL_ATTRIBUTE7 + ' ' + @SQL_ATTRIBUTE8 + ' ' + @SQL_ATTRIBUTE9 + ' ' + 
					@SQL_ATTRIBUTE10 + ' ' + @SQL_ATTRIBUTE11 + ' ' + @SQL_ATTRIBUTE12 + ' ' + @SQL_ATTRIBUTE13
					)
					EXEC(@SQL_ATTRIBUTE14)
					EXEC(@SQL_ATTRIBUTE15)
					EXEC(@SQL_ATTRIBUTE16)
					EXEC(@SQL_ATTRIBUTE17)
					EXEC(@SQL_ATTRIBUTE18)
					EXEC(@SQL_ATTRIBUTE19)
					EXEC(@SQL_ATTRIBUTE20)
					
					
					
					DECLARE @BEG_TIME4 DATETIME
					DECLARE @END_TIME4 DATETIME
					DECLARE @DURATION4 INT
					DECLARE @RECORD_CNT4 INT
					DECLARE @SQL_4B VARCHAR(MAX)
					DECLARE @SQL_4C VARCHAR(MAX)
					DECLARE @SQL_4D VARCHAR(MAX)
					DECLARE @SQL_4E VARCHAR(MAX)
					
					DECLARE @RECORD_CNT4A NVARCHAR(MAX) = N'SELECT @RECORD_CNT4 = (SELECT COUNT(*) FROM ' + @TABLE_NAME + ')'
					EXEC sp_executesql @RECORD_CNT4A, N'@RECORD_CNT4 INT OUT', @RECORD_CNT4 OUT
					
					DECLARE @BEG_TIME4A NVARCHAR(MAX) = N'SELECT @BEG_TIME4 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
					EXEC sp_executesql @BEG_TIME4A, N'@BEG_TIME4 DATETIME OUT', @BEG_TIME4 OUT

					DECLARE @END_TIME4A NVARCHAR(MAX) = N'SELECT @END_TIME4 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
					EXEC sp_executesql @END_TIME4A, N'@END_TIME4 DATETIME OUT', @END_TIME4 OUT

					SET @DURATION4 = DATEDIFF(SECOND,@BEG_TIME4,@END_TIME4)
				 
						
					EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4, @Alpha_End_Time = @END_TIME4, @Alpha_Duration_In_Seconds = @DURATION4, @Alpha_Count = @RECORD_CNT4, @Alpha_Result = 1;

				END

			SET @Main_LOOP_NUM = @Main_LOOP_NUM + 1         
		END
	SET @Main_LOOP_NUM = 0



	DECLARE @Email_Step1_Error_Cnt INT
	DECLARE @Email_Body VARCHAR(MAX)

	SELECT @Email_Step1_Error_Cnt = (SELECT COUNT(Alpha_Result) FROM OneAccord_Warehouse.dbo.Alpha_Table_3 WHERE Alpha_Result = '0'); 

	EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = 'Trans\Load Tables Email', @Alpha_Step_Number = 'Email_1A', @Alpha_Step_Name = 'Trans\Load - Email Error Count', @Alpha_Count = @Email_Step1_Error_Cnt, @Alpha_Result = 1;

	SET @Email_Body = 'The LDSP ETL has completed with ' + CONVERT(VARCHAR(12),@Email_Step1_Error_Cnt) + ' errors.'
	
	CREATE TABLE #Prod_Summary (
		[Production Table] NVARCHAR(100)
		, Duration INT
		, [Count] INT
		, [Time] NVARCHAR(15)
		, Message NVARCHAR(1000)
		, [Timestamp] DATETIME
	)
	
	INSERT INTO #Prod_Summary
	SELECT Alpha_Stage AS [Production Table]
	, Alpha_Duration_In_Seconds AS Duration
	, Alpha_Count AS [Count]
	, LEFT(RIGHT(CONVERT(VARCHAR,Alpha_DateTime,9),14),8) + ' ' + RIGHT(CONVERT(VARCHAR,Alpha_DateTime,9),2) AS [Time]
	, ErrorMessage AS Message 
	, Alpha_DateTime AS [Timestamp]
	FROM Alpha_Table_3 
	WHERE 1 = 1
		AND (Alpha_Step_Name = 'Stats'
				OR Alpha_Result = 0)
	
	DECLARE @xml NVARCHAR(MAX)
	DECLARE @body NVARCHAR(MAX)
	
	SET @xml = CAST((SELECT [Production Table] AS 'td','', Duration AS 'td','', [Count] AS 'td','', [Time] AS 'td','', Message AS 'td' FROM #Prod_Summary ORDER BY [Timestamp] DESC
		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))
	
	SET @body ='<html><body><H3> ' + @Email_Body + '</H3>
		<table border = 1> 
		<tr>
		<th> Production Table </th> <th> Duration </th> <th> Count </th> <th> Time </th> <th> Message </th> </tr>'    
		 
	SET @body = @body + @xml +'</table></body></html>'
	

	EXEC msdb.dbo.sp_send_dbmail
	@recipients = 'fams@LDSChurch.org' 
	, @subject = 'LDSP PRODUCTION Copy Complete'  -->>>>>> EMAIL SUBJECT <<<<<<<--
	, @body = @body
	, @body_format = 'HTML'
	, @query = 'SELECT * FROM OneAccord_Warehouse.dbo.Alpha_Table_3'
	, @query_result_header=1
	, @query_no_truncate=1
	, @attach_query_result_as_file=1
	, @query_attachment_filename = 'Alpha Table 3.csv'
	, @query_result_separator = '^'
	
	DROP TABLE #Prod_Summary

	EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = 'Trans\Load Tables Email', @Alpha_Step_Number = 'Email_1B', @Alpha_Step_Name = 'Trans\Load - Email', @Alpha_Result = 1;
