/*************************************************************
	NAME: usp_Transform_Data 
	PURPOSE: Log the script and performance
	PLATFORM: Sql Server Management Studio

	REVISIONS:
	Ver        Date        Author           Description
	---------  ----------  ---------------  ------------------------------------
	1.0        11/08/2017  Fams             1. Development of the initial script

**************************************************************/


USE [OneAccord_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_Transform_Data]    Script Date: 11/8/2017 9:33:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[usp_Transform_Data]
ALTER PROCEDURE [dbo].[usp_Transform_Data]

	@Transform_Data_Table_Name NVARCHAR(100) = NULL

AS

BEGIN

	--DROP TABLE IF EXISTS Transform_Data;
	IF NOT EXISTS (SELECT * FROM SysObjects WHERE 1 = 1 AND Name = 'Transform_Data' AND XType = 'U')
	CREATE TABLE Transform_Data (
		Transform_Data_Key INT IDENTITY(10000,1) PRIMARY KEY
		, Transform_DateTime DATETIME
		, Transform_Table_Id INT
		, Transform_Table_Name NVARCHAR(100)
		, Transform_Table_Count INT
		, Transform_Duration INT 
		, Transform_Script_Dim_Object_Yesterday NVARCHAR(MAX)
		, Transform_Script_Dim_Object_Today NVARCHAR(MAX)
		, Transform_Script_Dim_Object_Modified_Yn NVARCHAR(1)
		, Transform_Script_Table_Name_Yesterday NVARCHAR(MAX)
		, Transform_Script_Table_Name_Today NVARCHAR(MAX)
		, Transform_Script_Table_Name_Modified_Yn NVARCHAR(1)
		, Transform_Script_Create_Fields_Yesterday NVARCHAR(MAX)
		, Transform_Script_Create_Fields_Today NVARCHAR(MAX)
		, Transform_Script_Create_Fields_Modified_Yn NVARCHAR(1)
		, Transform_Script_Insert_Fields_Yesterday NVARCHAR(MAX)
		, Transform_Script_Insert_Fields_Today NVARCHAR(MAX)
		, Transform_Script_Insert_Fields_Modified_Yn NVARCHAR(1)
		, Transform_Script_From_Statement_Yesterday NVARCHAR(MAX)
		, Transform_Script_From_Statement_Today NVARCHAR(MAX)
		, Transform_Script_From_Statement_Modified_Yn NVARCHAR(1)
		, Transform_Script_Where_Statement_Yesterday NVARCHAR(MAX)
		, Transform_Script_Where_Statement_Today NVARCHAR(MAX)
		, Transform_Script_Where_Statement_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_1_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_1_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_1_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_2_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_2_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_2_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_3_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_3_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_3_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_4_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_4_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_4_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_5_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_5_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_5_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_6_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_6_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_6_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_7_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_7_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_7_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_8_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_8_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_8_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_9_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_9_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_9_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_10_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_10_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_10_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_11_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_11_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_11_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_12_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_12_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_12_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_13_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_13_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_13_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_14_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_14_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_14_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_15_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_15_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_15_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_16_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_16_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_16_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_17_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_17_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_17_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_18_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_18_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_18_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_19_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_19_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_19_Modified_Yn NVARCHAR(1)
		, Transform_Script_Attribute_20_Yesterday NVARCHAR(MAX)
		, Transform_Script_Attribute_20_Today NVARCHAR(MAX)
		, Transform_Script_Attribute_20_Modified_Yn NVARCHAR(1)
		, Transform_Table_Count_Lag INT
		, Transform_Duration_Lag INT
		, Records_Per_Seconds INT
		, Table_Count_Percent_Increase DECIMAL(12,4)
	)

	DECLARE @Transform_DateTime DATETIME
	DECLARE @Transform_Table_Id INT
	DECLARE @Transform_Table_Name NVARCHAR(100)
	DECLARE @Transform_Table_Count INT
	DECLARE @Transform_Duration INT
	DECLARE @Transform_Script_Dim_Object_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Dim_Object_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Dim_Object_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Table_Name_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Table_Name_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Table_Name_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Create_Fields_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Create_Fields_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Create_Fields_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Insert_Fields_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Insert_Fields_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Insert_Fields_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_From_Statement_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_From_Statement_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_From_Statement_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Where_Statement_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Where_Statement_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Where_Statement_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_1_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_1_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_1_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_2_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_2_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_2_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_3_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_3_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_3_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_4_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_4_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_4_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_5_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_5_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_5_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_6_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_6_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_6_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_7_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_7_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_7_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_8_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_8_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_8_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_9_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_9_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_9_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_10_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_10_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_10_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_11_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_11_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_11_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_12_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_12_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_12_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_13_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_13_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_13_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_14_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_14_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_14_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_15_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_15_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_15_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_16_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_16_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_16_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_17_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_17_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_17_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_18_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_18_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_18_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_19_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_19_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_19_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Script_Attribute_20_Yesterday NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_20_Today NVARCHAR(MAX)
	DECLARE @Transform_Script_Attribute_20_Modified_Yn NVARCHAR(1)
	DECLARE @Transform_Table_Count_Lag INT
	DECLARE @Transform_Duration_Lag INT
	DECLARE @Records_Per_Seconds INT
	DECLARE @Table_Count_Percent_Increase DECIMAL(12,4)
	DECLARE @Alpha_Stage_Table_Name NVARCHAR(100)
	SET @Alpha_Stage_Table_Name = @Transform_Data_Table_Name
	SET @Transform_DateTime = (SELECT MAX(Alpha_DateTime) AS Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name)
	SET @Transform_Table_Id = (SELECT Transform_Table_Id FROM Transform_Tables WHERE 1 = 1 AND Transform_Table_Name = @Alpha_Stage_Table_Name)             --*--
	SET @Transform_Table_Name = @Alpha_Stage_Table_Name 
	SET @Transform_Table_Count = (SELECT Alpha_Count FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name AND Alpha_Step_Name = 'Stats') 
	SET @Transform_Duration = (SELECT Alpha_Duration_In_Seconds FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name AND Alpha_Step_Name = 'Stats')
	SET @Transform_Script_Dim_Object_Yesterday = (SELECT Transform_Script_Dim_Object_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Dim_Object_Today = (SELECT Dim_Object FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Dim_Object_Modified_Yn = 'N'
	SET @Transform_Script_Table_Name_Yesterday = (SELECT Transform_Script_Table_Name_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Table_Name_Today = (SELECT Table_Name FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Table_Name_Modified_Yn = 'N'
	SET @Transform_Script_Create_Fields_Yesterday = (SELECT Transform_Script_Create_Fields_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Create_Fields_Today = (SELECT Create_Fields FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Create_Fields_Modified_Yn = 'N'
	SET @Transform_Script_Insert_Fields_Yesterday = (SELECT Transform_Script_Insert_Fields_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Insert_Fields_Today = (SELECT Insert_Fields FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Insert_Fields_Modified_Yn = 'N'
	SET @Transform_Script_From_Statement_Yesterday = (SELECT Transform_Script_From_Statement_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_From_Statement_Today = (SELECT From_Statement FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_From_Statement_Modified_Yn = 'N'
	SET @Transform_Script_Where_Statement_Yesterday = (SELECT Transform_Script_Where_Statement_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Where_Statement_Today = (SELECT Where_Statement FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Where_Statement_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_1_Yesterday = (SELECT Transform_Script_Attribute_1_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_1_Today = (SELECT Attribute_1 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_1_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_2_Yesterday = (SELECT Transform_Script_Attribute_2_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_2_Today = (SELECT Attribute_2 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_2_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_3_Yesterday = (SELECT Transform_Script_Attribute_3_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_3_Today = (SELECT Attribute_3 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_3_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_4_Yesterday = (SELECT Transform_Script_Attribute_4_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_4_Today = (SELECT Attribute_4 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_4_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_5_Yesterday = (SELECT Transform_Script_Attribute_5_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_5_Today = (SELECT Attribute_5 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_5_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_6_Yesterday = (SELECT Transform_Script_Attribute_6_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_6_Today = (SELECT Attribute_6 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_6_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_7_Yesterday = (SELECT Transform_Script_Attribute_7_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_7_Today = (SELECT Attribute_7 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_7_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_8_Yesterday = (SELECT Transform_Script_Attribute_8_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_8_Today = (SELECT Attribute_8 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_8_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_9_Yesterday = (SELECT Transform_Script_Attribute_9_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_9_Today = (SELECT Attribute_9 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_9_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_10_Yesterday = (SELECT Transform_Script_Attribute_10_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_10_Today = (SELECT Attribute_10 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_10_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_11_Yesterday = (SELECT Transform_Script_Attribute_11_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_11_Today = (SELECT Attribute_11 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_11_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_12_Yesterday = (SELECT Transform_Script_Attribute_12_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_12_Today = (SELECT Attribute_12 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_12_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_13_Yesterday = (SELECT Transform_Script_Attribute_13_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_13_Today = (SELECT Attribute_13 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_13_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_14_Yesterday = (SELECT Transform_Script_Attribute_14_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_14_Today = (SELECT Attribute_14 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_14_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_15_Yesterday = (SELECT Transform_Script_Attribute_15_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_15_Today = (SELECT Attribute_15 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_15_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_16_Yesterday = (SELECT Transform_Script_Attribute_16_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_16_Today = (SELECT Attribute_16 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_16_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_17_Yesterday = (SELECT Transform_Script_Attribute_17_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_17_Today = (SELECT Attribute_17 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_17_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_18_Yesterday = (SELECT Transform_Script_Attribute_18_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_18_Today = (SELECT Attribute_18 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_18_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_19_Yesterday = (SELECT Transform_Script_Attribute_19_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_19_Today = (SELECT Attribute_19 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_19_Modified_Yn = 'N'
	SET @Transform_Script_Attribute_20_Yesterday = (SELECT Transform_Script_Attribute_20_Today 
													FROM Transform_Data
													WHERE 1 = 1
															AND Transform_Data_Key IN
															(
																SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
																	FROM 
																		(
																			SELECT Transform_Data_Key
																				, MAX(Transform_DateTime) AS Transform_DateTime
																				FROM Transform_Data
																				WHERE 1 = 1
																					AND Transform_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Transform_Data_Key
																		) A
															)		
												)
	SET @Transform_Script_Attribute_20_Today = (SELECT Attribute_20 FROM Create_Trans_Load_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Transform_Script_Attribute_20_Modified_Yn = 'N'
	INSERT INTO Transform_Data (
		Transform_DateTime
		, Transform_Table_Id 
		, Transform_Table_Name
		, Transform_Table_Count
		, Transform_Duration 
		, Transform_Script_Dim_Object_Yesterday
		, Transform_Script_Dim_Object_Today
		, Transform_Script_Dim_Object_Modified_Yn
		, Transform_Script_Table_Name_Yesterday
		, Transform_Script_Table_Name_Today
		, Transform_Script_Table_Name_Modified_Yn
		, Transform_Script_Create_Fields_Yesterday
		, Transform_Script_Create_Fields_Today
		, Transform_Script_Create_Fields_Modified_Yn
		, Transform_Script_Insert_Fields_Yesterday
		, Transform_Script_Insert_Fields_Today
		, Transform_Script_Insert_Fields_Modified_Yn
		, Transform_Script_From_Statement_Yesterday
		, Transform_Script_From_Statement_Today
		, Transform_Script_From_Statement_Modified_Yn
		, Transform_Script_Where_Statement_Yesterday
		, Transform_Script_Where_Statement_Today
		, Transform_Script_Where_Statement_Modified_Yn
		, Transform_Script_Attribute_1_Yesterday
		, Transform_Script_Attribute_1_Today
		, Transform_Script_Attribute_1_Modified_Yn
		, Transform_Script_Attribute_2_Yesterday
		, Transform_Script_Attribute_2_Today
		, Transform_Script_Attribute_2_Modified_Yn
		, Transform_Script_Attribute_3_Yesterday
		, Transform_Script_Attribute_3_Today
		, Transform_Script_Attribute_3_Modified_Yn
		, Transform_Script_Attribute_4_Yesterday
		, Transform_Script_Attribute_4_Today
		, Transform_Script_Attribute_4_Modified_Yn
		, Transform_Script_Attribute_5_Yesterday
		, Transform_Script_Attribute_5_Today
		, Transform_Script_Attribute_5_Modified_Yn
		, Transform_Script_Attribute_6_Yesterday
		, Transform_Script_Attribute_6_Today
		, Transform_Script_Attribute_6_Modified_Yn
		, Transform_Script_Attribute_7_Yesterday
		, Transform_Script_Attribute_7_Today
		, Transform_Script_Attribute_7_Modified_Yn
		, Transform_Script_Attribute_8_Yesterday
		, Transform_Script_Attribute_8_Today
		, Transform_Script_Attribute_8_Modified_Yn
		, Transform_Script_Attribute_9_Yesterday
		, Transform_Script_Attribute_9_Today
		, Transform_Script_Attribute_9_Modified_Yn
		, Transform_Script_Attribute_10_Yesterday
		, Transform_Script_Attribute_10_Today
		, Transform_Script_Attribute_10_Modified_Yn
		, Transform_Script_Attribute_11_Yesterday
		, Transform_Script_Attribute_11_Today
		, Transform_Script_Attribute_11_Modified_Yn
		, Transform_Script_Attribute_12_Yesterday
		, Transform_Script_Attribute_12_Today
		, Transform_Script_Attribute_12_Modified_Yn
		, Transform_Script_Attribute_13_Yesterday
		, Transform_Script_Attribute_13_Today
		, Transform_Script_Attribute_13_Modified_Yn
		, Transform_Script_Attribute_14_Yesterday
		, Transform_Script_Attribute_14_Today
		, Transform_Script_Attribute_14_Modified_Yn
		, Transform_Script_Attribute_15_Yesterday
		, Transform_Script_Attribute_15_Today
		, Transform_Script_Attribute_15_Modified_Yn
		, Transform_Script_Attribute_16_Yesterday 
		, Transform_Script_Attribute_16_Today
		, Transform_Script_Attribute_16_Modified_Yn
		, Transform_Script_Attribute_17_Yesterday
		, Transform_Script_Attribute_17_Today
		, Transform_Script_Attribute_17_Modified_Yn
		, Transform_Script_Attribute_18_Yesterday
		, Transform_Script_Attribute_18_Today
		, Transform_Script_Attribute_18_Modified_Yn
		, Transform_Script_Attribute_19_Yesterday
		, Transform_Script_Attribute_19_Today
		, Transform_Script_Attribute_19_Modified_Yn
		, Transform_Script_Attribute_20_Yesterday
		, Transform_Script_Attribute_20_Today
		, Transform_Script_Attribute_20_Modified_Yn
		, Transform_Table_Count_Lag 
		, Transform_Duration_Lag
		, Records_Per_Seconds
		, Table_Count_Percent_Increase
	)
	VALUES
		(@Transform_DateTime
		, @Transform_Table_Id 
		, @Transform_Table_Name
		, @Transform_Table_Count
		, @Transform_Duration 
		, @Transform_Script_Dim_Object_Yesterday
		, @Transform_Script_Dim_Object_Today
		, @Transform_Script_Dim_Object_Modified_Yn
		, @Transform_Script_Table_Name_Yesterday
		, @Transform_Script_Table_Name_Today
		, @Transform_Script_Table_Name_Modified_Yn
		, @Transform_Script_Create_Fields_Yesterday
		, @Transform_Script_Create_Fields_Today
		, @Transform_Script_Create_Fields_Modified_Yn
		, @Transform_Script_Insert_Fields_Yesterday
		, @Transform_Script_Insert_Fields_Today
		, @Transform_Script_Insert_Fields_Modified_Yn
		, @Transform_Script_From_Statement_Yesterday
		, @Transform_Script_From_Statement_Today
		, @Transform_Script_From_Statement_Modified_Yn
		, @Transform_Script_Where_Statement_Yesterday
		, @Transform_Script_Where_Statement_Today
		, @Transform_Script_Where_Statement_Modified_Yn
		, @Transform_Script_Attribute_1_Yesterday
		, @Transform_Script_Attribute_1_Today
		, @Transform_Script_Attribute_1_Modified_Yn
		, @Transform_Script_Attribute_2_Yesterday
		, @Transform_Script_Attribute_2_Today
		, @Transform_Script_Attribute_2_Modified_Yn
		, @Transform_Script_Attribute_3_Yesterday
		, @Transform_Script_Attribute_3_Today
		, @Transform_Script_Attribute_3_Modified_Yn
		, @Transform_Script_Attribute_4_Yesterday
		, @Transform_Script_Attribute_4_Today
		, @Transform_Script_Attribute_4_Modified_Yn
		, @Transform_Script_Attribute_5_Yesterday
		, @Transform_Script_Attribute_5_Today
		, @Transform_Script_Attribute_5_Modified_Yn
		, @Transform_Script_Attribute_6_Yesterday
		, @Transform_Script_Attribute_6_Today
		, @Transform_Script_Attribute_6_Modified_Yn
		, @Transform_Script_Attribute_7_Yesterday
		, @Transform_Script_Attribute_7_Today
		, @Transform_Script_Attribute_7_Modified_Yn
		, @Transform_Script_Attribute_8_Yesterday
		, @Transform_Script_Attribute_8_Today
		, @Transform_Script_Attribute_8_Modified_Yn
		, @Transform_Script_Attribute_9_Yesterday
		, @Transform_Script_Attribute_9_Today
		, @Transform_Script_Attribute_9_Modified_Yn
		, @Transform_Script_Attribute_10_Yesterday
		, @Transform_Script_Attribute_10_Today
		, @Transform_Script_Attribute_10_Modified_Yn
		, @Transform_Script_Attribute_11_Yesterday
		, @Transform_Script_Attribute_11_Today
		, @Transform_Script_Attribute_11_Modified_Yn
		, @Transform_Script_Attribute_12_Yesterday
		, @Transform_Script_Attribute_12_Today
		, @Transform_Script_Attribute_12_Modified_Yn
		, @Transform_Script_Attribute_13_Yesterday
		, @Transform_Script_Attribute_13_Today
		, @Transform_Script_Attribute_13_Modified_Yn
		, @Transform_Script_Attribute_14_Yesterday
		, @Transform_Script_Attribute_14_Today
		, @Transform_Script_Attribute_14_Modified_Yn
		, @Transform_Script_Attribute_15_Yesterday
		, @Transform_Script_Attribute_15_Today
		, @Transform_Script_Attribute_15_Modified_Yn
		, @Transform_Script_Attribute_16_Yesterday 
		, @Transform_Script_Attribute_16_Today
		, @Transform_Script_Attribute_16_Modified_Yn
		, @Transform_Script_Attribute_17_Yesterday
		, @Transform_Script_Attribute_17_Today
		, @Transform_Script_Attribute_17_Modified_Yn
		, @Transform_Script_Attribute_18_Yesterday
		, @Transform_Script_Attribute_18_Today
		, @Transform_Script_Attribute_18_Modified_Yn
		, @Transform_Script_Attribute_19_Yesterday
		, @Transform_Script_Attribute_19_Today
		, @Transform_Script_Attribute_19_Modified_Yn
		, @Transform_Script_Attribute_20_Yesterday
		, @Transform_Script_Attribute_20_Today
		, @Transform_Script_Attribute_20_Modified_Yn
		, NULL
		, NULL
		, NULL
		, NULL
		)
		
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Dim_Object_Yesterday = Transform_Script_Dim_Object_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Dim_Object_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Dim_Object_Yesterday
							, Transform_Script_Dim_Object_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Dim_Object_Modified_Yn = S.Transform_Script_Dim_Object_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Table_Name_Yesterday = Transform_Script_Table_Name_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Table_Name_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Table_Name_Yesterday
							, Transform_Script_Table_Name_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Table_Name_Modified_Yn = S.Transform_Script_Table_Name_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Create_Fields_Yesterday = Transform_Script_Create_Fields_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Create_Fields_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Create_Fields_Yesterday
							, Transform_Script_Create_Fields_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Create_Fields_Modified_Yn = S.Transform_Script_Create_Fields_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Insert_Fields_Yesterday = Transform_Script_Insert_Fields_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Insert_Fields_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Insert_Fields_Yesterday
							, Transform_Script_Insert_Fields_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Insert_Fields_Modified_Yn = S.Transform_Script_Insert_Fields_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_From_Statement_Yesterday = Transform_Script_From_Statement_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_From_Statement_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_From_Statement_Yesterday
							, Transform_Script_From_Statement_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_From_Statement_Modified_Yn = S.Transform_Script_From_Statement_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Where_Statement_Yesterday = Transform_Script_Where_Statement_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Where_Statement_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Where_Statement_Yesterday
							, Transform_Script_Where_Statement_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Where_Statement_Modified_Yn = S.Transform_Script_Where_Statement_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_1_Yesterday = Transform_Script_Attribute_1_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_1_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_1_Yesterday
							, Transform_Script_Attribute_1_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_1_Modified_Yn = S.Transform_Script_Attribute_1_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_2_Yesterday = Transform_Script_Attribute_2_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_2_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_2_Yesterday
							, Transform_Script_Attribute_2_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_2_Modified_Yn = S.Transform_Script_Attribute_2_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_3_Yesterday = Transform_Script_Attribute_3_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_3_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_3_Yesterday
							, Transform_Script_Attribute_3_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_3_Modified_Yn = S.Transform_Script_Attribute_3_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_4_Yesterday = Transform_Script_Attribute_4_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_4_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_4_Yesterday
							, Transform_Script_Attribute_4_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_4_Modified_Yn = S.Transform_Script_Attribute_4_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_5_Yesterday = Transform_Script_Attribute_5_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_5_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_5_Yesterday
							, Transform_Script_Attribute_5_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_5_Modified_Yn = S.Transform_Script_Attribute_5_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_6_Yesterday = Transform_Script_Attribute_6_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_6_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_6_Yesterday
							, Transform_Script_Attribute_6_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_6_Modified_Yn = S.Transform_Script_Attribute_6_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_7_Yesterday = Transform_Script_Attribute_7_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_7_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_7_Yesterday
							, Transform_Script_Attribute_7_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_7_Modified_Yn = S.Transform_Script_Attribute_7_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_8_Yesterday = Transform_Script_Attribute_8_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_8_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_8_Yesterday
							, Transform_Script_Attribute_8_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_8_Modified_Yn = S.Transform_Script_Attribute_8_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_9_Yesterday = Transform_Script_Attribute_9_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_9_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_9_Yesterday
							, Transform_Script_Attribute_9_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_9_Modified_Yn = S.Transform_Script_Attribute_9_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_10_Yesterday = Transform_Script_Attribute_10_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_10_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_10_Yesterday
							, Transform_Script_Attribute_10_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_10_Modified_Yn = S.Transform_Script_Attribute_10_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_11_Yesterday = Transform_Script_Attribute_11_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_11_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_11_Yesterday
							, Transform_Script_Attribute_11_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_11_Modified_Yn = S.Transform_Script_Attribute_11_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_12_Yesterday = Transform_Script_Attribute_12_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_12_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_12_Yesterday
							, Transform_Script_Attribute_12_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_12_Modified_Yn = S.Transform_Script_Attribute_12_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_13_Yesterday = Transform_Script_Attribute_13_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_13_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_13_Yesterday
							, Transform_Script_Attribute_13_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_13_Modified_Yn = S.Transform_Script_Attribute_13_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_14_Yesterday = Transform_Script_Attribute_14_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_14_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_14_Yesterday
							, Transform_Script_Attribute_14_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_14_Modified_Yn = S.Transform_Script_Attribute_14_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_15_Yesterday = Transform_Script_Attribute_15_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_15_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_15_Yesterday
							, Transform_Script_Attribute_15_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_15_Modified_Yn = S.Transform_Script_Attribute_15_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_16_Yesterday = Transform_Script_Attribute_16_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_16_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_16_Yesterday
							, Transform_Script_Attribute_16_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_16_Modified_Yn = S.Transform_Script_Attribute_16_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_17_Yesterday = Transform_Script_Attribute_17_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_17_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_17_Yesterday
							, Transform_Script_Attribute_17_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_17_Modified_Yn = S.Transform_Script_Attribute_17_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_18_Yesterday = Transform_Script_Attribute_18_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_18_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_18_Yesterday
							, Transform_Script_Attribute_18_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_18_Modified_Yn = S.Transform_Script_Attribute_18_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_19_Yesterday = Transform_Script_Attribute_19_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_19_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_19_Yesterday
							, Transform_Script_Attribute_19_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_19_Modified_Yn = S.Transform_Script_Attribute_19_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, CASE WHEN Transform_Script_Attribute_20_Yesterday = Transform_Script_Attribute_20_Today THEN 'N'
						ELSE 'Y' END AS Transform_Script_Attribute_20_Modified_Yn
					FROM
						(SELECT Transform_Data_Key
							, Transform_Script_Attribute_20_Yesterday
							, Transform_Script_Attribute_20_Today
							FROM Transform_Data
							WHERE 1 = 1
								 AND Transform_Data_Key IN
									(
										SELECT MAX(Transform_Data_Key) AS Transform_Data_Key
											FROM 
												(
													SELECT Transform_Data_Key
														, MAX(Transform_DateTime) AS Transform_DateTime
														FROM Transform_Data
														WHERE 1 = 1
															AND Transform_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Transform_Data_Key
												) A
									)	
						) A						
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Script_Attribute_20_Modified_Yn = S.Transform_Script_Attribute_20_Modified_Yn
			;
	MERGE INTO Transform_Data T
		USING (			
				SELECT Transform_Data_Key
					, Transform_Table_Count_Lag
					, Transform_Duration_Lag
					, CASE WHEN Transform_Duration > 0 THEN
						Transform_Table_Count/Transform_Duration 
						ELSE 0 END AS Records_Per_Seconds 
					, CASE WHEN Transform_Table_Count_Lag > 0 THEN
						CONVERT(DECIMAL(12,4),ROUND(((CONVERT(DECIMAL(12,4),Transform_Table_Count) - CONVERT(DECIMAL(12,4),Transform_Table_Count_Lag)) / CONVERT(DECIMAL(12,4),Transform_Table_Count_Lag)) * 100,4)) 
						ELSE 0 END AS Table_Count_Percent_Increase
					FROM
						(SELECT Transform_Data_Key
							, Transform_DateTime
							, Transform_Table_Name
							, Transform_Table_Count
							, Transform_Duration
							, Lag(Transform_Table_Count) OVER(PARTITION BY Transform_Table_Name ORDER BY Transform_DateTime) AS Transform_Table_Count_Lag
							, Lag(Transform_Duration) OVER(PARTITION BY Transform_Table_Name ORDER BY Transform_DateTime) AS Transform_Duration_Lag
							FROM Transform_Data
						) A
				) S ON T.Transform_Data_Key = S.Transform_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Transform_Table_Count_Lag = S.Transform_Table_Count_Lag
				, T.Transform_Duration_Lag = S.Transform_Duration_Lag
				, T.Records_Per_Seconds = S.Records_Per_Seconds
				, T.Table_Count_Percent_Increase = S.Table_Count_Percent_Increase
			;

END