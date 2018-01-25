USE [OneAccord_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_Ldsp_Trans_Load]    Script Date: 11/7/2017 3:21:00 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE [dbo].[usp_Ldsp_Trans_Load] 
AS
BEGIN

-- --------------------------
-- ALPHA_2
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Alpha_Table_2','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Alpha_Table_2;


CREATE TABLE Alpha_Table_2 (
	Alpha_Key INT IDENTITY(1,1) PRIMARY KEY
	, Alpha_DateTime DATETIME
	, Alpha_Stage NVARCHAR(50)
	, Alpha_Step_Number NVARCHAR(10)
	, Alpha_Step_Name NVARCHAR(200)
	, Alpha_Begin_Time DATETIME
	, Alpha_End_Time DATETIME
	, Alpha_Duration_In_Seconds INT
	, Alpha_Count BIGINT
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


EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = 'Script Start', @Alpha_Step_Number = '0', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;


DECLARE @Todays_Date DATE
	SET @Todays_Date = GETDATE()

	DECLARE @Table_Name_Check NVARCHAR(100)
	SET @Table_Name_Check = 'Ext_Payroll_Group'
	
	DECLARE @Step_Date DATE
		SELECT @Step_Date = (
			SELECT Alpha_DateTime
				FROM Alpha_Table_1
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

						EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

						SET @SQL_2 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME + ''', ''U'' '
						SET @SQL_1 = '
							IF OBJECT_ID(' + @SQL_2 + ') IS NOT NULL
							DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '
							
							CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '(' + @CREATE_FIELDS + ')'
						
						EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1, @Alpha_Result = 1;
						
						EXEC(@SQL_1)

						EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


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

						EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
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
					DECLARE @SQL_ATTRIBUTE21 NVARCHAR(MAX);

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
					SELECT @SQL_ATTRIBUTE21 = (SELECT ATTRIBUTE_21 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop);
					
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
							
					DECLARE @BEG_TIME4A NVARCHAR(MAX) = N'SELECT @BEG_TIME4 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
					EXEC sp_executesql @BEG_TIME4A, N'@BEG_TIME4 DATETIME OUT', @BEG_TIME4 OUT

					DECLARE @END_TIME4A NVARCHAR(MAX) = N'SELECT @END_TIME4 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
					EXEC sp_executesql @END_TIME4A, N'@END_TIME4 DATETIME OUT', @END_TIME4 OUT

					SET @DURATION4 = DATEDIFF(SECOND,@BEG_TIME4,@END_TIME4)
						 
								
					EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4, @Alpha_End_Time = @END_TIME4, @Alpha_Duration_In_Seconds = @DURATION4, @Alpha_Count = @RECORD_CNT4, @Alpha_Result = 1;

					EXEC(@SQL_ATTRIBUTE21)
					
				END

				SET @Main_LOOP_NUM = @Main_LOOP_NUM + 1	
			END
		SET @Main_LOOP_NUM = 0
	END
	
IF @Step_Date != @Todays_Date OR @Step_Date IS NULL
	BEGIN
		
		DECLARE @Wait_Time NVARCHAR(10)
		SET @Wait_Time = '00:15:00'

		WAITFOR DELAY @Wait_Time
		
	
		DECLARE @Todays_Date_2 DATE
		SET @Todays_Date_2 = GETDATE()

		DECLARE @Table_Name_Check_2 NVARCHAR(100)
		SET @Table_Name_Check_2 = 'Ext_Payroll_Group'
		
		DECLARE @Step_Date_2 DATE
			SELECT @Step_Date_2 = (
				SELECT Alpha_DateTime
					FROM Alpha_Table_1
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

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

								SET @SQL_2_2 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + ''', ''U'' '
								SET @SQL_1_2 = '
									IF OBJECT_ID(' + @SQL_2_2 + ') IS NOT NULL
									DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + '
									
									CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_2 + '(' + @CREATE_FIELDS_2 + ')'
								
								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1_2, @Alpha_Result = 1;
								
								EXEC(@SQL_1_2)

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


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

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
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
							DECLARE @SQL_ATTRIBUTE21_2 NVARCHAR(MAX);

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
							SELECT @SQL_ATTRIBUTE21_2 = (SELECT ATTRIBUTE_21 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_2);
							
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
									
							DECLARE @BEG_TIME4A_2 NVARCHAR(MAX) = N'SELECT @BEG_TIME4_2 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_2 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
							EXEC sp_executesql @BEG_TIME4A_2, N'@BEG_TIME4_2 DATETIME OUT', @BEG_TIME4_2 OUT

							DECLARE @END_TIME4A_2 NVARCHAR(MAX) = N'SELECT @END_TIME4_2 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_2 + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
							EXEC sp_executesql @END_TIME4A_2, N'@END_TIME4_2 DATETIME OUT', @END_TIME4_2 OUT

							SET @DURATION4_2 = DATEDIFF(SECOND,@BEG_TIME4_2,@END_TIME4_2)
								 
										
							EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_2, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4_2, @Alpha_End_Time = @END_TIME4_2, @Alpha_Duration_In_Seconds = @DURATION4_2, @Alpha_Count = @RECORD_CNT4_2, @Alpha_Result = 1;

							EXEC(@SQL_ATTRIBUTE21_2)
							
						END

						SET @Main_LOOP_NUM_2 = @Main_LOOP_NUM_2 + 1	
					END
				SET @Main_LOOP_NUM_2 = 0
				
			END
			
		IF @Step_Date_2 != @Todays_Date_2 OR @Step_Date_2 IS NULL
			BEGIN
			
				DECLARE @Wait_Time_3 NVARCHAR(10)
				SET @Wait_Time_3 = '00:15:00'

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

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Table Creation - Begin', @Alpha_Result = 1;

								SET @SQL_2_3 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + ''', ''U'' '
								SET @SQL_1_3 = '
									IF OBJECT_ID(' + @SQL_2_3 + ') IS NOT NULL
									DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + '
									
									CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME_3 + '(' + @CREATE_FIELDS_3 + ')'
								
								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Table Creation - Query', @Alpha_Query = @SQL_1_3, @Alpha_Result = 1;
								
								EXEC(@SQL_1_3)

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Table Creation - End', @Alpha_Result = 1;


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

								EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Table Creation - Error', @Alpha_Result = 0
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
							DECLARE @SQL_ATTRIBUTE21_3 NVARCHAR(MAX);

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
							SELECT @SQL_ATTRIBUTE21_3 = (SELECT ATTRIBUTE_21 FROM CREATE_TRANS_LOAD_TABLES WHERE Table_Name = @Table_Name_By_Loop_3);
							
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
									
							DECLARE @BEG_TIME4A_3 NVARCHAR(MAX) = N'SELECT @BEG_TIME4_3 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_3 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
							EXEC sp_executesql @BEG_TIME4A_3, N'@BEG_TIME4_3 DATETIME OUT', @BEG_TIME4_3 OUT

							DECLARE @END_TIME4A_3 NVARCHAR(MAX) = N'SELECT @END_TIME4_3 = (SELECT Alpha_DateTime FROM Alpha_Table_2 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME_3 + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
							EXEC sp_executesql @END_TIME4A_3, N'@END_TIME4_3 DATETIME OUT', @END_TIME4_3 OUT

							SET @DURATION4_3 = DATEDIFF(SECOND,@BEG_TIME4_3,@END_TIME4_3)
								 
										
							EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = @TABLE_NAME_3, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4_3, @Alpha_End_Time = @END_TIME4_3, @Alpha_Duration_In_Seconds = @DURATION4_3, @Alpha_Count = @RECORD_CNT4_3, @Alpha_Result = 1;

							EXEC(@SQL_ATTRIBUTE21_3)
							
						END

						SET @Main_LOOP_NUM_3 = @Main_LOOP_NUM_3 + 1	
					END
				SET @Main_LOOP_NUM_3 = 0
				
			END

	END	
	
	
-- -------------------------------------------
-- EMAIL
-- -------------------------------------------


DECLARE @Email_Step1_Error_Cnt INT
DECLARE @Email_Body VARCHAR(MAX)
 
SELECT @Email_Step1_Error_Cnt = (SELECT COUNT(Alpha_Result) FROM OneAccord_Warehouse.dbo.Alpha_Table_2 WHERE Alpha_Result = '0'); 

EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = 'Trans\Load Tables Email', @Alpha_Step_Number = 'Email_1A', @Alpha_Step_Name = 'Trans\Load - Email Error Count', @Alpha_Count = @Email_Step1_Error_Cnt, @Alpha_Result = 1;


SET @Email_Body = 'The LDSP Trans\Load ETL has completed with ' + CONVERT(VARCHAR(12),@Email_Step1_Error_Cnt) + ' errors.'


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
	FROM Alpha_Table_2 
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
	, @subject = 'LDSP Trans/Load Complete'  -->>>>>> EMAIL SUBJECT <<<<<<<--
	, @body = @body
	, @body_format = 'HTML'
	, @query = 'SELECT TOP 2500 * FROM OneAccord_Warehouse.dbo.Alpha_Table_2'  -- MAXES OUT MEMORY AND WON'T SEND EMAIL
	, @query_result_header=1
	, @query_no_truncate=1
	, @attach_query_result_as_file=1
	, @query_attachment_filename = 'Alpha Table 2.csv'
	, @query_result_separator = '^'
	
	DROP TABLE #Prod_Summary

	EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = 'Trans\Load Tables Email', @Alpha_Step_Number = 'Email_1B', @Alpha_Step_Name = 'Trans\Load - Email', @Alpha_Result = 1;

END


