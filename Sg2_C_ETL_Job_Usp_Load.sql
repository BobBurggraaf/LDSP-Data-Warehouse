/****************************************************

	Name: usp_Ldsp_Trans_Load_Prod
	Date: 01/20/2018
	
	**This is installed on the Production server.

****************************************************/


USE [OneAccord_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_Ldsp_Trans_Load_Prod]    Script Date: 12/2/2016 8:12:58 AM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[usp_Ldsp_Trans_Load_Prod] 
AS
BEGIN

-- --------------------------
-- ALPHA_3
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Alpha_Table_3','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Alpha_Table_3;


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


EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = 'Script Start', @Alpha_Step_Number = '0', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;


DECLARE @Todays_Date DATE
	SET @Todays_Date = GETDATE()

	DECLARE @Table_Name_Check NVARCHAR(100)
	SET @Table_Name_Check = 'View_Liaison_Initiative'
	
	DECLARE @Step_Date DATE
		SELECT @Step_Date = (
			SELECT Alpha_DateTime
				FROM [MSSQL12336\S01].OneAccord_Warehouse.dbo.Alpha_Table_2
				WHERE 1 = 1
					AND Alpha_Step_Name = 'Stats'
					AND Alpha_Stage = @Table_Name_Check				
		)

		
IF @Step_Date = @Todays_Date
	BEGIN

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
	END

	
IF @Step_Date != @Todays_Date OR @Step_Date IS NULL
	BEGIN
	
		DECLARE @Wait_Time NVARCHAR(10)
		SET @Wait_Time = '01:00:00'

		WAITFOR DELAY @Wait_Time
		
	
		DECLARE @Todays_Date_2 DATE
		SET @Todays_Date_2 = GETDATE()

		DECLARE @Table_Name_Check_2 NVARCHAR(100)
		SET @Table_Name_Check_2 = 'View_Liaison_Initiative'
		
		DECLARE @Step_Date_2 DATE
			SELECT @Step_Date_2 = (
				SELECT Alpha_DateTime
					FROM [MSSQL12336\S01].OneAccord_Warehouse.dbo.Alpha_Table_2
					WHERE 1 = 1
						AND Alpha_Step_Name = 'Stats'
						AND Alpha_Stage = @Table_Name_Check_2				
			)
			
			
		IF @Step_Date_2 = @Todays_Date_2
			BEGIN

				DECLARE @Main_Total_Loop_Num_2 INT
					SELECT @Main_Total_Loop_Num_2 = (
						SELECT MAX(Fields_Key) AS Max_Field
								FROM CREATE_TRANS_LOAD_TABLES
								WHERE 1 = 1
									AND Active = 1
								
						)
				DECLARE @Main_LOOP_NUM_2 INT
				SET @Main_LOOP_NUM_2 = 1
				WHILE  @Main_LOOP_NUM_2 <= @Main_Total_Loop_Num_2 
					BEGIN
					
						DECLARE @IsActive_2 INT
						SELECT @IsActive_2 = (
							SELECT Active 
								FROM CREATE_TRANS_LOAD_TABLES
								WHERE 1 = 1
									AND Fields_Key = @Main_LOOP_NUM_2
							)
							
						DECLARE @Table_Name_By_Loop_2 NVARCHAR(200)
						SELECT @Table_Name_By_Loop_2 = (
							SELECT Table_Name
								FROM CREATE_TRANS_LOAD_TABLES
								WHERE 1 = 1
									AND Fields_Key = @Main_LOOP_NUM_2
							)
							
						IF @IsActive_2 = 1
							BEGIN	
					
								BEGIN TRY
								
								-- -----------------------------
								-- Create Table
								-- -----------------------------
								
									DECLARE @TABLE_NAME_2 VARCHAR(100)
									DECLARE @CREATE_FIELDS_2 VARCHAR(MAX)
									DECLARE @INSERT_FIELDS_2 VARCHAR(MAX)
									DECLARE @SQL_1_2 VARCHAR(MAX)
									DECLARE @SQL_2_2 VARCHAR(MAX)

									SELECT @TABLE_NAME_2 = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_2);
									SELECT @CREATE_FIELDS_2 = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_2);
									SELECT @INSERT_FIELDS_2 = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_2);

									EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

									SET @SQL_2_2 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + ''', ''U'' '
									SET @SQL_1_2 = '
										IF OBJECT_ID(' + @SQL_2_2 + ') IS NOT NULL
										DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + '
										
										CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + '(' + @CREATE_FIELDS_2 + ')'
									
									EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1_2, @Alpha_Result = 1;
									
									EXEC(@SQL_1_2)

									EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


								END TRY	
								BEGIN CATCH
									
									DECLARE @ERROR_NUMBER_2 INT
									DECLARE @ERROR_SEVERITY_2 INT
									DECLARE @ERROR_STATE_2 INT
									DECLARE @ERROR_PROCEDURE_2 NVARCHAR(500)
									DECLARE @ERROR_LINE_2 INT
									DECLARE @ERROR_MESSAGE_2 NVARCHAR(MAX)

									SELECT @ERROR_NUMBER_2 = (SELECT ERROR_NUMBER())
									SELECT @ERROR_SEVERITY_2 = (SELECT ERROR_SEVERITY())
									SELECT @ERROR_STATE_2 = (SELECT ERROR_STATE())
									SELECT @ERROR_PROCEDURE_2 = (SELECT ERROR_PROCEDURE())
									SELECT @ERROR_LINE_2 = (SELECT ERROR_LINE())
									SELECT @ERROR_MESSAGE_2 = (SELECT ERROR_MESSAGE())

									EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
									, @ErrorNumber = @ERROR_NUMBER_2, @ErrorSeverity = @ERROR_SEVERITY_2, @ErrorState = @ERROR_STATE_2, @ErrorProcedure = @ERROR_PROCEDURE_2, @ErrorLine = @ERROR_LINE_2, @ErrorMessage = @ERROR_MESSAGE_2;
									
								END CATCH

								DECLARE @SQL_ATTRIBUTE1_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE2_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE3_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE4_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE5_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE6_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE7_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE8_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE9_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE10_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE11_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE12_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE13_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE14_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE15_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE16_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE17_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE18_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE19_2 NVARCHAR(MAX);
								DECLARE @SQL_ATTRIBUTE20_2 NVARCHAR(MAX);

								SELECT @SQL_ATTRIBUTE1_2 = (SELECT ATTRIBUTE_1 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE2_2 = (SELECT ATTRIBUTE_2 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE3_2 = (SELECT ATTRIBUTE_3 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE4_2 = (SELECT ATTRIBUTE_4 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE5_2 = (SELECT ATTRIBUTE_5 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE6_2 = (SELECT ATTRIBUTE_6 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE7_2 = (SELECT ATTRIBUTE_7 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE8_2 = (SELECT ATTRIBUTE_8 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE9_2 = (SELECT ATTRIBUTE_9 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE10_2 = (SELECT ATTRIBUTE_10 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE11_2 = (SELECT ATTRIBUTE_11 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE12_2 = (SELECT ATTRIBUTE_12 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);	
								SELECT @SQL_ATTRIBUTE13_2 = (SELECT ATTRIBUTE_13 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);	
								SELECT @SQL_ATTRIBUTE14_2 = (SELECT ATTRIBUTE_14 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE15_2 = (SELECT ATTRIBUTE_15 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE16_2 = (SELECT ATTRIBUTE_16 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);	
								SELECT @SQL_ATTRIBUTE17_2 = (SELECT ATTRIBUTE_17 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE18_2 = (SELECT ATTRIBUTE_18 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);	
								SELECT @SQL_ATTRIBUTE19_2 = (SELECT ATTRIBUTE_19 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
								SELECT @SQL_ATTRIBUTE20_2 = (SELECT ATTRIBUTE_20 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);


								EXEC(@SQL_ATTRIBUTE1_2 + ' ' + @SQL_ATTRIBUTE2_2 + ' ' + @SQL_ATTRIBUTE3_2 + ' ' + 
									@SQL_ATTRIBUTE4_2 + ' ' + @SQL_ATTRIBUTE5_2 + ' ' + @SQL_ATTRIBUTE6_2 + ' ' + 
									@SQL_ATTRIBUTE7_2 + ' ' + @SQL_ATTRIBUTE8_2 + ' ' + @SQL_ATTRIBUTE9_2 + ' ' + 
									@SQL_ATTRIBUTE10_2 + ' ' + @SQL_ATTRIBUTE11_2 + ' ' + @SQL_ATTRIBUTE12_2 + ' ' + @SQL_ATTRIBUTE13_2
									)
								EXEC(@SQL_ATTRIBUTE14_2)
								EXEC(@SQL_ATTRIBUTE15_2)
								EXEC(@SQL_ATTRIBUTE16_2)
								EXEC(@SQL_ATTRIBUTE17_2)
								EXEC(@SQL_ATTRIBUTE18_2)
								EXEC(@SQL_ATTRIBUTE19_2)
								EXEC(@SQL_ATTRIBUTE20_2)

									
										
								DECLARE @BEG_TIME4_2 DATETIME
								DECLARE @END_TIME4_2 DATETIME
								DECLARE @DURATION4_2 INT
								DECLARE @RECORD_CNT4_2 INT
								DECLARE @SQL_4B_2 VARCHAR(MAX)
								DECLARE @SQL_4C_2 VARCHAR(MAX)
								DECLARE @SQL_4D_2 VARCHAR(MAX)
								DECLARE @SQL_4E_2 VARCHAR(MAX)
										
								DECLARE @RECORD_CNT4A_2 NVARCHAR(MAX) = N'SELECT @RECORD_CNT4_2 = (SELECT COUNT(*) FROM ' + @TABLE_NAME_2 + ')'
								EXEC sp_executesql @RECORD_CNT4A_2, N'@RECORD_CNT4_2 INT OUT', @RECORD_CNT4_2 OUT
										
								DECLARE @BEG_TIME4A_2 NVARCHAR(MAX) = N'SELECT @BEG_TIME4_2 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_2 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
								EXEC sp_executesql @BEG_TIME4A_2, N'@BEG_TIME4_2 DATETIME OUT', @BEG_TIME4_2 OUT

								DECLARE @END_TIME4A_2 NVARCHAR(MAX) = N'SELECT @END_TIME4_2 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_2 + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
								EXEC sp_executesql @END_TIME4A_2, N'@END_TIME4_2 DATETIME OUT', @END_TIME4_2 OUT

								SET @DURATION4_2 = DATEDIFF(SECOND,@BEG_TIME4_2,@END_TIME4_2)
									 
											
								EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4_2, @Alpha_End_Time = @END_TIME4_2, @Alpha_Duration_In_Seconds = @DURATION4_2, @Alpha_Count = @RECORD_CNT4_2, @Alpha_Result = 1;

							END
						SET @Main_LOOP_NUM_2 = @Main_LOOP_NUM_2 + 1	
					END
				SET @Main_LOOP_NUM_2 = 0							
			END	
			
				
		IF @Step_Date_2 != @Todays_Date_2 OR @Step_Date_2 IS NULL
			BEGIN
			
				DECLARE @Wait_Time_3 NVARCHAR(10)
				SET @Wait_Time_3 = '01:00:00'

				WAITFOR DELAY @Wait_Time_3

					DECLARE @Main_Total_Loop_Num_3 INT
					SELECT @Main_Total_Loop_Num_3 = (
						SELECT MAX(Fields_Key) AS Max_Field
								FROM CREATE_TRANS_LOAD_TABLES
								WHERE 1 = 1
									AND Active = 1
								
						)
					DECLARE @Main_LOOP_NUM_3 INT
					SET @Main_LOOP_NUM_3 = 1
					WHILE  @Main_LOOP_NUM_3 <= @Main_Total_Loop_Num_3 
						BEGIN
						
							DECLARE @IsActive_3 INT
							SELECT @IsActive_3 = (
								SELECT Active 
									FROM CREATE_TRANS_LOAD_TABLES
									WHERE 1 = 1
										AND Fields_Key = @Main_LOOP_NUM_3
								)
								
							DECLARE @Table_Name_By_Loop_3 NVARCHAR(200)
							SELECT @Table_Name_By_Loop_3 = (
								SELECT Table_Name
									FROM CREATE_TRANS_LOAD_TABLES
									WHERE 1 = 1
										AND Fields_Key = @Main_LOOP_NUM_3
								)
								
							IF @IsActive_3 = 1
								BEGIN	
						
									BEGIN TRY
									
									-- -----------------------------
									-- Create Table
									-- -----------------------------
									
										DECLARE @TABLE_NAME_3 VARCHAR(100)
										DECLARE @CREATE_FIELDS_3 VARCHAR(MAX)
										DECLARE @INSERT_FIELDS_3 VARCHAR(MAX)
										DECLARE @SQL_1_3 VARCHAR(MAX)
										DECLARE @SQL_2_3 VARCHAR(MAX)

										SELECT @TABLE_NAME_3 = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_3);
										SELECT @CREATE_FIELDS_3 = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_3);
										SELECT @INSERT_FIELDS_3 = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.CREATE_TRANS_LOAD_TABLES WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM_3);

										EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

										SET @SQL_2_3 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + ''', ''U'' '
										SET @SQL_1_3 = '
											IF OBJECT_ID(' + @SQL_2_3 + ') IS NOT NULL
											DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + '
											
											CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + '(' + @CREATE_FIELDS_3 + ')'
										
										EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1_3, @Alpha_Result = 1;
										
										EXEC(@SQL_1_3)

										EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


									END TRY	
									BEGIN CATCH
										
										DECLARE @ERROR_NUMBER_3 INT
										DECLARE @ERROR_SEVERITY_3 INT
										DECLARE @ERROR_STATE_3 INT
										DECLARE @ERROR_PROCEDURE_3 NVARCHAR(500)
										DECLARE @ERROR_LINE_3 INT
										DECLARE @ERROR_MESSAGE_3 NVARCHAR(MAX)

										SELECT @ERROR_NUMBER_3 = (SELECT ERROR_NUMBER())
										SELECT @ERROR_SEVERITY_3 = (SELECT ERROR_SEVERITY())
										SELECT @ERROR_STATE_3 = (SELECT ERROR_STATE())
										SELECT @ERROR_PROCEDURE_3 = (SELECT ERROR_PROCEDURE())
										SELECT @ERROR_LINE_3 = (SELECT ERROR_LINE())
										SELECT @ERROR_MESSAGE_3 = (SELECT ERROR_MESSAGE())

										EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
										, @ErrorNumber = @ERROR_NUMBER_3, @ErrorSeverity = @ERROR_SEVERITY_3, @ErrorState = @ERROR_STATE_3, @ErrorProcedure = @ERROR_PROCEDURE_3, @ErrorLine = @ERROR_LINE_3, @ErrorMessage = @ERROR_MESSAGE_3;
										
									END CATCH

									DECLARE @SQL_ATTRIBUTE1_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE2_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE3_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE4_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE5_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE6_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE7_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE8_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE9_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE10_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE11_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE12_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE13_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE14_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE15_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE16_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE17_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE18_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE19_3 NVARCHAR(MAX);
									DECLARE @SQL_ATTRIBUTE20_3 NVARCHAR(MAX);

									SELECT @SQL_ATTRIBUTE1_3 = (SELECT ATTRIBUTE_1 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE2_3 = (SELECT ATTRIBUTE_2 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE3_3 = (SELECT ATTRIBUTE_3 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE4_3 = (SELECT ATTRIBUTE_4 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE5_3 = (SELECT ATTRIBUTE_5 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE6_3 = (SELECT ATTRIBUTE_6 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE7_3 = (SELECT ATTRIBUTE_7 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE8_3 = (SELECT ATTRIBUTE_8 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE9_3 = (SELECT ATTRIBUTE_9 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE10_3 = (SELECT ATTRIBUTE_10 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE11_3 = (SELECT ATTRIBUTE_11 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE12_3 = (SELECT ATTRIBUTE_12 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);	
									SELECT @SQL_ATTRIBUTE13_3 = (SELECT ATTRIBUTE_13 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);	
									SELECT @SQL_ATTRIBUTE14_3 = (SELECT ATTRIBUTE_14 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE15_3 = (SELECT ATTRIBUTE_15 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE16_3 = (SELECT ATTRIBUTE_16 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);	
									SELECT @SQL_ATTRIBUTE17_3 = (SELECT ATTRIBUTE_17 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE18_3 = (SELECT ATTRIBUTE_18 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);	
									SELECT @SQL_ATTRIBUTE19_3 = (SELECT ATTRIBUTE_19 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
									SELECT @SQL_ATTRIBUTE20_3 = (SELECT ATTRIBUTE_20 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);


									EXEC(@SQL_ATTRIBUTE1_3 + ' ' + @SQL_ATTRIBUTE2_3 + ' ' + @SQL_ATTRIBUTE3_3 + ' ' + 
										@SQL_ATTRIBUTE4_3 + ' ' + @SQL_ATTRIBUTE5_3 + ' ' + @SQL_ATTRIBUTE6_3 + ' ' + 
										@SQL_ATTRIBUTE7_3 + ' ' + @SQL_ATTRIBUTE8_3 + ' ' + @SQL_ATTRIBUTE9_3 + ' ' + 
										@SQL_ATTRIBUTE10_3 + ' ' + @SQL_ATTRIBUTE11_3 + ' ' + @SQL_ATTRIBUTE12_3 + ' ' + @SQL_ATTRIBUTE13_3
										)
									EXEC(@SQL_ATTRIBUTE14_3)
									EXEC(@SQL_ATTRIBUTE15_3)
									EXEC(@SQL_ATTRIBUTE16_3)
									EXEC(@SQL_ATTRIBUTE17_3)
									EXEC(@SQL_ATTRIBUTE18_3)
									EXEC(@SQL_ATTRIBUTE19_3)
									EXEC(@SQL_ATTRIBUTE20_3)

										
											
									DECLARE @BEG_TIME4_3 DATETIME
									DECLARE @END_TIME4_3 DATETIME
									DECLARE @DURATION4_3 INT
									DECLARE @RECORD_CNT4_3 INT
									DECLARE @SQL_4B_3 VARCHAR(MAX)
									DECLARE @SQL_4C_3 VARCHAR(MAX)
									DECLARE @SQL_4D_3 VARCHAR(MAX)
									DECLARE @SQL_4E_3 VARCHAR(MAX)
											
									DECLARE @RECORD_CNT4A_3 NVARCHAR(MAX) = N'SELECT @RECORD_CNT4_3 = (SELECT COUNT(*) FROM ' + @TABLE_NAME_3 + ')'
									EXEC sp_executesql @RECORD_CNT4A_3, N'@RECORD_CNT4_3 INT OUT', @RECORD_CNT4_3 OUT
											
									DECLARE @BEG_TIME4A_3 NVARCHAR(MAX) = N'SELECT @BEG_TIME4_3 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_3 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
									EXEC sp_executesql @BEG_TIME4A_3, N'@BEG_TIME4_3 DATETIME OUT', @BEG_TIME4_3 OUT

									DECLARE @END_TIME4A_3 NVARCHAR(MAX) = N'SELECT @END_TIME4_3 = (SELECT Alpha_DateTime FROM Alpha_Table_3 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_3 + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
									EXEC sp_executesql @END_TIME4A_3, N'@END_TIME4_3 DATETIME OUT', @END_TIME4_3 OUT

									SET @DURATION4_3 = DATEDIFF(SECOND,@BEG_TIME4_3,@END_TIME4_3)
										 
												
									EXEC dbo.usp_Insert_Alpha_3 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4_3, @Alpha_End_Time = @END_TIME4_3, @Alpha_Duration_In_Seconds = @DURATION4_3, @Alpha_Count = @RECORD_CNT4_3, @Alpha_Result = 1;

								END
							SET @Main_LOOP_NUM_3 = @Main_LOOP_NUM_3 + 1	
						END
					SET @Main_LOOP_NUM_3 = 0
			END
	END
	
-- --------------------------
-- Production Table Counts 
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Production_Table_Counts','U') IS NULL

CREATE TABLE Production_Table_Counts (
	Production_Table_Counts_Key INT IDENTITY(10000,1) PRIMARY KEY
	, Run_Date DATETIME
	, _Affiliated_Dim_Cnt INT
	, _Award_Dim_Cnt INT
	, _Phone_Dim_Cnt INT
	, _Email_Dim_Cnt INT
	, _Activity_Dim_Cnt INT
	, _Drop_Include_Dim_Cnt INT
	, _Language_Dim_Cnt INT
	, _Association_Dim_Cnt INT
	, _Alumni_Dim_Cnt INT
	, _Employment_Dim_Cnt INT
	, _Psa_Dim_Cnt INT
	, _Address_Dim_Cnt INT
	, _Connection_Dim_Cnt INT
	, _Id_Dim_Cnt INT
	, _Interest_Dim_Cnt INT
	, _Student_Dim_Cnt INT
	, _Date_Dim_Cnt INT
	, _Date_Dim2_Cnt INT
	, _Donor_Dim_Cnt INT
	, _Fund_Dim_Cnt INT
	, _Hier_Dim_Cnt INT
	, _User_Dim_Cnt INT
	, _User_Coordinating_Liaison_Dim_Cnt INT
	, _User_Pending_Liaison_Dim_Cnt INT
	, _User_Connected_Liaison_Dim_Cnt INT
	, _User_Initiative_Liaison_Dim_Cnt INT
	, _Donation_Dim_Cnt INT
	, _Appeal_Dim_Cnt INT
	, _Expectancy_Dim_Cnt INT
	, _Donation_Fact_Cnt INT
	, _Expectancy_Fact_Cnt INT
	, _Accounting_Fact_Cnt INT
	, _Retention_Byu_Fact_Cnt INT
	, _Retention_Byui_Fact_Cnt INT
	, _Retention_Byuh_Fact_Cnt INT
	, _Retention_Ldsbc_Fact_Cnt INT
	, _Donor_Retention_Type_Dim_Cnt INT
	, _Accounting_Dim_Cnt INT
	, _Accounting_Tender_Type_Dim_Cnt INT
	, _Accounting_Kind_Dim_Cnt INT
	, _Accounting_Transmitted_Dim_Cnt INT
	, _Accounting_Text_Dim_Cnt INT
	, _Primary_Contact_Dim_Cnt INT
	, _Drop_Logic_Dim_Cnt INT
	, _Reporting_Group_Dim_Cnt INT
	, _Accounting_Goals_Dim_Cnt INT
	, _Accounting_All_Groups_Goals_Dim_Cnt INT
	, _Initiative_Fact_Cnt INT
	, _Initiative_Dim_Cnt INT
	, _Accounting_Week_Cnt INT
	, _Recurring_Gift_Fact_Cnt INT
	, _Recurring_Gift_Dim_Cnt INT
	, View_Portfolio_Management_Cnt INT
	, View_Liaison_Initiative_Cnt INT
)

INSERT INTO Production_Table_Counts (
	Run_Date
	, _Affiliated_Dim_Cnt
	, _Award_Dim_Cnt
	, _Phone_Dim_Cnt
	, _Email_Dim_Cnt
	, _Activity_Dim_Cnt
	, _Drop_Include_Dim_Cnt
	, _Language_Dim_Cnt
	, _Association_Dim_Cnt
	, _Alumni_Dim_Cnt
	, _Employment_Dim_Cnt
	, _Psa_Dim_Cnt
	, _Address_Dim_Cnt
	, _Connection_Dim_Cnt
	, _Id_Dim_Cnt
	, _Interest_Dim_Cnt
	, _Student_Dim_Cnt
	, _Date_Dim_Cnt
	, _Date_Dim2_Cnt
	, _Donor_Dim_Cnt
	, _Fund_Dim_Cnt
	, _Hier_Dim_Cnt
	, _User_Dim_Cnt
	, _User_Coordinating_Liaison_Dim_Cnt
	, _User_Pending_Liaison_Dim_Cnt
	, _User_Connected_Liaison_Dim_Cnt
	, _User_Initiative_Liaison_Dim_Cnt
	, _Donation_Dim_Cnt
	, _Appeal_Dim_Cnt
	, _Expectancy_Dim_Cnt
	, _Donation_Fact_Cnt
	, _Expectancy_Fact_Cnt
	, _Accounting_Fact_Cnt
	, _Retention_Byu_Fact_Cnt
	, _Retention_Byui_Fact_Cnt
	, _Retention_Byuh_Fact_Cnt
	, _Retention_Ldsbc_Fact_Cnt
	, _Donor_Retention_Type_Dim_Cnt
	, _Accounting_Dim_Cnt
	, _Accounting_Tender_Type_Dim_Cnt
	, _Accounting_Kind_Dim_Cnt
	, _Accounting_Transmitted_Dim_Cnt
	, _Accounting_Text_Dim_Cnt
	, _Primary_Contact_Dim_Cnt
	, _Drop_Logic_Dim_Cnt
	, _Reporting_Group_Dim_Cnt
	, _Accounting_Goals_Dim_Cnt
	, _Accounting_All_Groups_Goals_Dim_Cnt
	, _Initiative_Fact_Cnt
	, _Initiative_Dim_Cnt
	, _Accounting_Week_Cnt
	, _Recurring_Gift_Fact_Cnt
	, _Recurring_Gift_Dim_Cnt
	, View_Portfolio_Management_Cnt
	, View_Liaison_Initiative_Cnt
)
SELECT GETDATE() AS Run_Date
	, A._Affiliated_Dim_Cnt
	, B._Award_Dim_Cnt
	, C._Phone_Dim_Cnt
	, D._Email_Dim_Cnt
	, E._Activity_Dim_Cnt
	, F._Drop_Include_Dim_Cnt
	, G._Language_Dim_Cnt
	, H._Association_Dim_Cnt
	, I._Alumni_Dim_Cnt
	, J._Employment_Dim_Cnt
	, K._Psa_Dim_Cnt
	, L._Address_Dim_Cnt
	, M._Connection_Dim_Cnt
	, N._Id_Dim_Cnt
	, O._Interest_Dim_Cnt
	, P._Student_Dim_Cnt
	, Q._Date_Dim_Cnt
	, R._Date_Dim2_Cnt
	, S._Donor_Dim_Cnt
	, T._Fund_Dim_Cnt
	, U._Hier_Dim_Cnt
	, V._User_Dim_Cnt
	, W._User_Coordinating_Liaison_Dim_Cnt
	, X._User_Pending_Liaison_Dim_Cnt
	, Y._User_Connected_Liaison_Dim_Cnt
	, Z._User_Initiative_Liaison_Dim_Cnt
	, AA._Donation_Dim_Cnt
	, AB._Appeal_Dim_Cnt
	, AC._Expectancy_Dim_Cnt
	, AD._Donation_Fact_Cnt
	, AE._Expectancy_Fact_Cnt
	, AF._Accounting_Fact_Cnt
	, AG._Retention_Byu_Fact_Cnt
	, AH._Retention_Byui_Fact_Cnt
	, AI._Retention_Byuh_Fact_Cnt
	, AJ._Retention_Ldsbc_Fact_Cnt
	, AK._Donor_Retention_Type_Dim_Cnt
	, AL._Accounting_Dim_Cnt
	, AM._Accounting_Tender_Type_Dim_Cnt
	, AN._Accounting_Kind_Dim_Cnt
	, AO._Accounting_Transmitted_Dim_Cnt
	, AP._Accounting_Text_Dim_Cnt
	, AQ._Primary_Contact_Dim_Cnt
	, AR._Drop_Logic_Dim_Cnt
	, ASA._Reporting_Group_Dim_Cnt
	, ATA._Accounting_Goals_Dim_Cnt
	, AU._Accounting_All_Groups_Goals_Dim_Cnt
	, AV._Initiative_Fact_Cnt
	, AW._Initiative_Dim_Cnt
	, AX._Accounting_Week_Cnt
	, AY._Recurring_Gift_Fact_Cnt
	, AZ._Recurring_Gift_Dim_Cnt
	, BA.View_Portfolio_Management_Cnt
	, BB.View_Liaison_Initiative_Cnt
	FROM
		(SELECT COUNT(*) AS _Affiliated_Dim_Cnt
			FROM _Affiliated_Dim		
		) A ,
		(SELECT COUNT(*) AS _Award_Dim_Cnt
			FROM _Award_Dim		
		) B ,
		(SELECT COUNT(*) AS _Phone_Dim_Cnt
			FROM _Phone_Dim		
		) C ,
		(SELECT COUNT(*) AS _Email_Dim_Cnt
			FROM _Email_Dim		
		) D ,
		(SELECT COUNT(*) AS _Activity_Dim_Cnt
			FROM _Activity_Dim		
		) E ,
		(SELECT COUNT(*) AS _Drop_Include_Dim_Cnt
			FROM _Drop_Include_Dim		
		) F ,
		(SELECT COUNT(*) AS _Language_Dim_Cnt
			FROM _Language_Dim		
		) G ,
		(SELECT COUNT(*) AS _Association_Dim_Cnt
			FROM _Association_Dim		
		) H ,
		(SELECT COUNT(*) AS _Alumni_Dim_Cnt
			FROM _Alumni_Dim		
		) I ,
		(SELECT COUNT(*) AS _Employment_Dim_Cnt
			FROM _Employment_Dim		
		) J ,
		(SELECT COUNT(*) AS _Psa_Dim_Cnt
			FROM _Psa_Dim		
		) K ,
		(SELECT COUNT(*) AS _Address_Dim_Cnt
			FROM _Address_Dim		
		) L ,
		(SELECT COUNT(*) AS _Connection_Dim_Cnt
			FROM _Connection_Dim		
		) M ,
		(SELECT COUNT(*) AS _Id_Dim_Cnt
			FROM _Id_Dim		
		) N ,
		(SELECT COUNT(*) AS _Interest_Dim_Cnt
			FROM _Interest_Dim		
		) O ,
		(SELECT COUNT(*) AS _Student_Dim_Cnt
			FROM _Student_Dim		
		) P ,
		(SELECT COUNT(*) AS _Date_Dim_Cnt
			FROM _Date_Dim		
		) Q ,
		(SELECT COUNT(*) AS _Date_Dim2_Cnt
			FROM _Date_Dim2		
		) R ,
		(SELECT COUNT(*) AS _Donor_Dim_Cnt
			FROM _Donor_Dim		
		) S ,
		(SELECT COUNT(*) AS _Fund_Dim_Cnt
			FROM _Fund_Dim		
		) T ,
		(SELECT COUNT(*) AS _Hier_Dim_Cnt
			FROM _Hier_Dim		
		) U ,
		(SELECT COUNT(*) AS _User_Dim_Cnt
			FROM _User_Dim		
		) V ,
		(SELECT COUNT(*) AS _User_Coordinating_Liaison_Dim_Cnt
			FROM _User_Coordinating_Liaison_Dim		
		) W ,
		(SELECT COUNT(*) AS _User_Pending_Liaison_Dim_Cnt
			FROM _User_Pending_Liaison_Dim		
		) X ,
		(SELECT COUNT(*) AS _User_Connected_Liaison_Dim_Cnt
			FROM _User_Connected_Liaison_Dim		
		) Y ,
		(SELECT COUNT(*) AS _User_Initiative_Liaison_Dim_Cnt
			FROM _User_Initiative_Liaison_Dim		
		) Z ,
		(SELECT COUNT(*) AS _Donation_Dim_Cnt
			FROM _Donation_Dim		
		) AA ,
		(SELECT COUNT(*) AS _Appeal_Dim_Cnt
			FROM _Appeal_Dim		
		) AB ,
		(SELECT COUNT(*) AS _Expectancy_Dim_Cnt
			FROM _Expectancy_Dim		
		) AC ,
		(SELECT COUNT(*) AS _Donation_Fact_Cnt
			FROM _Donation_Fact		
		) AD ,
		(SELECT COUNT(*) AS _Expectancy_Fact_Cnt
			FROM _Expectancy_Fact		
		) AE ,
		(SELECT COUNT(*) AS _Accounting_Fact_Cnt
			FROM _Accounting_Fact		
		) AF ,
		(SELECT COUNT(*) AS _Retention_Byu_Fact_Cnt
			FROM _Retention_Byu_Fact		
		) AG ,
		(SELECT COUNT(*) AS _Retention_Byui_Fact_Cnt
			FROM _Retention_Byui_Fact		
		) AH ,
		(SELECT COUNT(*) AS _Retention_Byuh_Fact_Cnt
			FROM _Retention_Byuh_Fact		
		) AI ,
		(SELECT COUNT(*) AS _Retention_Ldsbc_Fact_Cnt
			FROM _Retention_Ldsbc_Fact		
		) AJ ,
		(SELECT COUNT(*) AS _Donor_Retention_Type_Dim_Cnt
			FROM _Donor_Retention_Type_Dim		
		) AK ,
		(SELECT COUNT(*) AS _Accounting_Dim_Cnt
			FROM _Accounting_Dim		
		) AL ,
		(SELECT COUNT(*) AS _Accounting_Tender_Type_Dim_Cnt
			FROM _Accounting_Tender_Type_Dim		
		) AM ,
		(SELECT COUNT(*) AS _Accounting_Kind_Dim_Cnt
			FROM _Accounting_Kind_Dim		
		) AN ,
		(SELECT COUNT(*) AS _Accounting_Transmitted_Dim_Cnt
			FROM _Accounting_Transmitted_Dim		
		) AO ,
		(SELECT COUNT(*) AS _Accounting_Text_Dim_Cnt
			FROM _Accounting_Text_Dim		
		) AP ,
		(SELECT COUNT(*) AS _Primary_Contact_Dim_Cnt
			FROM _Primary_Contact_Dim		
		) AQ ,
		(SELECT COUNT(*) AS _Drop_Logic_Dim_Cnt
			FROM _Drop_Logic_Dim		
		) AR ,
		(SELECT COUNT(*) AS _Reporting_Group_Dim_Cnt
			FROM _Reporting_Group_Dim		
		) ASA ,
		(SELECT COUNT(*) AS _Accounting_Goals_Dim_Cnt
			FROM _Accounting_Goals_Dim		
		) ATA ,
		(SELECT COUNT(*) AS _Accounting_All_Groups_Goals_Dim_Cnt
			FROM _Accounting_All_Groups_Goals_Dim		
		) AU ,
		(SELECT COUNT(*) AS _Initiative_Fact_Cnt
			FROM _Initiative_Fact		
		) AV ,
		(SELECT COUNT(*) AS _Initiative_Dim_Cnt
			FROM _Initiative_Dim		
		) AW ,
		(SELECT COUNT(*) AS _Accounting_Week_Cnt
			FROM _Accounting_Week		
		) AX ,
		(SELECT COUNT(*) AS _Recurring_Gift_Fact_Cnt
			FROM _Recurring_Gift_Fact		
		) AY ,
		(SELECT COUNT(*) AS _Recurring_Gift_Dim_Cnt
			FROM _Recurring_Gift_Dim		
		) AZ ,
		(SELECT COUNT(*) AS View_Portfolio_Management_Cnt
			FROM View_Portfolio_Management		
		) BA ,
		(SELECT COUNT(*) AS View_Liaison_Initiative_Cnt
			FROM View_Liaison_Initiative		
		) BB


-- -------------------------------------------
-- EMAIL
-- -------------------------------------------


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

END


