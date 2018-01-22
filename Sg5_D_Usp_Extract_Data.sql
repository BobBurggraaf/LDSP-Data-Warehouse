/*************************************************************
	NAME: usp_Extract_Data 
	PURPOSE: Log the script and performance
	PLATFORM: Sql Server Management Studio

	REVISIONS:
	Ver        Date        Author           Description
	---------  ----------  ---------------  ------------------------------------
	1.0        11/09/2017  Fams             1. Development of the initial script

**************************************************************/


USE [OneAccord_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_Extract_Data]    Script Date: 11/9/2017 9:33:10 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


--CREATE PROCEDURE [dbo].[usp_Extract_Data]
ALTER PROCEDURE [dbo].[usp_Extract_Data]

	@Extract_Data_Table_Name NVARCHAR(100) = NULL

AS

BEGIN


	--DROP TABLE IF EXISTS Extract_Data;
	IF NOT EXISTS (SELECT * FROM SysObjects WHERE 1 = 1 AND Name = 'Extract_Data' AND XType = 'U')
	CREATE TABLE Extract_Data (
		Extract_Data_Key INT IDENTITY(10000,1) PRIMARY KEY
		, Extract_DateTime DATETIME
		, Extract_Table_Id INT
		, Extract_Table_Name NVARCHAR(100)
		, Extract_Table_Count INT
		, Extract_Duration INT 
		, Extract_Script_Dim_Object_Yesterday NVARCHAR(MAX)
		, Extract_Script_Dim_Object_Today NVARCHAR(MAX)
		, Extract_Script_Dim_Object_Modified_Yn NVARCHAR(1)
		, Extract_Script_Table_Name_Yesterday NVARCHAR(MAX)
		, Extract_Script_Table_Name_Today NVARCHAR(MAX)
		, Extract_Script_Table_Name_Modified_Yn NVARCHAR(1)
		, Extract_Script_Create_Fields_Yesterday NVARCHAR(MAX)
		, Extract_Script_Create_Fields_Today NVARCHAR(MAX)
		, Extract_Script_Create_Fields_Modified_Yn NVARCHAR(1)
		, Extract_Script_Insert_Fields_Yesterday NVARCHAR(MAX)
		, Extract_Script_Insert_Fields_Today NVARCHAR(MAX)
		, Extract_Script_Insert_Fields_Modified_Yn NVARCHAR(1)
		, Extract_Script_From_Statement_Yesterday NVARCHAR(MAX)
		, Extract_Script_From_Statement_Today NVARCHAR(MAX)
		, Extract_Script_From_Statement_Modified_Yn NVARCHAR(1)
		, Extract_Script_Where_Statement_Yesterday NVARCHAR(MAX)
		, Extract_Script_Where_Statement_Today NVARCHAR(MAX)
		, Extract_Script_Where_Statement_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_1_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_1_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_1_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_2_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_2_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_2_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_3_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_3_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_3_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_4_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_4_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_4_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_5_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_5_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_5_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_6_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_6_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_6_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_7_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_7_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_7_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_8_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_8_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_8_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_9_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_9_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_9_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_10_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_10_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_10_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_11_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_11_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_11_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_12_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_12_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_12_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_13_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_13_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_13_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_14_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_14_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_14_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_15_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_15_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_15_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_16_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_16_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_16_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_17_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_17_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_17_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_18_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_18_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_18_Modified_Yn NVARCHAR(1)
		, Extract_Script_Attribute_19_Yesterday NVARCHAR(MAX)
		, Extract_Script_Attribute_19_Today NVARCHAR(MAX)
		, Extract_Script_Attribute_19_Modified_Yn NVARCHAR(1)
		, Extract_Table_Count_Lag INT
		, Extract_Duration_Lag INT
		, Records_Per_Seconds INT
		, Table_Count_Percent_Increase DECIMAL(12,4)
	)

	DECLARE @Extract_DateTime DATETIME
	DECLARE @Extract_Table_Id INT
	DECLARE @Extract_Table_Name NVARCHAR(100)
	DECLARE @Extract_Table_Count INT
	DECLARE @Extract_Duration INT
	DECLARE @Extract_Script_Dim_Object_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Dim_Object_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Dim_Object_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Table_Name_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Table_Name_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Table_Name_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Create_Fields_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Create_Fields_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Create_Fields_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Insert_Fields_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Insert_Fields_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Insert_Fields_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_From_Statement_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_From_Statement_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_From_Statement_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Where_Statement_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Where_Statement_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Where_Statement_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_1_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_1_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_1_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_2_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_2_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_2_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_3_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_3_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_3_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_4_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_4_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_4_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_5_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_5_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_5_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_6_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_6_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_6_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_7_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_7_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_7_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_8_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_8_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_8_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_9_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_9_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_9_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_10_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_10_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_10_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_11_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_11_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_11_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_12_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_12_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_12_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_13_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_13_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_13_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_14_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_14_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_14_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_15_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_15_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_15_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_16_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_16_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_16_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_17_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_17_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_17_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_18_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_18_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_18_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Script_Attribute_19_Yesterday NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_19_Today NVARCHAR(MAX)
	DECLARE @Extract_Script_Attribute_19_Modified_Yn NVARCHAR(1)
	DECLARE @Extract_Table_Count_Lag INT
	DECLARE @Extract_Duration_Lag INT
	DECLARE @Records_Per_Seconds INT
	DECLARE @Table_Count_Percent_Increase DECIMAL(12,4)

	DECLARE @Alpha_Stage_Table_Name NVARCHAR(100)
	SET @Alpha_Stage_Table_Name = @Extract_Data_Table_Name

	SET @Extract_DateTime = (SELECT MAX(Alpha_DateTime) AS Alpha_DateTime FROM Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name)
	SET @Extract_Table_Id = (SELECT Extract_Table_Id FROM Extract_Tables WHERE 1 = 1 AND Extract_Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Table_Name = @Alpha_Stage_Table_Name
	SET @Extract_Table_Count = (SELECT Alpha_Count FROM Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name AND Alpha_Step_Name = 'Stats')
	SET @Extract_Duration = (SELECT Alpha_Duration_In_Seconds FROM Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = @Alpha_Stage_Table_Name AND Alpha_Step_Name = 'Stats')
	SET @Extract_Script_Dim_Object_Yesterday = (SELECT Extract_Script_Dim_Object_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Dim_Object_Today = (SELECT Dim_Object FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Dim_Object_Modified_Yn = 'N'
	SET @Extract_Script_Table_Name_Yesterday = (SELECT Extract_Script_Table_Name_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Table_Name_Today = (SELECT Table_Name FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Table_Name_Modified_Yn = 'N'
	SET @Extract_Script_Create_Fields_Yesterday = (SELECT Extract_Script_Create_Fields_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Create_Fields_Today = (SELECT Create_Fields FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Create_Fields_Modified_Yn = 'N'
	SET @Extract_Script_Insert_Fields_Yesterday = (SELECT Extract_Script_Insert_Fields_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Insert_Fields_Today = (SELECT Insert_Fields FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Insert_Fields_Modified_Yn = 'N'
	SET @Extract_Script_From_Statement_Yesterday = (SELECT Extract_Script_From_Statement_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_From_Statement_Today = (SELECT From_Statement FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_From_Statement_Modified_Yn = 'N'
	SET @Extract_Script_Where_Statement_Yesterday = (SELECT Extract_Script_Where_Statement_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Where_Statement_Today = (SELECT Where_Statement FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Where_Statement_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_1_Yesterday = (SELECT Extract_Script_Attribute_1_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_1_Today = (SELECT Attribute_1 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_1_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_2_Yesterday = (SELECT Extract_Script_Attribute_2_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_2_Today = (SELECT Attribute_2 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_2_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_3_Yesterday = (SELECT Extract_Script_Attribute_3_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_3_Today = (SELECT Attribute_3 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_3_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_4_Yesterday = (SELECT Extract_Script_Attribute_4_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_4_Today = (SELECT Attribute_4 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_4_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_5_Yesterday = (SELECT Extract_Script_Attribute_5_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_5_Today = (SELECT Attribute_5 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_5_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_6_Yesterday = (SELECT Extract_Script_Attribute_6_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_6_Today = (SELECT Attribute_6 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_6_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_7_Yesterday = (SELECT Extract_Script_Attribute_7_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_7_Today = (SELECT Attribute_7 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_7_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_8_Yesterday = (SELECT Extract_Script_Attribute_8_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_8_Today = (SELECT Attribute_8 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_8_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_9_Yesterday = (SELECT Extract_Script_Attribute_9_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_9_Today = (SELECT Attribute_9 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_9_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_10_Yesterday = (SELECT Extract_Script_Attribute_10_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_10_Today = (SELECT Attribute_10 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_10_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_11_Yesterday = (SELECT Extract_Script_Attribute_11_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_11_Today = (SELECT Attribute_11 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_11_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_12_Yesterday = (SELECT Extract_Script_Attribute_12_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_12_Today = (SELECT Attribute_12 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_12_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_13_Yesterday = (SELECT Extract_Script_Attribute_13_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_13_Today = (SELECT Attribute_13 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_13_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_14_Yesterday = (SELECT Extract_Script_Attribute_14_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_14_Today = (SELECT Attribute_14 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_14_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_15_Yesterday = (SELECT Extract_Script_Attribute_15_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_15_Today = (SELECT Attribute_15 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_15_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_16_Yesterday = (SELECT Extract_Script_Attribute_16_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_16_Today = (SELECT Attribute_16 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_16_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_17_Yesterday = (SELECT Extract_Script_Attribute_17_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_17_Today = (SELECT Attribute_17 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_17_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_18_Yesterday = (SELECT Extract_Script_Attribute_18_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_18_Today = (SELECT Attribute_18 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_18_Modified_Yn = 'N'
	SET @Extract_Script_Attribute_19_Yesterday = (SELECT Extract_Script_Attribute_19_Today 
													FROM Extract_Data
													WHERE 1 = 1
															AND Extract_Data_Key IN
															(
																SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
																	FROM 
																		(
																			SELECT Extract_Data_Key
																				, MAX(Extract_DateTime) AS Extract_DateTime
																				FROM Extract_Data
																				WHERE 1 = 1
																					AND Extract_Table_Name = @Alpha_Stage_Table_Name
																				GROUP BY Extract_Data_Key
																		) A
															)		
												)
	SET @Extract_Script_Attribute_19_Today = (SELECT Attribute_19 FROM Create_Extract_Tables WHERE 1 = 1 AND Table_Name = @Alpha_Stage_Table_Name)
	SET @Extract_Script_Attribute_19_Modified_Yn = 'N'

	INSERT INTO Extract_Data (
		Extract_DateTime
		, Extract_Table_Id 
		, Extract_Table_Name
		, Extract_Table_Count
		, Extract_Duration 
		, Extract_Script_Dim_Object_Yesterday
		, Extract_Script_Dim_Object_Today
		, Extract_Script_Dim_Object_Modified_Yn
		, Extract_Script_Table_Name_Yesterday
		, Extract_Script_Table_Name_Today
		, Extract_Script_Table_Name_Modified_Yn
		, Extract_Script_Create_Fields_Yesterday
		, Extract_Script_Create_Fields_Today
		, Extract_Script_Create_Fields_Modified_Yn
		, Extract_Script_Insert_Fields_Yesterday
		, Extract_Script_Insert_Fields_Today
		, Extract_Script_Insert_Fields_Modified_Yn
		, Extract_Script_From_Statement_Yesterday
		, Extract_Script_From_Statement_Today
		, Extract_Script_From_Statement_Modified_Yn
		, Extract_Script_Where_Statement_Yesterday
		, Extract_Script_Where_Statement_Today
		, Extract_Script_Where_Statement_Modified_Yn
		, Extract_Script_Attribute_1_Yesterday
		, Extract_Script_Attribute_1_Today
		, Extract_Script_Attribute_1_Modified_Yn
		, Extract_Script_Attribute_2_Yesterday
		, Extract_Script_Attribute_2_Today
		, Extract_Script_Attribute_2_Modified_Yn
		, Extract_Script_Attribute_3_Yesterday
		, Extract_Script_Attribute_3_Today
		, Extract_Script_Attribute_3_Modified_Yn
		, Extract_Script_Attribute_4_Yesterday
		, Extract_Script_Attribute_4_Today
		, Extract_Script_Attribute_4_Modified_Yn
		, Extract_Script_Attribute_5_Yesterday
		, Extract_Script_Attribute_5_Today
		, Extract_Script_Attribute_5_Modified_Yn
		, Extract_Script_Attribute_6_Yesterday
		, Extract_Script_Attribute_6_Today
		, Extract_Script_Attribute_6_Modified_Yn
		, Extract_Script_Attribute_7_Yesterday
		, Extract_Script_Attribute_7_Today
		, Extract_Script_Attribute_7_Modified_Yn
		, Extract_Script_Attribute_8_Yesterday
		, Extract_Script_Attribute_8_Today
		, Extract_Script_Attribute_8_Modified_Yn
		, Extract_Script_Attribute_9_Yesterday
		, Extract_Script_Attribute_9_Today
		, Extract_Script_Attribute_9_Modified_Yn
		, Extract_Script_Attribute_10_Yesterday
		, Extract_Script_Attribute_10_Today
		, Extract_Script_Attribute_10_Modified_Yn
		, Extract_Script_Attribute_11_Yesterday
		, Extract_Script_Attribute_11_Today
		, Extract_Script_Attribute_11_Modified_Yn
		, Extract_Script_Attribute_12_Yesterday
		, Extract_Script_Attribute_12_Today
		, Extract_Script_Attribute_12_Modified_Yn
		, Extract_Script_Attribute_13_Yesterday
		, Extract_Script_Attribute_13_Today
		, Extract_Script_Attribute_13_Modified_Yn
		, Extract_Script_Attribute_14_Yesterday
		, Extract_Script_Attribute_14_Today
		, Extract_Script_Attribute_14_Modified_Yn
		, Extract_Script_Attribute_15_Yesterday
		, Extract_Script_Attribute_15_Today
		, Extract_Script_Attribute_15_Modified_Yn
		, Extract_Script_Attribute_16_Yesterday 
		, Extract_Script_Attribute_16_Today
		, Extract_Script_Attribute_16_Modified_Yn
		, Extract_Script_Attribute_17_Yesterday
		, Extract_Script_Attribute_17_Today
		, Extract_Script_Attribute_17_Modified_Yn
		, Extract_Script_Attribute_18_Yesterday
		, Extract_Script_Attribute_18_Today
		, Extract_Script_Attribute_18_Modified_Yn
		, Extract_Script_Attribute_19_Yesterday
		, Extract_Script_Attribute_19_Today
		, Extract_Script_Attribute_19_Modified_Yn
		, Extract_Table_Count_Lag 
		, Extract_Duration_Lag
		, Records_Per_Seconds
		, Table_Count_Percent_Increase
	)
	VALUES
		(@Extract_DateTime
		, @Extract_Table_Id 
		, @Extract_Table_Name
		, @Extract_Table_Count
		, @Extract_Duration 
		, @Extract_Script_Dim_Object_Yesterday
		, @Extract_Script_Dim_Object_Today
		, @Extract_Script_Dim_Object_Modified_Yn
		, @Extract_Script_Table_Name_Yesterday
		, @Extract_Script_Table_Name_Today
		, @Extract_Script_Table_Name_Modified_Yn
		, @Extract_Script_Create_Fields_Yesterday
		, @Extract_Script_Create_Fields_Today
		, @Extract_Script_Create_Fields_Modified_Yn
		, @Extract_Script_Insert_Fields_Yesterday
		, @Extract_Script_Insert_Fields_Today
		, @Extract_Script_Insert_Fields_Modified_Yn
		, @Extract_Script_From_Statement_Yesterday
		, @Extract_Script_From_Statement_Today
		, @Extract_Script_From_Statement_Modified_Yn
		, @Extract_Script_Where_Statement_Yesterday
		, @Extract_Script_Where_Statement_Today
		, @Extract_Script_Where_Statement_Modified_Yn
		, @Extract_Script_Attribute_1_Yesterday
		, @Extract_Script_Attribute_1_Today
		, @Extract_Script_Attribute_1_Modified_Yn
		, @Extract_Script_Attribute_2_Yesterday
		, @Extract_Script_Attribute_2_Today
		, @Extract_Script_Attribute_2_Modified_Yn
		, @Extract_Script_Attribute_3_Yesterday
		, @Extract_Script_Attribute_3_Today
		, @Extract_Script_Attribute_3_Modified_Yn
		, @Extract_Script_Attribute_4_Yesterday
		, @Extract_Script_Attribute_4_Today
		, @Extract_Script_Attribute_4_Modified_Yn
		, @Extract_Script_Attribute_5_Yesterday
		, @Extract_Script_Attribute_5_Today
		, @Extract_Script_Attribute_5_Modified_Yn
		, @Extract_Script_Attribute_6_Yesterday
		, @Extract_Script_Attribute_6_Today
		, @Extract_Script_Attribute_6_Modified_Yn
		, @Extract_Script_Attribute_7_Yesterday
		, @Extract_Script_Attribute_7_Today
		, @Extract_Script_Attribute_7_Modified_Yn
		, @Extract_Script_Attribute_8_Yesterday
		, @Extract_Script_Attribute_8_Today
		, @Extract_Script_Attribute_8_Modified_Yn
		, @Extract_Script_Attribute_9_Yesterday
		, @Extract_Script_Attribute_9_Today
		, @Extract_Script_Attribute_9_Modified_Yn
		, @Extract_Script_Attribute_10_Yesterday
		, @Extract_Script_Attribute_10_Today
		, @Extract_Script_Attribute_10_Modified_Yn
		, @Extract_Script_Attribute_11_Yesterday
		, @Extract_Script_Attribute_11_Today
		, @Extract_Script_Attribute_11_Modified_Yn
		, @Extract_Script_Attribute_12_Yesterday
		, @Extract_Script_Attribute_12_Today
		, @Extract_Script_Attribute_12_Modified_Yn
		, @Extract_Script_Attribute_13_Yesterday
		, @Extract_Script_Attribute_13_Today
		, @Extract_Script_Attribute_13_Modified_Yn
		, @Extract_Script_Attribute_14_Yesterday
		, @Extract_Script_Attribute_14_Today
		, @Extract_Script_Attribute_14_Modified_Yn
		, @Extract_Script_Attribute_15_Yesterday
		, @Extract_Script_Attribute_15_Today
		, @Extract_Script_Attribute_15_Modified_Yn
		, @Extract_Script_Attribute_16_Yesterday 
		, @Extract_Script_Attribute_16_Today
		, @Extract_Script_Attribute_16_Modified_Yn
		, @Extract_Script_Attribute_17_Yesterday
		, @Extract_Script_Attribute_17_Today
		, @Extract_Script_Attribute_17_Modified_Yn
		, @Extract_Script_Attribute_18_Yesterday
		, @Extract_Script_Attribute_18_Today
		, @Extract_Script_Attribute_18_Modified_Yn
		, @Extract_Script_Attribute_19_Yesterday
		, @Extract_Script_Attribute_19_Today
		, @Extract_Script_Attribute_19_Modified_Yn
		, NULL
		, NULL
		, NULL
		, NULL
		)
		
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Dim_Object_Yesterday = Extract_Script_Dim_Object_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Dim_Object_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Dim_Object_Yesterday
							, Extract_Script_Dim_Object_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Dim_Object_Modified_Yn = S.Extract_Script_Dim_Object_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Table_Name_Yesterday = Extract_Script_Table_Name_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Table_Name_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Table_Name_Yesterday
							, Extract_Script_Table_Name_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Table_Name_Modified_Yn = S.Extract_Script_Table_Name_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Create_Fields_Yesterday = Extract_Script_Create_Fields_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Create_Fields_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Create_Fields_Yesterday
							, Extract_Script_Create_Fields_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Create_Fields_Modified_Yn = S.Extract_Script_Create_Fields_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Insert_Fields_Yesterday = Extract_Script_Insert_Fields_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Insert_Fields_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Insert_Fields_Yesterday
							, Extract_Script_Insert_Fields_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Insert_Fields_Modified_Yn = S.Extract_Script_Insert_Fields_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_From_Statement_Yesterday = Extract_Script_From_Statement_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_From_Statement_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_From_Statement_Yesterday
							, Extract_Script_From_Statement_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_From_Statement_Modified_Yn = S.Extract_Script_From_Statement_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Where_Statement_Yesterday = Extract_Script_Where_Statement_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Where_Statement_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Where_Statement_Yesterday
							, Extract_Script_Where_Statement_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Where_Statement_Modified_Yn = S.Extract_Script_Where_Statement_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_1_Yesterday = Extract_Script_Attribute_1_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_1_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_1_Yesterday
							, Extract_Script_Attribute_1_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_1_Modified_Yn = S.Extract_Script_Attribute_1_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_2_Yesterday = Extract_Script_Attribute_2_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_2_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_2_Yesterday
							, Extract_Script_Attribute_2_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_2_Modified_Yn = S.Extract_Script_Attribute_2_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_3_Yesterday = Extract_Script_Attribute_3_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_3_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_3_Yesterday
							, Extract_Script_Attribute_3_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_3_Modified_Yn = S.Extract_Script_Attribute_3_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_4_Yesterday = Extract_Script_Attribute_4_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_4_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_4_Yesterday
							, Extract_Script_Attribute_4_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_4_Modified_Yn = S.Extract_Script_Attribute_4_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_5_Yesterday = Extract_Script_Attribute_5_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_5_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_5_Yesterday
							, Extract_Script_Attribute_5_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_5_Modified_Yn = S.Extract_Script_Attribute_5_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_6_Yesterday = Extract_Script_Attribute_6_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_6_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_6_Yesterday
							, Extract_Script_Attribute_6_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_6_Modified_Yn = S.Extract_Script_Attribute_6_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_7_Yesterday = Extract_Script_Attribute_7_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_7_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_7_Yesterday
							, Extract_Script_Attribute_7_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_7_Modified_Yn = S.Extract_Script_Attribute_7_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_8_Yesterday = Extract_Script_Attribute_8_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_8_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_8_Yesterday
							, Extract_Script_Attribute_8_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_8_Modified_Yn = S.Extract_Script_Attribute_8_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_9_Yesterday = Extract_Script_Attribute_9_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_9_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_9_Yesterday
							, Extract_Script_Attribute_9_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_9_Modified_Yn = S.Extract_Script_Attribute_9_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_10_Yesterday = Extract_Script_Attribute_10_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_10_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_10_Yesterday
							, Extract_Script_Attribute_10_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_10_Modified_Yn = S.Extract_Script_Attribute_10_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_11_Yesterday = Extract_Script_Attribute_11_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_11_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_11_Yesterday
							, Extract_Script_Attribute_11_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_11_Modified_Yn = S.Extract_Script_Attribute_11_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_12_Yesterday = Extract_Script_Attribute_12_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_12_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_12_Yesterday
							, Extract_Script_Attribute_12_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_12_Modified_Yn = S.Extract_Script_Attribute_12_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_13_Yesterday = Extract_Script_Attribute_13_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_13_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_13_Yesterday
							, Extract_Script_Attribute_13_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_13_Modified_Yn = S.Extract_Script_Attribute_13_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_14_Yesterday = Extract_Script_Attribute_14_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_14_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_14_Yesterday
							, Extract_Script_Attribute_14_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_14_Modified_Yn = S.Extract_Script_Attribute_14_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_15_Yesterday = Extract_Script_Attribute_15_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_15_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_15_Yesterday
							, Extract_Script_Attribute_15_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_15_Modified_Yn = S.Extract_Script_Attribute_15_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_16_Yesterday = Extract_Script_Attribute_16_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_16_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_16_Yesterday
							, Extract_Script_Attribute_16_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_16_Modified_Yn = S.Extract_Script_Attribute_16_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_17_Yesterday = Extract_Script_Attribute_17_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_17_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_17_Yesterday
							, Extract_Script_Attribute_17_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_17_Modified_Yn = S.Extract_Script_Attribute_17_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_18_Yesterday = Extract_Script_Attribute_18_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_18_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_18_Yesterday
							, Extract_Script_Attribute_18_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_18_Modified_Yn = S.Extract_Script_Attribute_18_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, CASE WHEN Extract_Script_Attribute_19_Yesterday = Extract_Script_Attribute_19_Today THEN 'N'
						ELSE 'Y' END AS Extract_Script_Attribute_19_Modified_Yn
					FROM
						(SELECT Extract_Data_Key
							, Extract_Script_Attribute_19_Yesterday
							, Extract_Script_Attribute_19_Today
							FROM Extract_Data
							WHERE 1 = 1
								 AND Extract_Data_Key IN
									(
										SELECT MAX(Extract_Data_Key) AS Extract_Data_Key
											FROM 
												(
													SELECT Extract_Data_Key
														, MAX(Extract_DateTime) AS Extract_DateTime
														FROM Extract_Data
														WHERE 1 = 1
															AND Extract_Table_Name = @Alpha_Stage_Table_Name
														GROUP BY Extract_Data_Key
												) A
									)	
						) A						
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Script_Attribute_19_Modified_Yn = S.Extract_Script_Attribute_19_Modified_Yn
			;
	MERGE INTO Extract_Data T
		USING (			
				SELECT Extract_Data_Key
					, Extract_Table_Count_Lag
					, Extract_Duration_Lag
					, CASE WHEN Extract_Duration > 0 THEN
						Extract_Table_Count/Extract_Duration 
						ELSE 0 END AS Records_Per_Seconds 
					, CASE WHEN Extract_Table_Count_Lag > 0 THEN
						CONVERT(DECIMAL(12,4),ROUND(((CONVERT(DECIMAL(12,4),Extract_Table_Count) - CONVERT(DECIMAL(12,4),Extract_Table_Count_Lag)) / CONVERT(DECIMAL(12,4),Extract_Table_Count_Lag)) * 100,4)) 
						ELSE 0 END AS Table_Count_Percent_Increase
					FROM
						(SELECT Extract_Data_Key
							, Extract_DateTime
							, Extract_Table_Name
							, Extract_Table_Count
							, Extract_Duration
							, Lag(Extract_Table_Count) OVER(PARTITION BY Extract_Table_Name ORDER BY Extract_DateTime) AS Extract_Table_Count_Lag
							, Lag(Extract_Duration) OVER(PARTITION BY Extract_Table_Name ORDER BY Extract_DateTime) AS Extract_Duration_Lag
							FROM Extract_Data
						) A
				) S ON T.Extract_Data_Key = S.Extract_Data_Key
		WHEN MATCHED THEN 
			UPDATE
				SET T.Extract_Table_Count_Lag = S.Extract_Table_Count_Lag
				, T.Extract_Duration_Lag = S.Extract_Duration_Lag
				, T.Records_Per_Seconds = S.Records_Per_Seconds
				, T.Table_Count_Percent_Increase = S.Table_Count_Percent_Increase
			;
			
END