USE [OneAccord_Warehouse]
GO

/****** Object:  StoredProcedure [dbo].[usp_Insert_Alpha_1]    Script Date: 8/24/2016 12:45:46 PM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO



ALTER PROCEDURE dbo.usp_Ldsp_Extract 
AS
BEGIN
-- --------------------------
-- ALPHA
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Alpha_Table_1','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Alpha_Table_1;


CREATE TABLE Alpha_Table_1 (
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


EXEC dbo.usp_Insert_Alpha @Alpha_Stage = 'Script Start', @Alpha_Step_Number = 'EXT_1A', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;



DECLARE @FiveAttempts INT
SET @FiveAttempts = 0

WHILE @FiveAttempts < 5
BEGIN			

	DECLARE @Main_Total_Loop_Num INT
		SELECT @Main_Total_Loop_Num = (
			SELECT MAX(Fields_Key) AS Max_Field
				FROM Create_Extract_Tables
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
					FROM Create_Extract_Tables
					WHERE 1 = 1
						AND Fields_Key = @Main_LOOP_NUM
			)
			DECLARE @Table_Name_By_Loop NVARCHAR(200)
			SELECT @Table_Name_By_Loop = (
				SELECT Table_Name
					FROM Create_Extract_Tables
					WHERE 1 = 1
						AND Fields_Key = @Main_LOOP_NUM
			)
			DECLARE @NeedToRun INT
			SELECT @NeedToRun = (
				SELECT CASE WHEN COALESCE(CONVERT(DATE,Time_Stamp),CONVERT(DATE,GETDATE()-1)) < CONVERT(DATE,GETDATE()) OR Alpha_Result NOT IN (5,9,13,17,21) THEN 1 ELSE 0 END 
					FROM Create_Extract_Tables A
						LEFT JOIN
							(SELECT Alpha_Stage AS Production_Table
								, COUNT(Alpha_Result) AS Alpha_Result
								, MAX(Alpha_DateTime) AS Time_Stamp
								FROM Alpha_Table_1 
								WHERE 1 = 1
								GROUP BY Alpha_Stage
							) B ON A.Table_Name = B.Production_Table
					WHERE 1 = 1
						AND Fields_Key = @Main_LOOP_NUM
			)

			IF @IsActive = 1 AND @NeedToRun = 1
				BEGIN

					BEGIN TRY
	
					-- -----------------------------
					-- Create Table
					-- -----------------------------
					
						DECLARE @TABLE_NAME VARCHAR(100)
						DECLARE @CREATE_FIELDS VARCHAR(MAX)
						DECLARE @INSERT_FIELDS VARCHAR(MAX)
						DECLARE @FROM_STATEMENT VARCHAR(MAX)
						DECLARE @SQL_1 VARCHAR(MAX)
						DECLARE @SQL_2 VARCHAR(MAX)

						SELECT @TABLE_NAME = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @FROM_STATEMENT = (SELECT From_Statement FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0A', @Alpha_Step_Name = 'Extract Table Creation - Begin', @Alpha_Result = 1;

						SET @SQL_2 = ' ''OneAccord_Warehouse.dbo.' + @TABLE_NAME + ''', ''U'' '
						SET @SQL_1 = '
							IF OBJECT_ID(' + @SQL_2 + ') IS NOT NULL
							DROP TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '
							
							CREATE TABLE OneAccord_Warehouse.dbo.' + @TABLE_NAME + '(' + @CREATE_FIELDS + ')'
							
						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0B', @Alpha_Step_Name = 'Extract Table Creation - Query', @Alpha_Query = @SQL_1, @Alpha_Result = 1;
						
						EXEC(@SQL_1)

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0C', @Alpha_Step_Name = 'Extract Table Creation - End', @Alpha_Result = 1;


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

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Extract Table Creation - Error', @Alpha_Result = 0
						, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;
						
					END CATCH
					
					
						
					BEGIN TRY

					-- -----------------------------
					-- Populate Table
					-- -----------------------------

						DECLARE @TABLE_NAME4 VARCHAR(100)
						DECLARE @CREATE_FIELDS4 VARCHAR(MAX)
						DECLARE @INSERT_FIELDS4 VARCHAR(MAX)
						DECLARE @FROM_STATEMENT4 VARCHAR(MAX)
						DECLARE @ATTRIBUTE14 VARCHAR(MAX)
						DECLARE @SQL_4A VARCHAR(MAX)
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
						
						SELECT @TABLE_NAME4 = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS4 = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS4 = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @FROM_STATEMENT4 = (SELECT From_Statement FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @ATTRIBUTE14 = (SELECT Attribute_1 FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @SQL_ATTRIBUTE2 = (SELECT ATTRIBUTE_2 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE3 = (SELECT ATTRIBUTE_3 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE4 = (SELECT ATTRIBUTE_4 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE5 = (SELECT ATTRIBUTE_5 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE6 = (SELECT ATTRIBUTE_6 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE7 = (SELECT ATTRIBUTE_7 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE8 = (SELECT ATTRIBUTE_8 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE9 = (SELECT ATTRIBUTE_9 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE10 = (SELECT ATTRIBUTE_10 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE11 = (SELECT ATTRIBUTE_11 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE12 = (SELECT ATTRIBUTE_12 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE13 = (SELECT ATTRIBUTE_13 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE14 = (SELECT ATTRIBUTE_14 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE15 = (SELECT ATTRIBUTE_15 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE16 = (SELECT ATTRIBUTE_16 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE17 = (SELECT ATTRIBUTE_17 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE18 = (SELECT ATTRIBUTE_18 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE19 = (SELECT ATTRIBUTE_19 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE20 = (SELECT ATTRIBUTE_20 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						
						SET @SQL_4A = 'INSERT INTO ' + @TABLE_NAME4 + ' (' + @INSERT_FIELDS4 + ') SELECT ' + @ATTRIBUTE14 + ' FROM ' + @FROM_STATEMENT4										
						EXEC(@SQL_4A + ' ' + @SQL_ATTRIBUTE2)
						EXEC(@SQL_ATTRIBUTE3 + ' ' + @SQL_ATTRIBUTE4 + ' ' + @SQL_ATTRIBUTE5)
						EXEC(@SQL_ATTRIBUTE6 + ' ' + @SQL_ATTRIBUTE7 + ' ' + @SQL_ATTRIBUTE8)
						EXEC(@SQL_ATTRIBUTE9 + ' ' + @SQL_ATTRIBUTE10 + ' ' + @SQL_ATTRIBUTE11)
						EXEC(@SQL_ATTRIBUTE12 + ' ' + @SQL_ATTRIBUTE13 + ' ' + @SQL_ATTRIBUTE14)
						EXEC(@SQL_ATTRIBUTE15 + ' ' + @SQL_ATTRIBUTE16 + ' ' + @SQL_ATTRIBUTE17)
						EXEC(@SQL_ATTRIBUTE19)
						
						
						DECLARE @BEG_TIME4 DATETIME
						DECLARE @END_TIME4 DATETIME
						DECLARE @DURATION4 INT
						--DECLARE @RECORD_CNT4A NVARCHAR(1000)
						DECLARE @RECORD_CNT4 INT
						DECLARE @SQL_4B VARCHAR(MAX)
						DECLARE @SQL_4C VARCHAR(MAX)
						DECLARE @SQL_4D VARCHAR(MAX)
						DECLARE @SQL_4E VARCHAR(MAX)
						
						DECLARE @RECORD_CNT4A NVARCHAR(MAX) = N'SELECT @RECORD_CNT4 = (SELECT COUNT(*) FROM ' + @TABLE_NAME4 + ')'
						EXEC sp_executesql @RECORD_CNT4A, N'@RECORD_CNT4 INT OUT', @RECORD_CNT4 OUT
						
						DECLARE @BEG_TIME4A NVARCHAR(MAX) = N'SELECT @BEG_TIME4 = (SELECT MAX(Alpha_DateTime) FROM Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME4 + ''' AND RIGHT(Alpha_Step_Number,1) = ''A'')'
						EXEC sp_executesql @BEG_TIME4A, N'@BEG_TIME4 DATETIME OUT', @BEG_TIME4 OUT

						DECLARE @END_TIME4A NVARCHAR(MAX) = N'SELECT @END_TIME4 = (SELECT Alpha_DateTime FROM Alpha_Table_1 WHERE 1 = 1 AND Alpha_Stage = ''' + @TABLE_NAME4 + ''' AND RIGHT(Alpha_Step_Number,1) = ''H'')'
						EXEC sp_executesql @END_TIME4A, N'@END_TIME4 DATETIME OUT', @END_TIME4 OUT

						SET @DURATION4 = DATEDIFF(SECOND,@BEG_TIME4,@END_TIME4)
					 
							
						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME4, @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Stats', @Alpha_Begin_Time = @BEG_TIME4, @Alpha_End_Time = @END_TIME4, @Alpha_Duration_In_Seconds = @DURATION4, @Alpha_Count = @RECORD_CNT4, @Alpha_Result = 1;

						EXEC(@SQL_ATTRIBUTE20)
						
					END TRY	

					BEGIN CATCH

						SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
						SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
						SELECT @ERROR_STATE = (SELECT ERROR_STATE())
						SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
						SELECT @ERROR_LINE = (SELECT ERROR_LINE())
						SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())

						EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME4, @Alpha_Step_Number = '0X', @Alpha_Step_Name = 'Populate Table - Error', @Alpha_Result = 0
						, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;	

					END CATCH 
		 
				END
			
			SET @Main_LOOP_NUM = @Main_LOOP_NUM + 1
	
		END

	SET @Main_LOOP_NUM = 0

	SET @FiveAttempts = @FiveAttempts + 1

END

SET @FiveAttempts = 0


-- -------------------------------------------
-- EMAIL
-- -------------------------------------------


DECLARE @Email_Step1_Error_Cnt INT
DECLARE @Email_Body VARCHAR(MAX)
 
SELECT @Email_Step1_Error_Cnt = (SELECT COUNT(Alpha_Result) FROM OneAccord_Warehouse.dbo.Alpha_Table_1 WHERE Alpha_Result = '0'); 

EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = 'Extract Tables Email', @Alpha_Step_Number = 'Email_1A', @Alpha_Step_Name = 'Extract - Email Error Count', @Alpha_Count = @Email_Step1_Error_Cnt, @Alpha_Result = 1;


SET @Email_Body = 'The LDSP Extract ETL has completed with ' + CONVERT(VARCHAR(12),@Email_Step1_Error_Cnt) + ' errors.'


CREATE TABLE #Ext_Summary (
		[Production Table] NVARCHAR(100)
		, Duration INT
		, [Count] INT
		, [Time] NVARCHAR(15)
		, Message NVARCHAR(1000)
		, [Timestamp] DATETIME
	)
	
	INSERT INTO #Ext_Summary
	SELECT Alpha_Stage AS [Production Table]
	, Alpha_Duration_In_Seconds AS Duration
	, Alpha_Count AS [Count]
	, LEFT(RIGHT(CONVERT(VARCHAR,Alpha_DateTime,9),14),8) + ' ' + RIGHT(CONVERT(VARCHAR,Alpha_DateTime,9),2) AS [Time]
	, ErrorMessage AS Message 
	, Alpha_DateTime AS [Timestamp]
	FROM Alpha_Table_1 
	WHERE 1 = 1
		AND (Alpha_Step_Name = 'Stats'
				OR Alpha_Result = 0)
	
	DECLARE @xml NVARCHAR(MAX)
	DECLARE @body NVARCHAR(MAX)
	
	SET @xml = CAST((SELECT [Production Table] AS 'td','', Duration AS 'td','', [Count] AS 'td','', [Time] AS 'td','', Message AS 'td' FROM #Ext_Summary ORDER BY [Timestamp] DESC
		FOR XML PATH('tr'), ELEMENTS ) AS NVARCHAR(MAX))
	
	SET @body ='<html><body><H3> ' + @Email_Body + '</H3>
		<table border = 1> 
		<tr>
		<th> Production Table </th> <th> Duration </th> <th> Count </th> <th> Time </th> <th> Message </th> </tr>'    
		 
	SET @body = @body + @xml +'</table></body></html>'
	

	EXEC msdb.dbo.sp_send_dbmail
	@recipients = 'fams@LDSChurch.org' 
	, @subject = 'LDSP Extract ETL Complete'  -->>>>>> EMAIL SUBJECT <<<<<<<--
	, @body = @body
	, @body_format = 'HTML'
	, @query = 'SELECT * FROM OneAccord_Warehouse.dbo.Alpha_Table_1'
	, @query_result_header=1
	, @query_no_truncate=1
	, @attach_query_result_as_file=1
	, @query_attachment_filename = 'Alpha Table 1.csv'
	, @query_result_separator = '^'
	
	DROP TABLE #Ext_Summary

	EXEC dbo.usp_Insert_Alpha_2 @Alpha_Stage = 'Extract Tables Email', @Alpha_Step_Number = 'Email_1B', @Alpha_Step_Name = 'Extract - Email', @Alpha_Result = 1;
	
-- -------------------------------------------
-- SOURCE ENTITY RELATIONSHIPS
-- -------------------------------------------
 
	--EXEC dbo.usp_Source_Entity_Relationships
	
-- -------------------------------------------
-- EMAIL2
-- -------------------------------------------

--DECLARE @Email_Body2 VARCHAR(MAX)
 
--SET @Email_Body2 = 'The Source Entity Relationships script completed.'
	
	--EXEC msdb.dbo.sp_send_dbmail
	--@recipients = 'fams@LDSChurch.org' 
	--, @subject = 'Source Entity Relationships Completed'  -->>>>>> EMAIL SUBJECT <<<<<<<--
	--, @body = @Email_Body2
	--, @body_format = 'HTML'
	--, @query = 'SELECT * FROM OneAccord_Warehouse.dbo.Source_Entity_Relationships'
	--, @query_result_header=1
	--, @query_no_truncate=1
	--, @attach_query_result_as_file=1
	--, @query_attachment_filename = 'Source Entity Relationships.csv'
	--, @query_result_separator = '~'
	

END

