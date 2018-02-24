/******************************************************************************
   NAME: CREATE_EXTRACT_TABLES 
   PURPOSE: Extract tables from source database (MSSQL12316\S06) and populate tables in stage database (MSSQL12336\S01)
   PLATFORM: Sql Server Management Studio

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        8/13/2016      Fams           1. Development script that extracts the source data.
   1.1		  12/12/2016	 Fams			2. Added rerun loop
   1.2		  12/13/2016	 Fams			3. Added StatusCode to Ext_Phone
   1.3		  12/28/2016	 Fams			4. Added ConnectionId, Plus_DonorScoreId, Plus_EnvelopeNamesAndSalutationsId, and EntityId. 
												Put NULL place holder in CampaignBase.Plus_Requestor
   1.4        1/6/17		 Fams			5. Added ModifiedOn, Plus_RelatedAddress, Plus_RelatedPhone to Ext_Employment	
   1.5		  1/13/17		 Fams			6. Added New_Batch to Ext_Gift and added the new table Ext_Batch
   1.6		  1/31/17		 Fams			7. Added New_ReceiptDate and Plus_InstitutionalHieararchy to Ext_Recognition_Credit

   
******************************************************************************/

   
USE OneAccord_Warehouse
GO


-- --------------------------
-- ALPHA
-- --------------------------
IF OBJECT_ID('OneAccord_Warehouse.dbo.Alpha_Table_1','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Alpha_Table_1;
GO


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
GO

EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = 'Script Start', @Alpha_Step_Number = 'EXT_1A', @Alpha_Step_Name = 'Beginning', @Alpha_Result = 1;


-- -------------------------------------------------------------------------------------------------



IF OBJECT_ID('OneAccord_Warehouse.dbo.Create_Extract_Tables','U') IS NOT NULL
DROP TABLE OneAccord_Warehouse.dbo.Create_Extract_Tables;
GO

CREATE TABLE OneAccord_Warehouse.dbo.Create_Extract_Tables
	(
	Fields_Key  INT IDENTITY(1,1) PRIMARY KEY
	, Dim_Object NVARCHAR(100)
	, Table_Name NVARCHAR(100)
	, Create_Fields NVARCHAR(4000)
	, Insert_Fields NVARCHAR(4000)
	, From_Statement NVARCHAR(4000)
	, Where_Statement NVARCHAR(4000)
	, Attribute_1 NVARCHAR(4000)
	, Attribute_2 NVARCHAR(4000)
	, Attribute_3 NVARCHAR(4000)
	, Attribute_4 NVARCHAR(4000)
	, Attribute_5 NVARCHAR(4000)
	, Attribute_6 NVARCHAR(4000)
	, Attribute_7 NVARCHAR(4000)
	, Attribute_8 NVARCHAR(4000)
	, Attribute_9 NVARCHAR(4000)
	, Attribute_10 NVARCHAR(4000)
	, Attribute_11 NVARCHAR(4000)
	, Attribute_12 NVARCHAR(4000)
	, Attribute_13 NVARCHAR(4000)
	, Attribute_14 NVARCHAR(4000)
	, Attribute_15 NVARCHAR(4000)
	, Attribute_16 NVARCHAR(4000)
	, Attribute_17 NVARCHAR(4000)
	, Attribute_18 NVARCHAR(4000)
	, Attribute_19 NVARCHAR(4000)
	, Attribute_20 NVARCHAR(MAX)
	, Active BIT
	, Insert_Date DATETIME
	, Update_Date DATETIME
	);
	
INSERT INTO OneAccord_Warehouse.dbo.Create_Extract_Tables
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
-- ACCOUNT (Ext_Account)
-- --------------------------
	('Account' -- Dim_Object
		, 'Ext_Account' -- Table_Name
		,'AccountId UNIQUEIDENTIFIER
			, New_LdspId NVARCHAR(100)
			, Name NVARCHAR(160)
			, ParentAccountId UNIQUEIDENTIFIER
			--, Plus_Matchesgifts BIT  /*Delete from source 5/15/17*/
			--, New_GraduateProfessional BIT  /*Delete from source 5/15/17*/
			--, New_AlumniAssociation BIT  /*Delete from source 5/15/17*/
			--, New_Athletics BIT  /*Delete from source 5/15/17*/
			--, New_FourYear BIT  /*Delete from source 5/15/17*/
			, Description NVARCHAR(4000)
			, DoNotPostalMail BIT
			, DoNotBulkPostalMail BIT
			, DoNotEmail BIT
			, DoNotBulkEmail BIT
			, DoNotPhone BIT
			, DoNotFax BIT
			, AccountClassificationCode INT
			, New_RetireeRatio INT
			, New_SplitRatio INT
			, New_MatchingRatio INT
			, PreferredContactMethodCode INT
			, Plus_CoordinatingLiaison UNIQUEIDENTIFIER
			, Plus_ConnectedLiaison UNIQUEIDENTIFIER
			, Plus_PendingLiaison UNIQUEIDENTIFIER
			, Plus_MatchingGiftProgram INT
			, Plus_TotalGivenLast5Years MONEY
			, Lds_IsQualified BIT
			, Lds_QualifiedOn DATETIME
			, Lds_QualifiedBy UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'AccountId
			, New_LdspId
			, Name
			, ParentAccountId
			--, Plus_Matchesgifts  /*Delete from source 5/15/17*/
			--, New_GraduateProfessional  /*Delete from source 5/15/17*/
			--, New_AlumniAssociation  /*Delete from source 5/15/17*/
			--, New_Athletics  /*Delete from source 5/15/17*/
			--, New_FourYear  /*Delete from source 5/15/17*/
			, Description
			, DoNotPostalMail
			, DoNotBulkPostalMail
			, DoNotEmail
			, DoNotBulkEmail
			, DoNotPhone
			, DoNotFax
			, AccountClassificationCode
			, New_RetireeRatio
			, New_SplitRatio
			, New_MatchingRatio
			, PreferredContactMethodCode
			, Plus_CoordinatingLiaison
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_MatchingGiftProgram
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Insert_Fields
		, 'AccountBase A
			LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Lds_QualifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'AccountId
			, New_LdspId
			, Name
			, ParentAccountId
			--, Plus_Matchesgifts  /*Delete from source 5/15/17*/
			--, New_GraduateProfessional  /*Delete from source 5/15/17*/
			--, New_AlumniAssociation  /*Delete from source 5/15/17*/
			--, New_Athletics  /*Delete from source 5/15/17*/
			--, New_FourYear  /*Delete from source 5/15/17*/
			, CONVERT(NVARCHAR(3000),Description) AS Description
			, DoNotPostalMail
			, DoNotBulkPostalMail
			, DoNotEmail
			, DoNotBulkEmail
			, DoNotPhone
			, DoNotFax
			, AccountClassificationCode
			, New_RetireeRatio
			, New_SplitRatio
			, New_MatchingRatio
			, PreferredContactMethodCode
			, Plus_CoordinatingLiaison
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_MatchingGiftProgram
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, CASE WHEN DATENAME(dy,A.Lds_QualifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Lds_QualifiedOn)
					ELSE DATEADD(hh,-7,A.Lds_QualifiedOn) END AS Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Account'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_AccountBase_New_LdspId'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_AccountBase_New_LdspId;
					CREATE TABLE Check_AccountBase_New_LdspId (
						New_LdspId NVARCHAR(100)
						, Characters_Present NVARCHAR(1)
						, Digit_Count_Not_9 NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_AccountBase_New_LdspId (
						New_LdspId
						, Characters_Present
						, Digit_Count_Not_9
						, Record_Deleted
					)
					SELECT *
						FROM (SELECT New_LdspId
								, CASE WHEN ISNUMERIC(New_LdspId) = 1 
											AND PATINDEX(''%[+,$]%'',New_LdspId) = 0 -- Characters not picked up by ISNUMERIC
											AND CONVERT(INT,New_LdspId) > 0 -- Not a negative number
										THEN ''N'' 
										ELSE ''Y'' END AS Characters_Present
								, CASE WHEN LEN(New_LdspId) = 9 
										THEN ''N''
										ELSE ''Y'' END AS Digit_Count_Not_9
								, ''N'' AS Record_Deleted
								FROM AccountBase
							) A
						WHERE 1 = 1
							AND (Characters_Present = ''Y''
									OR Digit_Count_Not_9 = ''Y''
									--OR New_LdspId = ''003416119'' ----->  FOR TESTING  <-----
								)
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Account T
						USING (
								SELECT DISTINCT New_LdspId
								FROM Check_AccountBase_New_LdspId
							) S ON T.New_LdspId = S.New_LdspId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_AccountBase_New_LdspId T
						USING (
								SELECT DISTINCT A.New_LdspId
									FROM Check_AccountBase_New_LdspId A
										LEFT JOIN Ext_Account B ON A.New_LdspId = B.New_LdspId
									WHERE 1 = 1
										AND B.New_LdspId IS NULL
							) S ON T.New_LdspId = S.New_LdspId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(New_LdspId) FROM Check_AccountBase_New_LdspId)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)
								SET @Check_Xml = CAST((SELECT New_LdspId AS ''td'','''', Characters_Present AS ''td'','''', Digit_Count_Not_9 AS ''td'','''', Record_Deleted AS ''td'' FROM Check_AccountBase_New_LdspId ORDER BY New_LdspId DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_LdspId </th> <th> Characters_Present </th> <th> Digit_Count_Not_9 </th> <th> Record_Deleted </th> </tr>''    
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check AccountBase New_LdspId''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_AccountBase_New_LdspId''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_AccountBase_New_LdspId.csv''
									, @query_result_separator = ''^''
							END
				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_AccountBase_New_LdspId)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_4
		, '
			' -- Attribute_5
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Account'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_AccountBase_AccountId'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_AccountBase_AccountId;
					CREATE TABLE Check_AccountBase_AccountId (
						AccountId NVARCHAR(100)
						, Is_Null NVARCHAR(1)
						, Duplicate_Record NVARCHAR(1)
						, Records_Cnt INT
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_AccountBase_AccountId (
						AccountId
						, Is_Null
						, Duplicate_Record
						, Records_Cnt
						, Record_Deleted
					)
					SELECT AccountId
						, Is_Null
						, CASE WHEN Is_Null = ''N'' THEN ''Y'' ELSE ''N'' END AS Duplicate_Record
						, CASE WHEN Is_Null = ''N'' THEN Cnt + 1 ELSE Cnt END AS Records_Cnt
						, ''N'' AS Records_Deleted
						FROM
							(SELECT AccountId
								, CASE WHEN AccountId = ''NULL'' THEN ''Y'' ELSE ''N'' END AS Is_Null
								, COUNT(AccountId) AS Cnt	
								FROM 
									(SELECT ROW_NUMBER() OVER(ORDER BY (SELECT NULL)) AS Row_Num
										, CASE WHEN AccountId IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),AccountId) END AS AccountId
										, LAG(AccountId) OVER(ORDER BY AccountId) AS Previous_AccountId
										, New_LdspId
										, Name
										FROM AccountBase
									) A
								WHERE 1 = 1
									AND (AccountId = CONVERT(NVARCHAR(36),Previous_AccountId)
											OR AccountId = ''NULL''
										)
								GROUP BY AccountId
									, CASE WHEN AccountId = ''NULL'' THEN ''Y'' ELSE ''N'' END
							) A
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_6
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Account T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,AccountId) AS AccountId
								FROM Check_AccountBase_AccountId
								WHERE 1 = 1 
									AND AccountId != ''NULL''
							) S ON T.AccountId = S.AccountId
						WHEN MATCHED THEN 
							DELETE
								;
					DELETE FROM Ext_Account
						WHERE 1 = 1
							AND AccountId IS NULL;
					-- Update Check Table
					MERGE INTO Check_AccountBase_AccountId T
						USING (
								SELECT DISTINCT A.AccountId
									FROM Check_AccountBase_AccountId A
										LEFT JOIN Ext_Account B ON A.AccountId = CONVERT(NVARCHAR(100),B.AccountId)
									WHERE 1 = 1
										AND (B.AccountId IS NULL
												OR A.AccountId = ''NULL'')
							) S ON T.AccountId = S.AccountId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_7
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_AccountBase_AccountId)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)
								SET @Check_Xml = CAST((SELECT AccountId AS ''td'','''', Is_Null AS ''td'','''', Duplicate_Record AS ''td'','''', Records_Cnt AS ''td'','''', Record_Deleted AS ''td'' FROM Check_AccountBase_AccountId ORDER BY AccountId DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> AccountId </th> <th> Is_Null </th> <th> Duplicate_Record </th> <th> Records_Cnt </th> <th> Record_Deleted </th> </tr>''    	 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check AccountBase AccountId''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_AccountBase_AccountId''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_AccountBase_AccountId.csv''
									, @query_result_separator = ''^''
					END
					
				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_AccountBase_AccountId)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_8
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Account'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_AccountBase_Null_Columns'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_AccountBase_Null_Columns;
					CREATE TABLE Check_AccountBase_Null_Columns (
						Column_Name NVARCHAR(100)
						, Is_No_Longer_Null NVARCHAR(1)
						, Records_Cnt INT
					)
					INSERT INTO Check_AccountBase_Null_Columns (
						Column_Name 
						, Is_No_Longer_Null
						, Records_Cnt
					)
					SELECT Column_Name
						, Is_No_Longer_Null
						, Record_Cnt
						FROM 
							(SELECT CASE WHEN Record_Cnt > 0 THEN Column_Name ELSE NULL END AS Column_Name
								, CASE WHEN Record_Cnt > 0 THEN ''Y'' ELSE NULL END AS Is_No_Longer_Null
								, CASE WHEN Record_Cnt > 0 THEN Record_Cnt ELSE NULL END AS Record_Cnt
								FROM 
									(SELECT ''Description'' AS Column_Name
										, COUNT(*) AS Record_Cnt
										FROM Ext_Account
										WHERE 1 = 1
											AND Description IS NOT NULL
									UNION
									SELECT ''New_SplitRatio'' AS Column_Name
										, COUNT(*) AS Record_Cnt
										FROM Ext_Account
										WHERE 1 = 1
											AND New_SplitRatio IS NOT NULL
									UNION
									SELECT ''Plus_PendingLiaison'' AS Column_Name
										, COUNT(*) AS Record_Cnt
										FROM Ext_Account
										WHERE 1 = 1
											AND Plus_PendingLiaison IS NOT NULL
									) A
							) A
						WHERE 1 = 1
							AND Column_Name IS NOT NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_9
		, ' ' -- Attribute_10
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_AccountBase_Null_Columns)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There is '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' column that has started to be populated.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There are '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' columns that have started to be populated.''
									END
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT Column_Name AS ''td'','''', Is_No_Longer_Null AS ''td'','''', Records_Cnt AS ''td'' FROM Check_AccountBase_Null_Columns ORDER BY Records_Cnt DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> Column_Name </th> <th> Is_No_Longer_Null </th> <th> Records_Cnt </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check AccountBase AccountId''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_AccountBase_Null_Columns''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_AccountBase_Null_Columns.csv''
									, @query_result_separator = ''^''
					END
					
				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_AccountBase_Null_Columns)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Account'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''1H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1; 
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Account''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ACTIVITY (Ext_Activity)
-- --------------------------
	('Activity' -- Dim_Object
		, 'Ext_Activity' -- Table_Name
		, 'ActivityPartyId UNIQUEIDENTIFIER
			, ActivityId UNIQUEIDENTIFIER
			, PartyId UNIQUEIDENTIFIER
			, PartyObjectTypeCode INT
			, ScheduledStart DATETIME
			, PartyIdName NVARCHAR(4000)
			, ParticipationTypeMask INT
			' -- Create_Fields
		, 'ActivityPartyId
			, ActivityId
			, PartyId
			, PartyObjectTypeCode
			, ScheduledStart
			, PartyIdName
			, ParticipationTypeMask
			' -- Insert_Fields
		, 'ActivityPartyBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ScheduledStart) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityPartyId
			, ActivityId
			, PartyId
			, PartyObjectTypeCode
			, CASE WHEN DATENAME(dy,A.ScheduledStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledStart)
					ELSE DATEADD(hh,-7,A.ScheduledStart) END AS ScheduledStart
			, PartyIdName
			, ParticipationTypeMask
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Activity'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''2H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Activity''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ACTIVITY_POINTER (Ext_Activity_Pointer)
-- --------------------------
	('Activity' -- Dim_Object
		, 'Ext_Activity_Pointer' -- Table_Name
		, 'ActivityId UNIQUEIDENTIFIER
			, ActivityTypeCode INT
			, RegardingObjectTypeCode INT
			, ScheduledStart DATETIME
			, ScheduledEnd DATETIME
			, ActualStart DATETIME
			, ActualEnd DATETIME
			, RegardingObjectId UNIQUEIDENTIFIER
			, Subject NVARCHAR(200)
			, RegardingObjectIdName NVARCHAR(4000)
			, Description NVARCHAR(4000)
			, OwnerId UNIQUEIDENTIFIER
			, CampactChannelTypeCode INT
			, CreatedOn DATETIME
			, StateCode INT
			, StatusCode INT
			, ModifiedOn DATETIME
			' -- Create_Fields
		, 'ActivityId
			, ActivityTypeCode
			, RegardingObjectTypeCode
			, ScheduledStart
			, ScheduledEnd
			, ActualStart
			, ActualEnd
			, RegardingObjectId
			, Subject
			, RegardingObjectIdName
			, Description
			, OwnerId
			, CampactChannelTypeCode
			, CreatedOn
			, StateCode
			, StatusCode
			, ModifiedOn
			' -- Insert_Fields
		, 'ActivityPointerBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ScheduledStart) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.ScheduledEnd) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.ActualStart) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.ActualEnd) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.CreatedOn) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.ModifiedOn) = G.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityId
			, ActivityTypeCode
			, RegardingObjectTypeCode
			, CASE WHEN DATENAME(dy,A.ScheduledStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledStart)
					ELSE DATEADD(hh,-7,A.ScheduledStart) END AS ScheduledStart
			, CASE WHEN DATENAME(dy,A.ScheduledEnd) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ScheduledEnd)
					ELSE DATEADD(hh,-7,A.ScheduledEnd) END AS ScheduledEnd
			, CASE WHEN DATENAME(dy,A.ActualStart) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ActualStart)
					ELSE DATEADD(hh,-7,A.ActualStart) END AS ActualStart
			, CASE WHEN DATENAME(dy,A.ActualEnd) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ActualEnd)
					ELSE DATEADD(hh,-7,A.ActualEnd) END AS ActualEnd
			, RegardingObjectId
			, Subject
			, RegardingObjectIdName
			, CONVERT(NVARCHAR(4000),Description) AS Description
			, OwnerId
			, CampactChannelTypeCode
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS CreatedOn
			, StateCode
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Activity_Pointer'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''3H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Activity_Pointer''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ADDRESS (Ext_Address)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_Address' -- Table_Name
		, 'Plus_RelatedContact  UNIQUEIDENTIFIER
			, New_Primary BIT
			, New_Street1 NVARCHAR(100)
			, New_Street2 NVARCHAR(100)
			, New_Street3 NVARCHAR(100)
			, New_Zip4 NVARCHAR(15)
			, Plus_AddressDisplay NVARCHAR(300)
			, Plus_Longitude FLOAT
			, Plus_Latitude FLOAT
			, StateCode INT
			--, New_Confirmed BIT  /*Delete from source 5/15/17*/
			--, New_Undeliverable BIT  /*Delete from source 5/15/17*/
			, New_Confidential BIT
			, New_CityLookUp UNIQUEIDENTIFIER
			, New_CountyId UNIQUEIDENTIFIER
			, New_StatesProvinces UNIQUEIDENTIFIER
			, New_CountryRegions UNIQUEIDENTIFIER
			, New_PostalCodes UNIQUEIDENTIFIER
			, Plus_OneAccordQuality INT
			--, Plus_ConfidentialInstruction INT  /*Delete from source 5/15/17*/ 
			, New_AddressType INT
			, New_AddressId UNIQUEIDENTIFIER
			, New_ConfirmedDate DATETIME
			, Plus_ForeignPostalCode NVARCHAR(100)
			, Lds_PostalCode NVARCHAR(100)
			, Lds_StateProvince NVARCHAR(100)
			, Lds_County NVARCHAR(100)
			, Lds_City NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_RelatedContact
			, New_Primary
			, New_Street1
			, New_Street2
			, New_Street3
			, New_Zip4
			, Plus_AddressDisplay
			, Plus_Longitude
			, Plus_Latitude
			, StateCode
			--, New_Confirmed /*Delete from source 5/15/17*/
			--, New_Undeliverable  /*Delete from source 5/15/17*/
			, New_Confidential
			, New_CityLookUp
			, New_CountyId
			, New_StatesProvinces
			, New_CountryRegions
			, New_PostalCodes
			, Plus_OneAccordQuality
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, New_AddressType
			, New_AddressId
			, New_ConfirmedDate
			, Plus_ForeignPostalCode
			, Lds_PostalCode
			, Lds_StateProvince
			, Lds_County
			, Lds_City
			' -- Insert_Fields
		, 'New_AddressBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'COALESCE(Plus_RelatedContact,Plus_RelatedAccount) AS Plus_RelatedContact
			, New_Primary
			, New_Street1
			, New_Street2
			, New_Street3
			, New_Zip4
			, CONVERT(NVARCHAR(300),Plus_AddressDisplay) AS Plus_AddressDisplay
			, Plus_Longitude
			, Plus_Latitude
			, StateCode
			--, New_Confirmed  /*Delete from source 5/15/17*/
			--, New_Undeliverable  /*Delete from source 5/15/17*/
			, New_Confidential
			, New_CityLookUp
			, New_CountyId
			, New_StatesProvinces
			, New_CountryRegions
			, New_PostalCodes
			, Plus_OneAccordQuality
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, New_AddressType
			, New_AddressId
			, New_ConfirmedDate
			, Plus_ForeignPostalCode
			, Lds_PostalCode
			, Lds_StateProvince
			, Lds_County
			, Lds_City
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Address'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_AddressBase_Orphans'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_AddressBase_Orphans;
					CREATE TABLE Check_New_AddressBase_Orphans (
						New_AddressId NVARCHAR(100)
						, Plus_RelatedContact NVARCHAR(100)
						, Plus_RelatedAccount NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, Is_Orphaned NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_AddressBase_Orphans (
						New_AddressId
						, Plus_RelatedContact
						, Plus_RelatedAccount
						, New_Primary
						, Is_Orphaned
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_AddressId) AS New_AddressId
						, CASE WHEN CONVERT(NVARCHAR(100),Plus_RelatedContact) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),Plus_RelatedContact) END AS Plus_RelatedContact
						, CASE WHEN CONVERT(NVARCHAR(100),Plus_RelatedAccount) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),Plus_RelatedAccount) END AS Plus_RelatedAccount
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, ''Y'' AS Is_Orphaned
						, ''N'' AS Record_Deleted
						FROM New_AddressBase
						WHERE 1 = 1
							AND Plus_RelatedContact IS NULL
							AND Plus_RelatedAccount IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Address T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_AddressId) AS New_AddressId
								FROM Check_New_AddressBase_Orphans
								WHERE 1 = 1 
									AND New_AddressId != ''NULL''
							) S ON T.New_AddressId = S.New_AddressId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_AddressBase_Orphans T
						USING (
								SELECT DISTINCT A.New_AddressId
									FROM Check_New_AddressBase_Orphans A
										LEFT JOIN Ext_Address B ON A.New_AddressId = CONVERT(NVARCHAR(100),B.New_AddressId)
									WHERE 1 = 1
										AND (B.New_AddressId IS NULL
												OR A.New_AddressId = ''NULL'')
							) S ON T.New_AddressId = S.New_AddressId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_4
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_AddressBase_Orphans)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_AddressId AS ''td'','''', Plus_RelatedContact AS ''td'','''', Plus_RelatedAccount AS ''td'','''', New_Primary AS ''td'','''', Is_Orphaned AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_AddressBase_Orphans ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_AddressId </th> <th> Plus_RelatedContact </th> <th> Plus_RelatedAccount </th> <th> New_Primary </th> <th> Is_Orphaned </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_AddressBase Orphans''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_AddressBase_Orphans''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_AddressBase_Orphans.csv''
									, @query_result_separator = ''^''
							END
					
				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_AddressBase_Orphans)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_5
		, '	
			' -- Attribute_6
		, ' 
			' -- Attribute_7
		, '
			' -- Attribute_8
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Address'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_AddressBase_New_Confidential'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_AddressBase_New_Confidential;
					CREATE TABLE Check_New_AddressBase_New_Confidential (
						New_AddressId NVARCHAR(100)
						, Plus_RelatedContact NVARCHAR(100)
						, Plus_RelatedAccount NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, New_Confidential NVARCHAR(100)
						, Is_Null NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_AddressBase_New_Confidential (
						New_AddressId
						, Plus_RelatedContact
						, Plus_RelatedAccount
						, New_Primary
						, New_Confidential
						, Is_Null
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_AddressId) AS New_AddressId
						, CASE WHEN CONVERT(NVARCHAR(100),Plus_RelatedContact) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),Plus_RelatedContact) END AS Plus_RelatedContact
						, CASE WHEN CONVERT(NVARCHAR(100),Plus_RelatedAccount) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),Plus_RelatedAccount) END AS Plus_RelatedAccount
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, New_Confidential
						, ''Y'' AS Is_Null
						, ''N'' AS Record_Deleted
						FROM New_AddressBase
						WHERE 1 = 1
							AND New_Confidential IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_9
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Address T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_AddressId) AS New_AddressId
								FROM Check_New_AddressBase_New_Confidential
								WHERE 1 = 1 
									AND New_AddressId != ''NULL''
							) S ON T.New_AddressId = S.New_AddressId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_AddressBase_New_Confidential T
						USING (
								SELECT DISTINCT A.New_AddressId
									FROM Check_New_AddressBase_New_Confidential A
										LEFT JOIN Ext_Address B ON A.New_AddressId = CONVERT(NVARCHAR(100),B.New_AddressId)
									WHERE 1 = 1
										AND (B.New_AddressId IS NULL
												OR A.New_AddressId = ''NULL'')
							) S ON T.New_AddressId = S.New_AddressId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_10
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_AddressBase_New_Confidential)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END						
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_AddressId AS ''td'','''', Plus_RelatedContact AS ''td'','''', Plus_RelatedAccount AS ''td'','''', New_Primary AS ''td'','''', New_Confidential AS ''td'','''', Is_Null AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_AddressBase_New_Confidential ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_AddressId </th> <th> Plus_RelatedContact </th> <th> Plus_RelatedAccount </th> <th> New_Primary </th> <th> New_Confidential </th> <th> Is_Null </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_AddressBase New_Confidential''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_AddressBase_New_Confidential''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_AddressBase_New_Confidential.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_AddressBase_New_Confidential)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_11
		, '	
			' -- Attribute_12
		, ' 
			' -- Attribute_13
		, '
			' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Address'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''4H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Address''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ADDRESSFORMAT (Ext_Address_Format)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_Address_Format' -- Table_Name
		, 'Plus_AddressFormatId UNIQUEIDENTIFIER
			, New_UseStateAbreviation BIT
			' -- Create_Fields
		, 'Plus_AddressFormatId
			, New_UseStateAbreviation
			' -- Insert_Fields
		, 'Plus_AddressFormatBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_AddressFormatId
			, New_UseStateAbreviation
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Address_Format'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''5H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Address_Format''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Alumni (Ext_Alumni)
-- --------------------------
	('Ext_Alumni' -- Dim_Object
		, 'Ext_Alumni' -- Table_Name
		, 'Plus_AlumniId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			, Plus_ActualGraduationDate DATETIME
			, Plus_AlumniStatus INT
			, Plus_DgId INT
			, Plus_HoursCredits NVARCHAR(100)
			, Plus_PreferredGraduationDate DATETIME
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_College UNIQUEIDENTIFIER
			, Plus_Degree UNIQUEIDENTIFIER
			, Plus_University UNIQUEIDENTIFIER
			, Plus_Source UNIQUEIDENTIFIER
			, Plus_Program UNIQUEIDENTIFIER
			, Plus_Emphasis UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'Plus_AlumniId 
			, Plus_Name
			, Plus_ActualGraduationDate
			, Plus_AlumniStatus
			, Plus_DgId
			, Plus_HoursCredits
			, Plus_PreferredGraduationDate
			, Plus_Constituent
			, Plus_College
			, Plus_Degree
			, Plus_University
			, Plus_Source
			, Plus_Program
			, Plus_Emphasis
			' -- Insert_Fields
		, 'Plus_AlumniBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_ActualGraduationDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_PreferredGraduationDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_AlumniId 
			, Plus_Name
			, CASE WHEN DATENAME(dy,A.Plus_ActualGraduationDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ActualGraduationDate)
					ELSE DATEADD(hh,-7,A.Plus_ActualGraduationDate) END AS Plus_ActualGraduationDate
			, Plus_AlumniStatus
			, Plus_DgId
			, Plus_HoursCredits
			, CASE WHEN DATENAME(dy,A.Plus_PreferredGraduationDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PreferredGraduationDate)
					ELSE DATEADD(hh,-7,A.Plus_PreferredGraduationDate) END AS Plus_PreferredGraduationDate
			, Plus_Constituent
			, Plus_College
			, Plus_Degree
			, Plus_University
			, Plus_Source
			, Plus_Program
			, Plus_Emphasis
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Alumni'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_Plus_AlumniBase_Plus_Constituent'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_Plus_AlumniBase_Plus_Constituent;
					CREATE TABLE Check_Plus_AlumniBase_Plus_Constituent (
						Plus_AlumniId NVARCHAR(100)
						, Plus_Constituent NVARCHAR(100)
						, Is_Null NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_Plus_AlumniBase_Plus_Constituent (
						Plus_AlumniId
						, Plus_Constituent
						, Is_Null
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),Plus_AlumniId) AS Plus_AlumniId
						, CASE WHEN CONVERT(NVARCHAR(100),Plus_Constituent) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),Plus_Constituent) END AS Plus_Constituent
						, ''Y'' AS Is_Null
						, ''N'' AS Record_Deleted
						FROM Plus_AlumniBase
						WHERE 1 = 1
							AND Plus_Constituent IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Alumni T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,Plus_AlumniId) AS Plus_AlumniId
								FROM Check_Plus_AlumniBase_Plus_Constituent
								WHERE 1 = 1 
									AND Plus_AlumniId != ''NULL''
							) S ON T.Plus_AlumniId = S.Plus_AlumniId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_Plus_AlumniBase_Plus_Constituent T
						USING (
								SELECT DISTINCT A.Plus_AlumniId
									FROM Check_Plus_AlumniBase_Plus_Constituent A
										LEFT JOIN Ext_Alumni B ON A.Plus_AlumniId = CONVERT(NVARCHAR(100),B.Plus_AlumniId)
									WHERE 1 = 1
										AND (B.Plus_AlumniId IS NULL 
												OR A.Plus_AlumniId = ''NULL'')
							) S ON T.Plus_AlumniId = S.Plus_AlumniId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_4
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)

					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_Plus_AlumniBase_Plus_Constituent)

						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END
							

								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)
								
								SET @Check_Xml = CAST((SELECT Plus_AlumniId AS ''td'','''', Plus_Constituent AS ''td'','''', Is_Null AS ''td'','''', Record_Deleted AS ''td'' FROM Check_Plus_AlumniBase_Plus_Constituent 
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))
									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> Plus_AlumniId </th> <th> Plus_Constituent </th> <th> Is_Null </th> <th> Record_Deleted </th> </tr>''    
										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''
								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check Plus_AlumniBase Plus_Constituent''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_Plus_AlumniBase_Plus_Constituent''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_Plus_AlumniBase_Plus_Constituent.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_Plus_AlumniBase_Plus_Constituent)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Alumni'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''6H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Alumni''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- APPOINTMENT BASE (Ext_Appointment)
-- --------------------------
	('Activity' -- Dim_Object
		, 'Ext_Appointment' -- Table_Name
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_FaceToFace BIT
			' -- Create_Fields
		, 'ActivityId
			, Plus_FaceToFace
			' -- Insert_Fields
		, 'AppointmentBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityId
			, Plus_FaceToFace
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Appointment'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''7H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Appointment''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ASSOCIATION (Ext_Association)
-- --------------------------
	('Association' -- Dim_Object
		, 'Ext_Association' -- Table_Name
		, 'New_AssociationId UNIQUEIDENTIFIER
			, New_ShortName NVARCHAR(100)
			, New_Acronym NVARCHAR(100)
			, New_Region NVARCHAR(100)
			, New_ChapterLevel NVARCHAR(100)
			, StateCode INT
			, New_Type INT
			, New_Sponsor INT
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_AssociationId
			, New_ShortName
			, New_Acronym
			, New_Region
			, New_ChapterLevel
			, StateCode
			, New_Type
			, New_Sponsor
			, New_Name
			' -- Insert_Fields
		, 'New_AssociationBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_AssociationId
			, New_ShortName
			, New_Acronym
			, New_Region
			, New_ChapterLevel
			, StateCode
			, New_Type
			, New_Sponsor
			, New_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Association'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''8H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Association''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- ASSOCIATION MEMBERSHIP (Ext_Association_Membership)
-- --------------------------
	('Association' -- Dim_Object
		, 'Ext_Association_Membership' -- Table_Name
		, 'New_AssociationMembershipId UNIQUEIDENTIFIER
			, New_ConstituentId  UNIQUEIDENTIFIER
			, New_Association UNIQUEIDENTIFIER
			, New_StartDate DATETIME
			, New_EndDate DATETIME
			, StatusCode INT
			, New_RelatedOrganization UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_AssociationMembershipId
			, New_ConstituentId
			, New_Association
			, New_StartDate
			, New_EndDate
			, StatusCode
			, New_RelatedOrganization
			' -- Insert_Fields
		, 'New_AssociationMembershipBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_AssociationMembershipId
			, New_ConstituentId
			, New_Association
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, StatusCode
			, New_RelatedOrganization
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Association_Membership'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''9H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Association_Membership''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- AWARD (Ext_Recognition_Association)
-- --------------------------
	('Award' -- Dim_Object
		, 'Ext_Recognition_Association' -- Table_Name
		, 'New_RecognitionAssociationId UNIQUEIDENTIFIER
			, New_Constituent UNIQUEIDENTIFIER
			, New_EndDate DATETIME
			, New_StartDate DATETIME
			, Plus_ScholarshipOfferedAmount MONEY
			, Plus_ScholarshipAwardTerm NVARCHAR(15)
			, Plus_ScholarshipGrantingOffice NVARCHAR(25)
			, Plus_ScholarshipAwardDate DATETIME
			, Plus_ScholarshipCode NVARCHAR(100)
			, New_Recognition UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_RecognitionAssociationId
			, New_Constituent
			, New_EndDate
			, New_StartDate
			, Plus_ScholarshipOfferedAmount
			, Plus_ScholarshipAwardTerm
			, Plus_ScholarshipGrantingOffice
			, Plus_ScholarshipAwardDate
			, Plus_ScholarshipCode
			, New_Recognition
			' -- Insert_Fields
		, 'New_RecognitionAssociationBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_EndDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_StartDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_ScholarshipAwardDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_RecognitionAssociationId
			, New_Constituent
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, Plus_ScholarshipOfferedAmount
			, Plus_ScholarshipAwardTerm
			, Plus_ScholarshipGrantingOffice
			, CASE WHEN DATENAME(dy,A.Plus_ScholarshipAwardDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ScholarshipAwardDate)
					ELSE DATEADD(hh,-7,A.Plus_ScholarshipAwardDate) END AS Plus_ScholarshipAwardDate
			, Plus_ScholarshipCode
			, New_Recognition
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Recognition_Association'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''10H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Recognition_Association''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Campaign (Ext_Campaign)
-- --------------------------
	('Extract' -- Dim_Object
		, 'Ext_Campaign' -- Table_Name
		, 'CampaignId UNIQUEIDENTIFIER
			, Name NVARCHAR(128)
			, Type_Code	INT			
			, StatusCode INT
			, Plus_Affiliate INT
			, Plus_Requestor NVARCHAR(100)
			, Plus_Association UNIQUEIDENTIFIER
			, Plus_DepartmentFunction INT	
			, Plus_Cause INT		
			, Description NVARCHAR(4000)
			, BudgetedCost_Base NVARCHAR(50)
			, ExpectedRevenue NVARCHAR(50)
			, OtherCost NVARCHAR(50)
			, TotalCampaignActivityActualCost NVARCHAR(50)
			, TotalActualCost NVARCHAR(50)
			, Plus_CostToRaise1_Base NVARCHAR(50)
			, Plus_TotalGiftRevenueFromCampaign NVARCHAR(50)
			, Plus_CampaignProfit_Base NVARCHAR(50)
			' -- Create_Fields
		, 'CampaignId
			, Name
			, Type_Code			
			, StatusCode
			, Plus_Affiliate
			, Plus_Requestor
			, Plus_Association
			, Plus_DepartmentFunction	
			, Plus_Cause		
			, Description
			, BudgetedCost_Base
			, ExpectedRevenue
			, OtherCost
			, TotalCampaignActivityActualCost
			, TotalActualCost
			, Plus_CostToRaise1_Base
			, Plus_TotalGiftRevenueFromCampaign
			, Plus_CampaignProfit_Base
			' -- Insert_Fields
		, 'CampaignBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'CampaignId
			, Name
			, TypeCode			
			, StatusCode
			, Plus_Affiliate
			, NULL AS Plus_Requestor
			, Plus_Association
			, Plus_DepartmentFunction	
			, Plus_Cause		
			, CONVERT(NVARCHAR(4000),Description) AS Description
			, CONVERT(NVARCHAR(50),BudgetedCost_Base) AS BudgetedCost_Base
			, CONVERT(NVARCHAR(50),ExpectedRevenue) AS ExpectedRevenue
			, CONVERT(NVARCHAR(50),OtherCost) AS OtherCost
			, CONVERT(NVARCHAR(50),TotalCampaignActivityActualCost) AS TotalCampaignActivityActualCost
			, CONVERT(NVARCHAR(50),TotalActualCost) AS TotalActualCost
			, CONVERT(NVARCHAR(50),Plus_CostToRaise1_Base) AS Plus_CostToRaise1_Base
			, CONVERT(NVARCHAR(50),Plus_TotalGiftRevenueFromCampaign) AS Plus_TotalGiftRevenueFromCampaign
			, CONVERT(NVARCHAR(50),Plus_CampaignProfit_Base) AS Plus_CampaignProfit_Base
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Campaign'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''11H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Campaign''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Campaign_Activity (Ext_Campaign_Activity)
-- --------------------------
	('Extract' -- Dim_Object
		, 'Ext_Campaign_Activity' -- Table_Name
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_InstitutionalHierarchy UNIQUEIDENTIFIER
			--, Plus_AppealLongName NVARCHAR(100)  /*Delete from source 5/15/17*/
			, Plus_AppealCode NVARCHAR(20)
			, Plus_CommunicationType INT
			, Plus_Format INT
			' -- Create_Fields
		, 'ActivityId
			, Plus_InstitutionalHierarchy
			--, Plus_AppealLongName  /*Delete from source 5/15/17*/
			, Plus_AppealCode
			, Plus_CommunicationType
			, Plus_Format
			' -- Insert_Fields
		, 'CampaignActivityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityId
			, Plus_InstitutionalHierarchy
			--, Plus_AppealLongName  /*Delete from source 5/15/17*/
			, Plus_AppealCode
			, Plus_CommunicationType
			, Plus_Format
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Campaign_Activity'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''12H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Campaign_Activity''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- College (Ext_College)
-- --------------------------
	('Ext_College' -- Dim_Object
		, 'Ext_College' -- Table_Name
		, 'New_CollegeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_CollegeCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_CollegeId
			, New_Name
			, New_CollegeCode
			' -- Insert_Fields
		, 'New_CollegeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_CollegeId
			, New_Name
			, New_CollegeCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_College'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''13H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_College''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CITY (Ext_City)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_City' -- Table_Name
		, 'New_CityId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_CityId
			, New_Name
			' -- Insert_Fields
		, 'New_CityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_CityId
			, New_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_City'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''14H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_City''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Connection (Ext_Connection)
-- --------------------------
	('Connection' -- Dim_Object
		, 'Ext_Connection' -- Table_Name
		, 'Record1Id UNIQUEIDENTIFIER
			, Record2Id UNIQUEIDENTIFIER
			, Plus_AlternateName NVARCHAR(100)
			, Record1RoleId UNIQUEIDENTIFIER
			, Record2RoleId UNIQUEIDENTIFIER
			, Record1ObjectTypeCode INT
			, Record2ObjectTypeCode INT
			, ConnectionId UNIQUEIDENTIFIER
			, Record1IdObjectTypeCode INT
			, Record2IdObjectTypeCode INT
			' -- Create_Fields
		, 'Record1Id
			, Record2Id
			, Plus_AlternateName
			, Record1RoleId
			, Record2RoleId
			, Record1ObjectTypeCode
			, Record2ObjectTypeCode
			, ConnectionId
			, Record1IdObjectTypeCode
			, Record2IdObjectTypeCode
			' -- Insert_Fields
		, 'ConnectionBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Record1Id
			, Record2Id
			, Plus_AlternateName
			, Record1RoleId
			, Record2RoleId
			, Record1ObjectTypeCode
			, Record2ObjectTypeCode
			, ConnectionId
			, Record1IdObjectTypeCode
			, Record2IdObjectTypeCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Connection'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''15H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Connection''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Connection_Role (Ext_Connection_Role)
-- --------------------------
	('Connection' -- Dim_Object
		, 'Ext_Connection_Role' -- Table_Name
		, 'ConnectionRoleId UNIQUEIDENTIFIER
			, Name NVARCHAR(100)
			, OverwriteTime DATETIME
			' -- Create_Fields
		, 'ConnectionRoleId
			, Name
			, OverwriteTime
			' -- Insert_Fields
		, 'ConnectionRoleBase
			WHERE 1 = 1
				AND OverwriteTime = ''1900-01-01 00:00:00.000''
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ConnectionRoleId
			, Name
			, OverwriteTime
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Connection_Role'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''16H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Connection_Role''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CONTACT (Ext_Contact)
-- --------------------------
	('Contact' -- Dim_Object
		, 'Ext_Contact' -- Table_Name
		, 'ContactId UNIQUEIDENTIFIER
			, New_Ldspid NVARCHAR(100)
			, Plus_CoordinatingLiaison UNIQUEIDENTIFIER
			, FullName NVARCHAR(160)
			, FirstName NVARCHAR(50)
			, MiddleName NVARCHAR(50)
			, LastName NVARCHAR(50)
			, NickName NVARCHAR(50)
			, New_MiddleName2 NVARCHAR(100)
			, New_LastName2 NVARCHAR(100)
			, New_PreferredName NVARCHAR(100)
			, Plus_DisplayName NVARCHAR(100)
			, New_BirthName NVARCHAR(100)
			, Plus_CurrentStudent BIT
			, New_BirthDate NVARCHAR(100)
			, New_BirthdateDay NVARCHAR(100)
			, New_BirthdateMonth NVARCHAR(100)
			, New_BirthdateYear NVARCHAR(100)
			, New_Deceased BIT
			, New_DeceasedDate NVARCHAR(100)
			, New_DeceasedDay NVARCHAR(100)
			, New_DeceasedMonth NVARCHAR(100)
			, New_DeceasedYear NVARCHAR(100)
			, Plus_WealthDate DATETIME
			, SpousesName NVARCHAR(100)
			, New_Title UNIQUEIDENTIFIER
			, New_ProfessionalSuffix UNIQUEIDENTIFIER
			, New_HomeCountry UNIQUEIDENTIFIER
			, GenderCode INT
			, FamilyStatusCode INT
			--, New_Ethnicity INT  /*Delete from source 5/15/17*/
			, Plus_ChurchMember INT
			, New_PersonalSuffix INT
			, StatusCode INT
			, New_MajorGiftPropensity1 INT
			, Plus_AnnualGift1 INT
			, Plus_PlannedGift INT
			, Plus_GiftCapacityEnp INT
			, Plus_GiftCapacityEn INT
			, Plus_PhilanthropicCapacityRatingPcr INT
			, Plus_EstimatedHouseHoldIncome INT
			, Plus_EstimatedHomemarketValue INT
			, Plus_BlockClusters INT
			, Plus_PlannedGiftTier INT
			, Plus_PreferredFirstName NVARCHAR(100)
			, Plus_PreferredMiddleName NVARCHAR(100)
			, Plus_PreferredLastName NVARCHAR(100)
			, Plus_PreferredFullName NVARCHAR(100)
			, Plus_SpousePreferredFirstName NVARCHAR(100)
			, Plus_SpousePreferredMiddleName NVARCHAR(100)
			, Plus_SpousePreferredLastName NVARCHAR(100)
			, Plus_SpousePreferredFullName NVARCHAR(100)
			, Plus_ConnectedLiaison UNIQUEIDENTIFIER
			, Plus_PendingLiaison UNIQUEIDENTIFIER
			, Plus_I5TextLinesLdsp NVARCHAR(4000)
			, Plus_TotalGivenLast5Years MONEY
			, Lds_IsQualified BIT
			, Lds_QualifiedOn DATETIME
			, Lds_QualifiedBy UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ContactId
			, New_Ldspid
			, Plus_CoordinatingLiaison
			, FullName
			, FirstName
			, MiddleName
			, LastName
			, NickName
			, New_MiddleName2
			, New_LastName2
			, New_PreferredName
			, Plus_DisplayName
			, New_BirthName
			, Plus_CurrentStudent
			, New_BirthDate
			, New_BirthdateDay
			, New_BirthdateMonth
			, New_BirthdateYear
			, New_Deceased
			, New_DeceasedDate
			, New_DeceasedDay
			, New_DeceasedMonth
			, New_DeceasedYear
			, Plus_WealthDate
			, SpousesName
			, New_Title
			, New_ProfessionalSuffix
			, New_HomeCountry
			, GenderCode
			, FamilyStatusCode
			--, New_Ethnicity  /*Delete from source 5/15/17*/
			, Plus_ChurchMember
			, New_PersonalSuffix
			, StatusCode
			, New_MajorGiftPropensity1
			, Plus_AnnualGift1
			, Plus_PlannedGift
			, Plus_GiftCapacityEnp
			, Plus_GiftCapacityEn
			, Plus_PhilanthropicCapacityRatingPcr
			, Plus_EstimatedHouseHoldIncome
			, Plus_EstimatedHomemarketValue
			, Plus_BlockClusters
			, Plus_PlannedGiftTier
			, Plus_PreferredFirstName
			, Plus_PreferredMiddleName
			, Plus_PreferredLastName
			, Plus_PreferredFullName
			, Plus_SpousePreferredFirstName
			, Plus_SpousePreferredMiddleName
			, Plus_SpousePreferredLastName
			, Plus_SpousePreferredFullName
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, Plus_I5TextLinesLdsp
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Insert_Fields
		, 'ContactBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_WealthDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Lds_QualifiedOn) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ContactId
			, New_Ldspid
			, Plus_CoordinatingLiaison
			, FullName
			, FirstName
			, MiddleName
			, LastName
			, NickName
			, New_MiddleName2
			, New_LastName2
			, New_PreferredName
			, Plus_DisplayName
			, New_BirthName
			, Plus_CurrentStudent
			, New_BirthDate
			, New_BirthdateDay
			, New_BirthdateMonth
			, New_BirthdateYear
			, New_Deceased
			, New_DeceasedDate
			, New_DeceasedDay
			, New_DeceasedMonth
			, New_DeceasedYear
			, CASE WHEN DATENAME(dy,A.Plus_WealthDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_WealthDate)
					ELSE DATEADD(hh,-7,A.Plus_WealthDate) END AS Plus_WealthDate
			, SpousesName
			, New_Title
			, New_ProfessionalSuffix
			, New_HomeCountry
			, GenderCode
			, FamilyStatusCode
			--, New_Ethnicity  /*Delete from source 5/15/17*/
			, Plus_ChurchMember
			, New_PersonalSuffix
			, StatusCode
			, New_MajorGiftPropensity1
			, Plus_AnnualGift1
			, Plus_PlannedGift
			, Plus_GiftCapacityEnp
			, Plus_GiftCapacityEn
			, Plus_PhilanthropicCapacityRatingPcr
			, Plus_EstimatedHouseHoldIncome
			, Plus_EstimatedHomemarketValue
			, Plus_BlockClusters
			, Plus_PlannedGiftTier
			, Plus_PreferredFirstName
			, Plus_PreferredMiddleName
			, Plus_PreferredLastName
			, Plus_PreferredFullName
			, Plus_SpousePreferredFirstName
			, Plus_SpousePreferredMiddleName
			, Plus_SpousePreferredLastName
			, Plus_SpousePreferredFullName
			, Plus_ConnectedLiaison
			, Plus_PendingLiaison
			, CONVERT(NVARCHAR(4000),Plus_I5TextLinesLdsp) AS Plus_I5TextLinesLdsp
			, Plus_TotalGivenLast5Years
			, Lds_IsQualified
			, CASE WHEN DATENAME(dy,A.Lds_QualifiedOn) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Lds_QualifiedOn)
					ELSE DATEADD(hh,-7,A.Lds_QualifiedOn) END AS Lds_QualifiedOn
			, Lds_QualifiedBy
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Contact'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''17H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Contact''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- COUNTRY (Ext_Country)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_Country' -- Table_Name
		, 'New_CountryId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_AdderessFormat UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_CountryId
			, New_Name
			, Plus_AdderessFormat
			' -- Insert_Fields
		, 'New_CountryBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_CountryId
			, New_Name
			, Plus_AdderessFormat
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Country'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''18H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Country''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- COUNTY (Ext_County)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_County' -- Table_Name
		, 'New_CountyId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_CountyCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_CountyId
			, New_Name
			, Plus_CountyCode
			' -- Insert_Fields
		, 'New_CountyBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_CountyId
			, New_Name
			, Plus_CountyCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_County'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''19H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_County''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Degree (Ext_Degree)
-- --------------------------
	('Ext_Degree' -- Dim_Object
		, 'Ext_Degree' -- Table_Name
		, 'New_DegreeId UNIQUEIDENTIFIER
			, New_Degree NVARCHAR(100)
			, New_DegreeCode NVARCHAR(100)
			, Plus_DegreeLevel INT
			' -- Create_Fields
		, 'New_DegreeId
			, New_Degree
			, New_DegreeCode
			, Plus_DegreeLevel
			' -- Insert_Fields
		, 'New_DegreeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_DegreeId
			, New_Degree
			, New_DegreeCode
			, Plus_DegreeLevel
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Degree'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''20H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Degree''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- DONOR_SCORE_BASE (Ext_Donor_Score)
-- --------------------------
	('Donor_Score_Base' -- Dim_Object
		, 'Ext_Donor_Score' -- Table_Name
		, '	Plus_DonorScoreId UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_Institution UNIQUEIDENTIFIER
			, Plus_I5LegacyDonorTypeDate DATETIME
			, Plus_I5LegacyDonorType NVARCHAR(10)
			, ModifiedOn DATETIME
			, StatusCode INT
			, StateCode INT
			' -- Create_Fields
		, '	Plus_DonorScoreId
			, Plus_Constituent
			, Plus_Institution
			, Plus_I5LegacyDonorTypeDate
			, Plus_I5LegacyDonorType
			, ModifiedOn
			, StatusCode
			, StateCode
			' -- Insert_Fields
		, 'Plus_DonorScoreBase
			WHERE 1 = 1
				AND YEAR(Plus_I5LegacyDonorTypeDate) >= YEAR(GETDATE())-5
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_DonorScoreId
			, Plus_Constituent
			, Plus_Institution
			, Plus_I5LegacyDonorTypeDate
			, Plus_I5LegacyDonorType
			, ModifiedOn
			, StatusCode
			, StateCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Donor_Score'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''21H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Donor_Score''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- DROP_INCLUDE (Ext_Drop_Include)
-- --------------------------
	('Drop_Include' -- Dim_Object
		, 'Ext_Drop_Include' -- Table_Name
		, 'New_DropIncludeId UNIQUEIDENTIFIER
			, New_DropIncludesId UNIQUEIDENTIFIER
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_EmailDeliveryType BIT
			--, New_ListingDeliveryType BIT  /*Delete from source 5/15/17*/
			, New_PhoneDeliveryType BIT
			, New_WebDeliverytype BIT
			, New_VisitDeliveryType BIT
			, New_Reason INT
			, New_CommType INT
			, New_Interaction INT
			, New_Type INT
			, StateCode INT
			, New_MailDeliveryType BIT
			, New_TextDeliveryType BIT
			, New_StartDate DATETIME
			, New_EndDate DATETIME
			, Plus_CampaignId UNIQUEIDENTIFIER
			, New_Association UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_DropIncludeId
			, New_DropIncludesId
			, New_InstitutionalHierarchy
			, New_EmailDeliveryType
			--, New_ListingDeliveryType  /*Delete from source 5/15/17*/
			, New_PhoneDeliveryType
			, New_WebDeliverytype
			, New_VisitDeliveryType
			, New_Reason
			, New_CommType
			, New_Interaction
			, New_Type
			, StateCode
			, New_MailDeliveryType
			, New_TextDeliveryType
			, New_StartDate
			, New_EndDate
			, Plus_CampaignId
			, New_Association
			' -- Insert_Fields
		, 'New_DropIncludeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_DropIncludeId
			, New_DropIncludesId
			, New_InstitutionalHierarchy
			, New_EmailDeliveryType
			--, New_ListingDeliveryType   /*Delete from source 5/15/17*/
			, New_PhoneDeliveryType
			, New_WebDeliverytype
			, New_VisitDeliveryType
			, New_Reason
			, New_CommType
			, New_Interaction
			, New_Type
			, StateCode
			, New_MailDeliveryType
			, New_TextDeliveryType
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_CampaignId
			, New_Association
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Drop_Include'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''22H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Drop_Include''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- EMAIL (Ext_Email)
-- --------------------------
	('Email' -- Dim_Object
		, 'Ext_Email' -- Table_Name
		, 'New_EmailId UNIQUEIDENTIFIER
			, New_ConstituentId UNIQUEIDENTIFIER
			, New_Emails NVARCHAR(150)
			, New_Primary BIT
			, Statecode INT
			--, New_Confirmed BIT  /*Delete from source 5/15/17*/
			, New_Confidential BIT
			, New_Emailtype INT
			--, Plus_ConfidentialInstruction INT  /*Delete from source 5/15/17*/
			, New_ConfirmationDate DATETIME
			' -- Create_Fields
		, 'New_EmailId
			, New_ConstituentId
			, New_Emails
			, New_Primary
			, Statecode
			--, New_Confirmed  /*Delete from source 5/15/17*/
			, New_Confidential
			, New_Emailtype
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, New_ConfirmationDate
			' -- Insert_Fields
		, 'New_EmailBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_EmailId
			, COALESCE(New_ConstituentId,New_EmailsId) AS New_ConstituentId
			, New_Emails
			, New_Primary
			, Statecode
			--, New_Confirmed  /*Delete from source 5/15/17*/
			, New_Confidential
			, New_Emailtype
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, New_ConfirmationDate
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Email'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_EmailBase_Orphans'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_EmailBase_Orphans;
					CREATE TABLE Check_New_EmailBase_Orphans (
						New_EmailId NVARCHAR(100)
						, New_ConstituentId NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, Is_Orphaned NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_EmailBase_Orphans (
						New_EmailId
						, New_ConstituentId
						, New_Primary
						, Is_Orphaned
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_EmailId) AS New_EmailId
						, CASE WHEN CONVERT(NVARCHAR(100),New_ConstituentId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_ConstituentId) END AS New_ConstituentId
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, ''Y'' AS Is_Orphaned
						, ''N'' AS Record_Deleted
						FROM New_EmailBase
						WHERE 1 = 1
							AND New_ConstituentId IS NULL 
							AND New_Emails IS NOT NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Email T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_EmailId) AS New_EmailId
								FROM Check_New_EmailBase_Orphans
								WHERE 1 = 1 
									AND New_EmailId != ''NULL''
							) S ON T.New_EmailId = S.New_EmailId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_EmailBase_Orphans T
						USING (
								SELECT DISTINCT A.New_EmailId
									FROM Check_New_EmailBase_Orphans A
										LEFT JOIN Ext_Email B ON A.New_EmailId = CONVERT(NVARCHAR(100),B.New_EmailId)
									WHERE 1 = 1
										AND (B.New_EmailId IS NULL
												OR A.New_EmailId = ''NULL'')
							) S ON T.New_EmailId = S.New_EmailId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_4
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_EmailBase_Orphans)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_EmailId AS ''td'','''', New_ConstituentId AS ''td'','''', New_Primary AS ''td'','''', Is_Orphaned AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_EmailBase_Orphans ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_EmailId </th> <th> New_ConstituentId </th> <th> New_Primary </th> <th> Is_Orphaned </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_EmailBase Orphans''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_EmailBase_Orphans''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_EmailBase_Orphans.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_EmailBase_Orphans)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_5
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Email'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_EmailBase_Invalid_Emails'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_EmailBase_Invalid_Emails;
					CREATE TABLE Check_New_EmailBase_Invalid_Emails (
						New_EmailId NVARCHAR(100)
						, New_ConstituentId NVARCHAR(100)
						, New_Emails NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, Is_Invalid_Email NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_EmailBase_Invalid_Emails (
						New_EmailId
						, New_ConstituentId
						, New_Emails
						, New_Primary
						, Is_Invalid_Email
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_EmailId) AS New_EmailId
						, CASE WHEN CONVERT(NVARCHAR(100),New_ConstituentId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_ConstituentId) END AS New_ConstituentId
						, CASE WHEN New_Emails IS NULL THEN ''NULL'' ELSE New_Emails END AS New_Emails
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, ''Y'' AS Is_Invalid_Email
						, ''N'' AS Record_Deleted
						FROM New_EmailBase
						WHERE 1 = 1
							AND (New_Emails NOT LIKE ''_%@_%.__%''
									OR LEFT(New_Emails,1) = ''@''
									OR PATINDEX(''%[^a-z,0-9,@,.,_]%'', REPLACE(New_Emails, ''-'', ''a'')) = 1
					)
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_6
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Email T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_EmailId) AS New_EmailId
								FROM Check_New_EmailBase_Invalid_Emails
								WHERE 1 = 1 
									AND New_EmailId != ''NULL''
							) S ON T.New_EmailId = S.New_EmailId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_EmailBase_Invalid_Emails T
						USING (
								SELECT DISTINCT A.New_EmailId
									FROM Check_New_EmailBase_Invalid_Emails A
										LEFT JOIN Ext_Email B ON A.New_EmailId = CONVERT(NVARCHAR(100),B.New_EmailId)
									WHERE 1 = 1
										AND (B.New_EmailId IS NULL
												OR A.New_EmailId = ''NULL'')
							) S ON T.New_EmailId = S.New_EmailId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_7
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_EmailBase_Invalid_Emails)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END						
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_EmailId AS ''td'','''', New_ConstituentId AS ''td'','''', New_Emails AS ''td'','''', New_Primary AS ''td'','''', Is_Invalid_Email AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_EmailBase_Invalid_Emails ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_EmailId </th> <th> New_ConstituentId </th> <th> New_Emails </th> <th> New_Primary </th> <th> Is_Invalid_Email </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_EmailBase Invalid Emails''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_EmailBase_Invalid_Emails''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_EmailBase_Invalid_Emails.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_EmailBase_Invalid_Emails)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_8
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Email'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''23H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Email''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- EMPLOYMENT (Ext_Employment)
-- --------------------------
	('Employment' -- Dim_Object
		, 'Ext_Employment' -- Table_Name
		, 'New_EmploymentsId UNIQUEIDENTIFIER
			, New_EmploymentId UNIQUEIDENTIFIER
			, StateCode INT
			, New_Type INT
			, New_PaymentFrequency INT
			, New_Department NVARCHAR(100)
			, New_ChurchAff BIT
			, Plus_AlternateOrganizationName NVARCHAR(100)
			, New_Title NVARCHAR(100)
			, New_DateStarted DATETIME
			, New_DateEnded DATETIME
			, New_Internship BIT
			, New_InstitutionalHierarchyId UNIQUEIDENTIFIER
			, New_Source UNIQUEIDENTIFIER
			, New_IndustryCategory UNIQUEIDENTIFIER
			, New_JobCode UNIQUEIDENTIFIER
			, Plus_ChurchEmploymentStatus INT
			, New_Company UNIQUEIDENTIFIER
			, StatusCode INT
			, ModifiedOn DATETIME
			, Plus_RelatedAddress UNIQUEIDENTIFIER
			, Plus_RelatedPhone UNIQUEIDENTIFIER
			, Lds_CampusAddress NVARCHAR(100)
			' -- Create_Fields
		, 'New_EmploymentsId
			, New_EmploymentId
			, StateCode
			, New_Type
			, New_PaymentFrequency
			, New_Department
			, New_ChurchAff
			, Plus_AlternateOrganizationName
			, New_Title
			, New_DateStarted
			, New_DateEnded
			, New_Internship
			, New_InstitutionalHierarchyId
			, New_Source
			, New_IndustryCategory
			, New_JobCode
			, Plus_ChurchEmploymentStatus
			, New_Company
			, StatusCode
			, ModifiedOn
			, Plus_RelatedAddress
			, Plus_RelatedPhone
			, Lds_CampusAddress
			' -- Insert_Fields
		, 'New_EmploymentBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_DateStarted) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_DateEnded) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.ModifiedOn) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_EmploymentsId
			, New_EmploymentId
			, StateCode
			, New_Type
			, New_PaymentFrequency
			, New_Department
			, New_ChurchAff
			, Plus_AlternateOrganizationName
			, New_Title
			, CASE WHEN DATENAME(dy,A.New_DateStarted) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_DateStarted)
					ELSE DATEADD(hh,-7,A.New_DateStarted) END AS New_DateStarted
			, CASE WHEN DATENAME(dy,A.New_DateEnded) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_DateEnded)
					ELSE DATEADD(hh,-7,A.New_DateEnded) END AS New_DateEnded
			, New_Internship
			, New_InstitutionalHierarchyId
			, New_Source
			, New_IndustryCategory
			, New_JobCode
			, Plus_ChurchEmploymentStatus
			, New_Company
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, Plus_RelatedAddress
			, Plus_RelatedPhone
			, Lds_CampusAddress
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Employment'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''24H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Employment''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- ENVELOPENAMES_AND_SALUTATIONS (Ext_Envelope_Names_And_Salutations)
-- --------------------------
	('Donor' -- Dim_Object
		, 'Ext_Envelope_Names_And_Salutations' -- Table_Name
		, 'Plus_Etiquette INT
			, Plus_EnvelopeSalutationConstituent UNIQUEIDENTIFIER
			, Plus_SalutationEnvelopeName NVARCHAR(300)
			, Plus_Household INT
			, StateCode INT
			, Plus_NameType INT
			, Plus_EnvelopeNamesAndSalutationsId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'Plus_Etiquette
			, Plus_EnvelopeSalutationConstituent
			, Plus_SalutationEnvelopeName
			, Plus_Household
			, StateCode
			, Plus_NameType
			, Plus_EnvelopeNamesAndSalutationsId
			' -- Insert_Fields
		, 'Plus_EnvelopeNamesAndSalutationsBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_Etiquette
			, Plus_EnvelopeSalutationConstituent
			, Plus_SalutationEnvelopeName
			, Plus_Household
			, StateCode
			, Plus_NameType
			, Plus_EnvelopeNamesAndSalutationsId
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Envelope_Names_And_Salutations'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''25H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Envelope_Names_And_Salutations''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- FUND (Ext_Fund_Account)
-- --------------------------
	('Fund' -- Dim_Object
		, 'Ext_Fund_Account' -- Table_Name
		, 'New_FundAccountId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_FundName NVARCHAR(100)
			, New_AccountNumber  NVARCHAR(100)
			, Plus_GiftPurposeSubtype NVARCHAR(500)
			, Plus_GiftPurposeType NVARCHAR(500)
			, Plus_LdspAccountNumberInt INT
			, New_FormalAccountName NVARCHAR(100)
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_InstitutionAccountNumber NVARCHAR(100)
			, Plus_Unrestricted NVARCHAR(1)
			, Plus_Scholarship NVARCHAR(1)
			, New_Endowment BIT
			, Plus_EffectiveFrom DATETIME
			, Plus_EffectiveTo DATETIME
			, New_CaePurpose NVARCHAR(500)
			, Plus_SubClassAccountNumber NVARCHAR(100)
			, New_Description NVARCHAR(300)
			, Plus_Notes NVARCHAR(200)
			, Plus_AwardRestrictionGender NVARCHAR(500)
			, Plus_AwardRestrictionClassYear NVARCHAR(500)
			, Plus_AwardRestrictionCollege UNIQUEIDENTIFIER
			, Plus_AwardRestrictionEthnicity NVARCHAR(500)
			, Plus_AwardRestrictionGPA DECIMAL
			, Plus_AwardRestrictionMajor UNIQUEIDENTIFIER
			, Plus_GeographicArea UNIQUEIDENTIFIER
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
			, Plus_MatchingGiftText	NVARCHAR(4000)
			, Plus_PrincipalAccountNumber NVARCHAR(100)
			, Plus_Spendable NVARCHAR(25)
			, Plus_ProposedEndowment BIT
			, Plus_ReportFrequency INT
			, StatusCode INT
			, New_AllowGifts BIT
			' -- Create_Fields
		, 'New_FundAccountId
			, New_Name
			, New_FundName
			, New_AccountNumber
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
			, New_AllowGifts
			' -- Insert_Fields
		, 'New_FundAccountBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_EffectiveFrom) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_EffectiveTo) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_FundAccountId
			, New_Name
			, New_FundName
			, New_AccountNumber
			, Plus_GiftPurposeSubtype
			, Plus_GiftPurposeType
			, Plus_LdspAccountNumberInt
			, New_FormalAccountName
			, New_InstitutionalHierarchy
			, New_InstitutionAccountNumber
			, Plus_Unrestricted
			, Plus_Scholarship
			, New_Endowment
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveFrom) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveFrom)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveFrom) END AS Plus_EffectiveFrom
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveTo) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveTo)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveTo) END AS Plus_EffectiveTo
			, New_CaePurpose
			, Plus_SubClassAccountNumber
			, CONVERT(NVARCHAR(300),New_Description) AS New_Description
			, CONVERT(NVARCHAR(200),Plus_Notes) AS Plus_Notes
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
			, CONVERT(NVARCHAR(4000),Plus_AwardRestrictionNotes) AS Plus_AwardRestrictionNotes
			, Plus_Athletics
			, Plus_FourYear
			, Plus_GraduateProfessional
			, Plus_TvRadio
			, Plus_TechnologySpec
			, Plus_AlumniAssociation
			, CONVERT(NVARCHAR(4000),Plus_MatchingGiftText) AS Plus_MatchingGiftText
			, Plus_PrincipalAccountNumber
			, Plus_Spendable
			, Plus_ProposedEndowment
			, Plus_ReportFrequency
			, StatusCode
			, New_AllowGifts
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Fund_Account'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''26H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Fund_Account''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- GIFT (Ext_Gift)
-- --------------------------
	('Donation' -- Dim_Object
		, 'Ext_Gift' -- Table_Name
		, 'New_ConstituentDonor UNIQUEIDENTIFIER
			, New_OrganizationDonor UNIQUEIDENTIFIER
			, New_FundAccount UNIQUEIDENTIFIER
			, New_InstitutionalHierarchyId UNIQUEIDENTIFIER
			, New_AssociatedPledge UNIQUEIDENTIFIER
			--, New_Opportunity UNIQUEIDENTIFIER
			, New_GiftAmount MONEY
			, New_BatchNumber NVARCHAR(50)
			--, New_ProposedMatchAmount MONEY  /*Delete from source 5/15/17*/
			, New_GiftId UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER			
			, New_GiftNumber NVARCHAR(50)
			, StatusCode INT
			, Plus_ReceiptText NVARCHAR(4000)
			, Plus_SpecialGiftInstructions NVARCHAR(4000)
			, Plus_CheckNumber NVARCHAR(50)
			, Plus_GiftSource INT
			, Plus_Kind INT
			, New_TenderType INT
			, New_AccountingDate DATETIME
			, New_ReceiptDate DATETIME
			, New_PostDate DATETIME
			, Plus_PlannedGift BIT
			--, New_MatchingDonation BIT  /*Delete from source 5/15/17*/
			--, Plus_GiftInKindProceeds BIT  /*Delete from source 5/15/17*/
			, New_Transmitted BIT
			, Plus_AnonymousGift BIT
			, Plus_ReceiptDeliveryMethod INT
			, Plus_GiftInstructions NVARCHAR(4000)
			, Plus_AcknowledgementInstructions NVARCHAR(4000)
			, Plus_ExcludeFromReport BIT
			, Plus_IncludeOnYearEndReceipt BIT
			, Plus_GoodsServicesProvided BIT
			, Plus_EntitledBenefitValue MONEY
			, Plus_AcknowledgeContact NVARCHAR(100)
			, Plus_ContactRole INT
			, Plus_Salutation INT
			, Plus_Signer UNIQUEIDENTIFIER
			, Plus_NoAcknowledgement BIT
			, Match_Gift_Number NVARCHAR(50)
			, Plus_Appeal UNIQUEIDENTIFIER
			, Plus_MatchExpected BIT
			, New_Batch UNIQUEIDENTIFIER
			, Plus_Description NVARCHAR(4000)
			, Lds_RecurringGiftRule UNIQUEIDENTIFIER
			, Lds_RecurringGiftGroup UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_ConstituentDonor
			, New_OrganizationDonor
			, New_FundAccount
			, New_InstitutionalHierarchyId
			, New_AssociatedPledge
			--, New_Opportunity
			, New_GiftAmount
			, New_BatchNumber
			--, New_ProposedMatchAmount  /*Delete from source 5/15/17*/
			, New_GiftId
			, OwnerId			
			, New_GiftNumber
			, StatusCode
			, Plus_ReceiptText
			, Plus_SpecialGiftInstructions
			, Plus_CheckNumber
			, Plus_GiftSource
			, Plus_Kind
			, New_TenderType
			, New_AccountingDate
			, New_ReceiptDate
			, New_PostDate
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
			, Plus_EntitledBenefitValue
			, Plus_AcknowledgeContact
			, Plus_ContactRole
			, Plus_Salutation
			, Plus_Signer
			, Plus_NoAcknowledgement
			, Match_Gift_Number
			, Plus_Appeal
			, Plus_MatchExpected
			, New_Batch
			, Plus_Description
			, Lds_RecurringGiftRule
			, Lds_RecurringGiftGroup
			' -- Insert_Fields
		, 'New_GiftBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_AccountingDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_ReceiptDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.New_PostDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_ConstituentDonor
			, New_OrganizationDonor
			, New_FundAccount
			, New_InstitutionalHierarchyId
			, New_AssociatedPledge
			--, New_Opportunity
			, New_GiftAmount
			, New_BatchNumber
			--, New_ProposedMatchAmount  /*Delete from source 5/15/17*/
			, New_GiftId
			, OwnerId
			, New_GiftNumber
			, StatusCode
			, CONVERT(NVARCHAR(4000),Plus_ReceiptText) AS Plus_ReceiptText
			, CONVERT(NVARCHAR(4000),Plus_SpecialGiftInstructions) AS Plus_SpecialGiftInstructions
			, Plus_CheckNumber
			, Plus_GiftSource
			, Plus_Kind
			, New_TenderType
			, CASE WHEN DATENAME(dy,A.New_AccountingDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_AccountingDate)
					ELSE DATEADD(hh,-7,A.New_AccountingDate) END AS New_AccountingDate
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, CASE WHEN DATENAME(dy,A.New_PostDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_PostDate)
					ELSE DATEADD(hh,-7,A.New_PostDate) END AS New_PostDate
			, Plus_PlannedGift
			--, New_MatchingDonation  /*Delete from source 5/15/17*/
			--, Plus_GiftInKindProceeds  /*Delete from source 5/15/17*/
			, New_Transmitted
			, Plus_AnonymousGift
			, Plus_ReceiptDeliveryMethod
			, CONVERT(NVARCHAR(4000),Plus_GiftInstructions) AS Plus_GiftInstructions
			, CONVERT(NVARCHAR(4000),Plus_AcknowledgementInstructions) AS Plus_AcknowledgementInstructions
			, Plus_ExcludeFromReport
			, Plus_IncludeOnYearEndReceipt
			, Plus_GoodsServicesProvided
			, Plus_EntitledBenefitValue
			, Plus_AcknowledgeContact
			, Plus_ContactRole
			, Plus_Salutation
			, Plus_Signer
			, Plus_NoAcknowledgement
			, CASE WHEN Plus_ParentGift IS NOT NULL THEN New_GiftNumber ELSE NULL END AS Match_Gift_Number
			, Plus_Appeal AS Appeal_Key
			, Plus_MatchExpected
			, New_Batch
			, CONVERT(NVARCHAR(4000),Plus_Description) AS Plus_Description
			, Lds_RecurringGiftRule
			, Lds_RecurringGiftGroup
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Gift'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''27H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Gift''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Industry (Ext_Industry)
-- --------------------------
	('Industry' -- Dim_Object
		, 'Ext_Industry' -- Table_Name
		, 'New_IndustryId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_IndustryId
			, New_Name
			' -- Insert_Fields
		, 'New_IndustryBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_IndustryId
			, New_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Industry'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''28H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Industry''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- INSTITUTION (Ext_Institution)
-- --------------------------
	('Hierachy' -- Dim_Object
		, 'Ext_Institution' -- Table_Name
		, 'New_Institutionid UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_ParentInstitutionalHieararchy UNIQUEIDENTIFIER
			, New_Level1 NVARCHAR(100)
			, New_Level2 NVARCHAR(100)
			, New_Level3 NVARCHAR(100)
			, New_AvailableToAlumni BIT
			, New_AvailableToStudent BIT
			, New_IsEndNode BIT
			, New_EducationUsage BIT
			--, New_EmployeeUsage BIT  /*Delete from source 5/15/17*/
			, New_AssociationUsage BIT
			, New_DonationUsage BIT
			, New_Inst NVARCHAR(100)
			' -- Create_Fields
		, 'New_Institutionid
			, New_Name
			, Plus_ParentInstitutionalHieararchy
			, New_Level1
			, New_Level2
			, New_Level3
			, New_AvailableToAlumni
			, New_AvailableToStudent
			, New_IsEndNode
			, New_EducationUsage
			--, New_EmployeeUsage  /*Delete from source 5/15/17*/
			, New_AssociationUsage
			, New_DonationUsage
			, New_Inst
			' -- Insert_Fields
		, 'New_InstitutionBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_Institutionid
			, New_Name
			, Plus_ParentInstitutionalHieararchy
			, New_Level1
			, New_Level2
			, New_Level3
			, New_AvailableToAlumni
			, New_AvailableToStudent
			, New_IsEndNode
			, New_EducationUsage
			--, New_EmployeeUsage  /*Delete from source 5/15/17*/
			, New_AssociationUsage
			, New_DonationUsage
			, New_Inst
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Institution'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''29H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Institution''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Interest (Ext_Interest)
-- --------------------------
	('Extract' -- Dim_Object
		, 'Ext_Interest' -- Table_Name
		, 'Plus_InterestId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_InterestId
			, Plus_Name
			' -- Insert_Fields
		, 'Plus_InterestBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_InterestId
			, Plus_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Interest'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''30H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Interest''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- International_ExperienceBase (Ext_International_Experience)
-- --------------------------
	('Extract' -- Dim_Object
		, 'Ext_International_Experience' -- Table_Name
		, 'New_InternationalExperienceId UNIQUEIDENTIFIER
			, New_InternationalExperiencesAId UNIQUEIDENTIFIER
			, New_Experience INT
			, Plus_Emeritus BIT   
			, Plus_StudyAbroad BIT   
			, New_Source UNIQUEIDENTIFIER 
			, New_StartDate DATETIME
			, New_EndDate  DATETIME
			, Plus_Interest UNIQUEIDENTIFIER 
			, Plus_LdsPosition INT 
			, Plus_InstitutionalHierarchy UNIQUEIDENTIFIER 
			, New_Country UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_InternationalExperienceId
			, New_InternationalExperiencesAId
			, New_Experience
			, Plus_Emeritus   
			, Plus_StudyAbroad   
			, New_Source 
			, New_StartDate
			, New_EndDate
			, Plus_Interest 
			, Plus_LdsPosition 
			, Plus_InstitutionalHierarchy 
			, New_Country
			' -- Insert_Fields
		, 'New_InternationalExperienceBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_StartDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_InternationalExperienceId
			, New_InternationalExperiencesAId
			, New_Experience
			, Plus_Emeritus   
			, Plus_StudyAbroad   
			, New_Source 
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_Interest 
			, Plus_LdsPosition 
			, Plus_InstitutionalHierarchy 
			, New_Country
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_International_Experience'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''31H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_International_Experience''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Job_Code (Ext_Job_Code)
-- --------------------------
	('Job_Code' -- Dim_Object
		, 'Ext_Job_Code' -- Table_Name
		, 'New_JobCodeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_JobCodeId
			, New_Name
			' -- Insert_Fields
		, 'New_JobCodeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_JobCodeId
			, New_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Job_Code'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''32H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Job_Code''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- LANGUAGE (Ext_Language)
-- --------------------------
	('Language' -- Dim_Object
		, 'Ext_Language' -- Table_Name
		, 'New_LanguageSpecialAffiliationId  UNIQUEIDENTIFIER
			, New_LanguageSAId  UNIQUEIDENTIFIER
			, New_Language INT
			, New_Missionary INT
			, New_ReadLevel INT
			, New_Speech INT
			, New_Teacher INT
			, New_Translator INT
			, New_WriteLevel INT
			, New_BusinessPerson INT
			, Plus_I5CreatedBy NVARCHAR(75)
			, Plus_I5CreatedOn NVARCHAR(15)
			, Plus_Notes NVARCHAR(4000)
			, New_Source UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_LanguageSpecialAffiliationId
			, New_LanguageSAId
			, New_Language
			, New_Missionary
			, New_ReadLevel
			, New_Speech
			, New_Teacher
			, New_Translator
			, New_WriteLevel
			, New_BusinessPerson
			, Plus_I5CreatedBy
			, Plus_I5CreatedOn
			, Plus_Notes
			, New_Source
			' -- Insert_Fields
		, 'New_LanguageSpecialAffiliationBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_LanguageSpecialAffiliationId
			, New_LanguageSAId
			, New_Language
			, New_Missionary
			, New_ReadLevel
			, New_Speech
			, New_Teacher
			, New_Translator
			, New_WriteLevel
			, New_BusinessPerson
			, Plus_I5CreatedBy
			, Plus_I5CreatedOn
			, CONVERT(NVARCHAR(4000),Plus_Notes) AS Plus_Notes
			, New_Source
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Language'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''33H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Language''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Major (Ext_Major)
-- --------------------------
	('Ext_Major' -- Dim_Object
		, 'Ext_Major' -- Table_Name
		, 'New_College UNIQUEIDENTIFIER
			, New_University UNIQUEIDENTIFIER
			, New_MajorId UNIQUEIDENTIFIER
			, New_Major NVARCHAR(100)
			, New_MajorName NVARCHAR(100)
			, New_MajorCode NVARCHAR(10)
			' -- Create_Fields
		, 'New_College
			, New_University
			, New_MajorId
			, New_Major
			, New_MajorName
			, New_MajorCode
			' -- Insert_Fields
		, 'New_MajorBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_College
			, New_University
			, New_MajorId
			, New_Major
			, New_MajorName
			, New_MajorCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Major'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''34H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Major''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- OPPORTUNITY (Ext_Opportunity)
-- --------------------------
	('Donation' -- Dim_Object
		, 'Ext_Opportunity' -- Table_Name
		, 'OpportunityId UNIQUEIDENTIFIER
			, Plus_TotalAskAmount MONEY
			, Plus_TotalCommittedAmount MONEY
			, Plus_TotalGiven MONEY
			, Name NVARCHAR(600)
			, StepName NVARCHAR(400)
			, StateCode INT
			, StatusCode INT
			, CustomerId UNIQUEIDENTIFIER
			, CustomerIdType INT
			, Plus_ProposalStatus INT
			, Plus_ProposalDate DATE
			, Plus_TargetedCommitment DATE
			, Plus_CommittedDate DATE
			, Plus_FundAccount UNIQUEIDENTIFIER
			, Plus_CultivationProcessStage1Date DATE
			, Plus_CultivationProcessStage2Date DATE
			, Plus_CultivationProcessStage3Date DATE
			, Plus_CultivationProcessStage4Date DATE
			, Plus_GiftNoticeCreatedOn DATE
			, Plus_ProposalStatusChangeDate DATE
			, Plus_NewAccount BIT
			, Plus_CoordinatingLiaisonId UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Lds_PrimaryInitiative BIT
			, Plus_ParentInitiative UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'OpportunityId
			, Plus_TotalAskAmount
			, Plus_TotalCommittedAmount
			, Plus_TotalGiven
			, Name
			, StepName
			, StateCode
			, StatusCode
			, CustomerId
			, CustomerIdType
			, Plus_ProposalStatus
			, Plus_ProposalDate
			, Plus_TargetedCommitment
			, Plus_CommittedDate
			, Plus_FundAccount
			, Plus_CultivationProcessStage1Date
			, Plus_CultivationProcessStage2Date
			, Plus_CultivationProcessStage3Date
			, Plus_CultivationProcessStage4Date
			, Plus_GiftNoticeCreatedOn
			, Plus_ProposalStatusChangeDate
			, Plus_NewAccount
			, Plus_CoordinatingLiaisonId
			, OwnerId
			, Lds_PrimaryInitiative
			, Plus_ParentInitiative
			' -- Insert_Fields
		, 'OpportunityBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_ProposalDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_TargetedCommitment) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_CommittedDate) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.Plus_CultivationProcessStage1Date) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.Plus_CultivationProcessStage2Date) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.Plus_CultivationProcessStage3Date) = G.Date_Year
				LEFT JOIN _MDT_Conversion_Dim H ON YEAR(A.Plus_CultivationProcessStage4Date) = H.Date_Year
				LEFT JOIN _MDT_Conversion_Dim I ON YEAR(A.Plus_GiftNoticeCreatedOn) = I.Date_Year
				LEFT JOIN _MDT_Conversion_Dim J ON YEAR(A.Plus_ProposalStatusChangeDate) = J.Date_Year				
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'OpportunityId
			, Plus_TotalAskAmount
			, Plus_TotalCommittedAmount
			, Plus_TotalGiven
			, Name
			, StepName
			, StateCode
			, StatusCode
			, CustomerId
			, CustomerIdType
			, Plus_ProposalStatus
			, CASE WHEN DATENAME(dy,A.Plus_ProposalDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ProposalDate)
					ELSE DATEADD(hh,-7,A.Plus_ProposalDate) END AS Plus_ProposalDate
			, CASE WHEN DATENAME(dy,A.Plus_TargetedCommitment) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_TargetedCommitment)
					ELSE DATEADD(hh,-7,A.Plus_TargetedCommitment) END AS Plus_TargetedCommitment
			, CASE WHEN DATENAME(dy,A.Plus_CommittedDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CommittedDate)
					ELSE DATEADD(hh,-7,A.Plus_CommittedDate) END AS Plus_CommittedDate
			, Plus_FundAccount
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage1Date) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage1Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage1Date) END AS Plus_CultivationProcessStage1Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage2Date) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage2Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage2Date) END AS Plus_CultivationProcessStage2Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage3Date) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage3Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage3Date) END AS Plus_CultivationProcessStage3Date
			, CASE WHEN DATENAME(dy,A.Plus_CultivationProcessStage4Date) BETWEEN H.Mdt_Begin_Date_Number AND H.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_CultivationProcessStage4Date)
					ELSE DATEADD(hh,-7,A.Plus_CultivationProcessStage4Date) END AS Plus_CultivationProcessStage4Date
			, CASE WHEN DATENAME(dy,A.Plus_GiftNoticeCreatedOn) BETWEEN I.Mdt_Begin_Date_Number AND I.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_GiftNoticeCreatedOn)
					ELSE DATEADD(hh,-7,A.Plus_GiftNoticeCreatedOn) END AS Plus_GiftNoticeCreatedOn
			, CASE WHEN DATENAME(dy,A.Plus_ProposalStatusChangeDate) BETWEEN J.Mdt_Begin_Date_Number AND J.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_ProposalStatusChangeDate)
					ELSE DATEADD(hh,-7,A.Plus_ProposalStatusChangeDate) END AS Plus_ProposalStatusChangeDate
			, Plus_NewAccount
			, Plus_CoordinatingLiaisonId
			, OwnerId
			, Lds_PrimaryInitiative
			, Plus_ParentInitiative
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Opportunity'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''35H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Opportunity''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- OTHER_IDENTIFIER (Ext_Other_Identifiers)
-- --------------------------
	('Donor' -- Dim_Object
		, 'Ext_Other_Identifiers' -- Table_Name
		, 'New_OtherIdentifiersId UNIQUEIDENTIFIER
			, StateCode INT
			, New_Type INT
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, ModifiedOn DATETIME
			, New_EmploymentId UNIQUEIDENTIFIER
			, New_Id NVARCHAR(100)
			, Plus_Id NVARCHAR(100)
			, New_OtherIdentifiers UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_OtherIdentifiersId
			, StateCode
			, New_Type
			, New_InstitutionalHierarchy
			, ModifiedOn
			, New_EmploymentId
			, New_Id
			, Plus_Id
			, New_OtherIdentifiers
			' -- Insert_Fields
		, 'New_OtherIdentifiersBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ModifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_OtherIdentifiersId
			, StateCode
			, New_Type
			, New_InstitutionalHierarchy
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, New_EmploymentId
			, New_Id
			, Plus_Id
			, New_OtherIdentifiers
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Other_Identifiers'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''36H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Other_Identifiers''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PHONE (Ext_Phone)
-- --------------------------
	('Phone' -- Dim_Object
		, 'Ext_Phone' -- Table_Name
		, 'New_PhoneId UNIQUEIDENTIFIER
			, New_NumberId UNIQUEIDENTIFIER
			, Plus_PhoneNumberUnformatted NVARCHAR(100)
			, New_PhoneNumber NVARCHAR(100)
			, New_CountryCode NVARCHAR(100)
			, New_Ext NVARCHAR(100)
			, StateCode INT
			--, New_Confirmed INT  /*Delete from source 5/15/17*/
			, New_Primary BIT
			, New_ReceiveText BIT
			, New_Confidential BIT
			, New_Type INT
			, Plus_LineType INT
			, New_PreferredTime INT
			--, Plus_ConfidentialInstruction INT  /*Delete from source 5/15/17*/
			, StatusCode INT
			, ModifiedOn DATETIME
			, New_ConfirmationDate DATETIME
			' -- Create_Fields
		, 'New_PhoneId
			, New_NumberId
			, Plus_PhoneNumberUnformatted
			, New_PhoneNumber
			, New_CountryCode
			, New_Ext
			, StateCode
			--, New_Confirmed  /*Delete from source 5/15/17*/
			, New_Primary
			, New_ReceiveText
			, New_Confidential
			, New_Type
			, Plus_LineType
			, New_PreferredTime
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, StatusCode
			, ModifiedOn
			, New_ConfirmationDate
			' -- Insert_Fields
		, 'New_PhoneBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.ModifiedOn) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_PhoneId
			, COALESCE(New_NumberId,New_PhonesId) AS New_NumberId
			, Plus_PhoneNumberUnformatted
			, New_PhoneNumber
			, New_CountryCode
			, New_Ext
			, StateCode
			--, New_Confirmed  /*Delete from source 5/15/17*/
			, New_Primary
			, New_ReceiveText
			, New_Confidential
			, New_Type
			, Plus_LineType
			, New_PreferredTime
			--, Plus_ConfidentialInstruction  /*Delete from source 5/15/17*/
			, StatusCode
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS ModifiedOn
			, New_ConfirmationDate
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Phone'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_PhoneBase_Orphans'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_PhoneBase_Orphans;
					CREATE TABLE Check_New_PhoneBase_Orphans (
						New_PhoneId NVARCHAR(100)
						, New_NumberId NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, Is_Orphaned NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_PhoneBase_Orphans (
						New_PhoneId
						, New_NumberId
						, New_Primary
						, Is_Orphaned
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_PhoneId) AS New_PhoneId
						, CASE WHEN CONVERT(NVARCHAR(100),New_NumberId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_NumberId) END AS New_NumberId
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, ''Y'' AS Is_Orphaned
						, ''N'' AS Record_Deleted
						FROM New_PhoneBase
						WHERE 1 = 1
							AND New_NumberId IS NULL
							AND New_PhonesId IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Phone T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_PhoneId) AS New_PhoneId
								FROM Check_New_PhoneBase_Orphans
								WHERE 1 = 1 
									AND New_PhoneId != ''NULL''
							) S ON T.New_PhoneId = S.New_PhoneId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_PhoneBase_Orphans T
						USING (
								SELECT DISTINCT A.New_PhoneId
									FROM Check_New_PhoneBase_Orphans A
										LEFT JOIN Ext_Phone B ON A.New_PhoneId = CONVERT(NVARCHAR(100),B.New_PhoneId)
									WHERE 1 = 1
										AND (B.New_PhoneId IS NULL
												OR A.New_PhoneId = ''NULL'')
							) S ON T.New_PhoneId = S.New_PhoneId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_4
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_PhoneBase_Orphans)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_PhoneId AS ''td'','''', New_NumberId AS ''td'','''', New_Primary AS ''td'','''', Is_Orphaned AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_PhoneBase_Orphans ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_PhoneId </th> <th> New_NumberId </th> <th> New_Primary </th> <th> Is_Orphaned </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_PhoneBase Orphans''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_PhoneBase_Orphans''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_PhoneBase_Orphans.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_PhoneBase_Orphans)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_5
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Phone'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_PhoneBase_Invalid_Phones'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_PhoneBase_Invalid_Phones;
					CREATE TABLE Check_New_PhoneBase_Invalid_Phones (
						New_PhoneId NVARCHAR(100)
						, New_NumberId NVARCHAR(100)
						, New_PhoneNumber NVARCHAR(100)
						, New_Primary NVARCHAR(1)
						, Is_Invalid_Phone NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_PhoneBase_Invalid_Phones (
						New_PhoneId
						, New_NumberId
						, New_PhoneNumber
						, New_Primary
						, Is_Invalid_Phone
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_PhoneId) AS New_PhoneId
						, CASE WHEN CONVERT(NVARCHAR(100),COALESCE(New_NumberId,New_PhonesId)) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),COALESCE(New_NumberId,New_PhonesId)) END AS New_NumberId
						, CASE WHEN New_PhoneNumber IS NULL THEN ''NULL'' ELSE New_PhoneNumber END AS New_PhoneNumber
						, CASE WHEN New_Primary = 1 THEN ''Y'' ELSE ''N'' END AS New_Primary
						, ''Y'' AS Is_Invalid_Phone
						, ''N'' AS Record_Deleted
						FROM New_PhoneBase
						WHERE 1 = 1
							AND (ISNUMERIC(REPLACE(REPLACE(REPLACE(REPLACE(New_PhoneNumber,''('',''0''),'')'',''0''),''-'',''0''),'' '',''0'')) = 0
									OR LEN(REPLACE(REPLACE(REPLACE(REPLACE(New_PhoneNumber,''('',''0''),'')'',''0''),''-'',''0''),'' '',''0'')) < 7
								)
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_6
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Phone T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_PhoneId) AS New_PhoneId
								FROM Check_New_PhoneBase_Invalid_Phones
								WHERE 1 = 1 
									AND New_PhoneId != ''NULL''
							) S ON T.New_PhoneId = S.New_PhoneId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_PhoneBase_Invalid_Phones T
						USING (
								SELECT DISTINCT A.New_PhoneId
									FROM Check_New_PhoneBase_Invalid_Phones A
										LEFT JOIN Ext_Phone B ON A.New_PhoneId = CONVERT(NVARCHAR(100),B.New_PhoneId)
									WHERE 1 = 1
										AND (B.New_PhoneId IS NULL
												OR A.New_PhoneId = ''NULL'')
							) S ON T.New_PhoneId = S.New_PhoneId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_7
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_PhoneBase_Invalid_Phones)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_PhoneId AS ''td'','''', New_NumberId AS ''td'','''', New_PhoneNumber AS ''td'','''', New_Primary AS ''td'','''', Is_Invalid_Phone AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_PhoneBase_Invalid_Phones ORDER BY New_Primary DESC
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_PhoneId </th> <th> New_NumberId </th> <th> New_PhoneNumber </th> <th> New_Primary </th> <th> Is_Invalid_Phone </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''		
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_PhoneBase Invalid Phones''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_PhoneBase_Invalid_Phones''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_PhoneBase_Invalid_Phones.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_PhoneBase_Invalid_Phones)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_8
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Phone'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''37H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Phone''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PLEDGE (Ext_Pledge)
-- --------------------------
	('Donation' -- Dim_Object
		, 'Ext_Pledge' -- Table_Name
		, 'New_PledgeId UNIQUEIDENTIFIER
			, New_TotalPledged MONEY
			, New_BeginDate DATETIME
			, New_EndDate DATETIME
			, Plus_Kind INT
			, Plus_TenderType INT
			, Plus_GiftSource INT
			, Plus_PlannedGift BIT
			, Plus_CheckNumber NVARCHAR(50)
			, New_Confidential BIT
			, Plus_AcknowledgementInstructions NVARCHAR(MAX)
			, Plus_NewAccountInstructions NVARCHAR(MAX)
			, Plus_SpecialGiftInstructions NVARCHAR(MAX)
			, Plus_TelefundRep UNIQUEIDENTIFIER
			, New_BalanceDue_Base MONEY
			, New_TotalPaid_Base MONEY
			, New_PaymentsToMake INT
			, New_PaymentsReceived INT
			, Plus_PlannedGivingPaymentFrequency INT
			, New_InstallmentAmount_Base MONEY
			, Plus_InstallmentDate DATETIME
			, New_Bookable BIT
			, Plus_MatchExpected BIT
			, Plus_ParentGift UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Plus_GiftRevocability INT
			, Plus_RemainderBeneficiary INT
			, Plus_FairMarketValue_Base MONEY
			, Plus_PresentValue_Base MONEY
			, New_SignatureDate DATETIME
			, New_Documentation BIT
			, New_NotificationDate DATETIME
			, Plus_FundingDate DATETIME
			, Plus_EstimatedMaturityDate DATETIME
			, Plus_Designation NVARCHAR(MAX)
			, Plus_NameOfTrust NVARCHAR(200)
			, plus_PlannedGivingType INT
			, Plus_VehicleType INT
			, Plus_VehicleSubType INT
			, Plus_PayoutRate DECIMAL
			, Plus_PaymentAmount_Base MONEY
			, Plus_AnnualAmount_Base MONEY
			, Plus_Duration INT
			, Plus_LivesType INT
			, Plus_Years INT
			, Plus_Lives DECIMAL
			, Plus_TermBeneficiaryLives DECIMAL
			, Plus_TermBeneficiaryYears INT
			, Plus_Cri DECIMAL
			, Plus_PaymentStartDate DATETIME
			, Plus_GpsNotes NVARCHAR(MAX)
			, Plus_Appeal UNIQUEIDENTIFIER
			, New_FundAccount UNIQUEIDENTIFIER
			, New_InstitutionalHierarchy UNIQUEIDENTIFIER
			, New_ConstituentDonor UNIQUEIDENTIFIER
			, New_OrganizationDonor UNIQUEIDENTIFIER
			, New_Opportunity UNIQUEIDENTIFIER
			, New_BalanceDue  MONEY
			, New_InstallmentAmount MONEY
			--, Plus_ProposalAmount MONEY  /*Delete from source 5/15/17*/
			, New_TotalPaid MONEY
			, Plus_RecurringGiftRules UNIQUEIDENTIFIER
			, New_PledgeNumber NVARCHAR(100)
			, StatusCode INT
			, Lds_ExpectancyType INT
			' -- Create_Fields
		, 'New_PledgeId
			, New_TotalPledged
			, New_BeginDate
			, New_EndDate
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
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, Plus_PlannedGivingPaymentFrequency
			, New_InstallmentAmount_Base
			, Plus_InstallmentDate
			, New_Bookable
			, Plus_MatchExpected
			, Plus_ParentGift
			, OwnerId
			, Plus_GiftRevocability
			, Plus_RemainderBeneficiary
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, New_SignatureDate
			, New_Documentation
			, New_NotificationDate
			, Plus_FundingDate
			, Plus_EstimatedMaturityDate
			, Plus_Designation
			, Plus_NameOfTrust
			, plus_PlannedGivingType
			, Plus_VehicleType
			, Plus_VehicleSubType
			, Plus_PayoutRate
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, Plus_Duration
			, Plus_LivesType
			, Plus_Years
			, Plus_Lives
			, Plus_TermBeneficiaryLives
			, Plus_TermBeneficiaryYears
			, Plus_Cri
			, Plus_PaymentStartDate
			, Plus_GpsNotes
			, Plus_Appeal
			, New_FundAccount
			, New_InstitutionalHierarchy
			, New_ConstituentDonor
			, New_OrganizationDonor
			, New_Opportunity
			, New_BalanceDue
			, New_InstallmentAmount
			--, Plus_ProposalAmount  /*Delete from source 5/15/17*/
			, New_TotalPaid
			, Plus_RecurringGiftRules
			, New_PledgeNumber
			, StatusCode
			, Lds_ExpectancyType
			' -- Insert_Fields
		, 'New_PledgeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_BeginDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_EndDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_InstallmentDate) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.New_SignatureDate) = E.Date_Year
				LEFT JOIN _MDT_Conversion_Dim F ON YEAR(A.New_NotificationDate) = F.Date_Year
				LEFT JOIN _MDT_Conversion_Dim G ON YEAR(A.Plus_FundingDate) = G.Date_Year
				LEFT JOIN _MDT_Conversion_Dim H ON YEAR(A.Plus_EstimatedMaturityDate) = H.Date_Year
				LEFT JOIN _MDT_Conversion_Dim I ON YEAR(A.Plus_PaymentStartDate) = I.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_PledgeId
			, New_TotalPledged
			, CASE WHEN DATENAME(dy,A.New_BeginDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_BeginDate)
					ELSE DATEADD(hh,-7,A.New_BeginDate) END AS New_BeginDate
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, Plus_Kind
			, Plus_TenderType
			, Plus_GiftSource
			, Plus_PlannedGift
			, Plus_CheckNumber
			, New_Confidential
			, CONVERT(NVARCHAR(4000),Plus_AcknowledgementInstructions) AS Plus_AcknowledgementInstructions
			, CONVERT(NVARCHAR(4000),Plus_NewAccountInstructions) AS Plus_NewAccountInstructions
			, CONVERT(NVARCHAR(4000),Plus_SpecialGiftInstructions) AS Plus_SpecialGiftInstructions
			, Plus_TelefundRep
			, New_BalanceDue_Base
			, New_TotalPaid_Base
			, New_PaymentsToMake
			, New_PaymentsReceived
			, Plus_PlannedGivingPaymentFrequency
			, New_InstallmentAmount_Base
			, CASE WHEN DATENAME(dy,A.Plus_InstallmentDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_InstallmentDate)
					ELSE DATEADD(hh,-7,A.Plus_InstallmentDate) END AS Plus_InstallmentDate
			, New_Bookable
			, Plus_MatchExpected
			, Plus_ParentGift
			, OwnerId
			, Plus_GiftRevocability
			, Plus_RemainderBeneficiary
			, Plus_FairMarketValue_Base
			, Plus_PresentValue_Base
			, CASE WHEN DATENAME(dy,A.New_SignatureDate) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_SignatureDate)
					ELSE DATEADD(hh,-7,A.New_SignatureDate) END AS New_SignatureDate
			, New_Documentation
			, CASE WHEN DATENAME(dy,A.New_NotificationDate) BETWEEN F.Mdt_Begin_Date_Number AND F.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_NotificationDate)
					ELSE DATEADD(hh,-7,A.New_NotificationDate) END AS New_NotificationDate
			, CASE WHEN DATENAME(dy,A.Plus_FundingDate) BETWEEN G.Mdt_Begin_Date_Number AND G.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_FundingDate)
					ELSE DATEADD(hh,-7,A.Plus_FundingDate) END AS Plus_FundingDate
			, CASE WHEN DATENAME(dy,A.Plus_EstimatedMaturityDate) BETWEEN H.Mdt_Begin_Date_Number AND H.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EstimatedMaturityDate)
					ELSE DATEADD(hh,-7,A.Plus_EstimatedMaturityDate) END AS Plus_EstimatedMaturityDate
			, CONVERT(NVARCHAR(4000),Plus_Designation) AS Plus_Designation
			, Plus_NameOfTrust
			, plus_PlannedGivingType
			, Plus_VehicleType
			, Plus_VehicleSubType
			, Plus_PayoutRate
			, Plus_PaymentAmount_Base
			, Plus_AnnualAmount_Base
			, Plus_Duration
			, Plus_LivesType
			, Plus_Years
			, Plus_Lives
			, Plus_TermBeneficiaryLives
			, Plus_TermBeneficiaryYears
			, Plus_Cri
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStartDate) BETWEEN I.Mdt_Begin_Date_Number AND I.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStartDate)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStartDate) END AS Plus_PaymentStartDate
			, CONVERT(NVARCHAR(4000),Plus_GpsNotes) AS Plus_GpsNotes
			, Plus_Appeal
			, New_FundAccount
			, New_InstitutionalHierarchy
			, New_ConstituentDonor
			, New_OrganizationDonor
			, New_Opportunity
			, New_BalanceDue
			, New_InstallmentAmount
			--, Plus_ProposalAmount  /*Delete from source 5/15/17*/
			, New_TotalPaid
			, Plus_RecurringGiftRules
			, New_PledgeNumber
			, StatusCode
			, Lds_ExpectancyType
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Pledge'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''38H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Pledge''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- POSTALCODE (Ext_Postal)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_Postal' -- Table_Name
		, 'New_PostalcodeId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			' -- Create_Fields
		, 'New_PostalcodeId
			, New_Name
			' -- Insert_Fields
		, 'New_PostalCodeBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_PostalcodeId
			, New_Name
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Postal'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''39H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Postal''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PROFESSIONALSUFFIX (Ext_Professional_Suffix)
-- --------------------------
	('Donor' -- Dim_Object
		, 'Ext_Professional_Suffix' -- Table_Name
		, 'New_ProfessionalSuffixId UNIQUEIDENTIFIER
			,New_ProfessionalSuffix NVARCHAR(100)
			' -- Create_Fields
		, 'New_ProfessionalSuffixId
			,New_ProfessionalSuffix
			' -- Insert_Fields
		, 'New_ProfessionalSuffixBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_ProfessionalSuffixId
			,New_ProfessionalSuffix
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Professional_Suffix'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''40H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Professional_Suffix''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- PSA (Ext_Psa)
-- --------------------------
	('Dim' -- Dim_Object
		, 'Ext_Psa' -- Table_Name
		, 'ContactId UNIQUEIDENTIFIER
			, Psa_Key UNIQUEIDENTIFIER
			, Psa_Code NVARCHAR(50)
			, Psa_Eff_From DATETIME
			, Psa_Eff_Thru DATETIME
			, Psa_Act_Src NVARCHAR(100)
			, Psa_Entered_Dt DATETIME
			, Psa_Change_Dt DATETIME
			, Psa_Type NVARCHAR(100)
			, Psa_Text_Line NVARCHAR(500)
			' -- Create_Fields
		, 'ContactId
			, Psa_Key
			, Psa_Code
			, Psa_Eff_From
			, Psa_Eff_Thru
			, Psa_Act_Src
			, Psa_Entered_Dt
			, Psa_Change_Dt
			, Psa_Type
			, Psa_Text_Line
			' -- Insert_Fields
		, 'Plus_LegacyPsaCodeBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_EffectiveFrom) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_EffectiveTo) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.CreatedOn) = D.Date_Year
				LEFT JOIN _MDT_Conversion_Dim E ON YEAR(A.ModifiedOn) = E.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'DISTINCT Plus_Constituent AS ContactId 
			, Plus_LegacyPsaCodeId AS Psa_Key
			, CONVERT(NVARCHAR(50),Plus_PsaCode) AS Psa_Code
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveFrom) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveFrom)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveFrom) END AS Psa_Eff_From
			, CASE WHEN DATENAME(dy,A.Plus_EffectiveTo) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_EffectiveTo)
					ELSE DATEADD(hh,-7,A.Plus_EffectiveTo) END AS Psa_Eff_Thru
			, Plus_Source AS Psa_Act_Src
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS Psa_Entered_Dt
			, CASE WHEN DATENAME(dy,A.ModifiedOn) BETWEEN E.Mdt_Begin_Date_Number AND E.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.ModifiedOn)
					ELSE DATEADD(hh,-7,A.ModifiedOn) END AS Psa_Change_Dt
			, Plus_Category AS Psa_Type
			, CONVERT(NVARCHAR(500),Plus_CodeDescription) AS Psa_Text_Line
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Psa'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''41H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Psa''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- RECOGNITION (Ext_Recognition)
-- --------------------------
	('Award' -- Dim_Object
		, 'Ext_Recognition' -- Table_Name
		, 'New_RecognitionId UNIQUEIDENTIFIER
			, StateCode INT
			, StatusCode INT
			, New_EndDate DATETIME
			, New_ShortName NVARCHAR(100)
			, New_InstitutionId UNIQUEIDENTIFIER
			, New_Description NVARCHAR(500)
			, New_Affiliate INT
			, New_AssociationId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, New_StartDate DATETIME
			, New_Type INT
			' -- Create_Fields
		, 'New_RecognitionId
			, StateCode
			, StatusCode
			, New_EndDate
			, New_ShortName
			, New_InstitutionId
			, New_Description
			, New_Affiliate
			, New_AssociationId
			, New_Name
			, New_StartDate
			, New_Type
			' -- Insert_Fields
		, 'New_RecognitionBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_EndDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_StartDate) = C.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_RecognitionId
			, StateCode
			, StatusCode
			, CASE WHEN DATENAME(dy,A.New_EndDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_EndDate)
					ELSE DATEADD(hh,-7,A.New_EndDate) END AS New_EndDate
			, New_ShortName
			, New_InstitutionId
			, CONVERT(NVARCHAR(500),New_Description) AS New_Description			
			, New_Affiliate
			, New_AssociationId
			, New_Name
			, CASE WHEN DATENAME(dy,A.New_StartDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_StartDate)
					ELSE DATEADD(hh,-7,A.New_StartDate) END AS New_StartDate
			, New_Type
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Recognition'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''42H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Recognition''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- RECOGNITION CREDIT (Ext_Recognition_Credit)
-- --------------------------
	('Recognition' -- Dim_Object
		, 'Ext_Recognition_Credit' -- Table_Name
		, 'New_RecognitionCreditId UNIQUEIDENTIFIER
			, New_RelatedConstituent UNIQUEIDENTIFIER
			, New_OrganizationId UNIQUEIDENTIFIER
			, New_RelatedGift UNIQUEIDENTIFIER
			, New_CreditAmount MONEY
			, Plus_Type INT
			--, Plus_SharedCreditType INT  /*Delete from source 5/15/17*/
			, Plus_OriginatingConstituent UNIQUEIDENTIFIER
			, Plus_SubType INT
			, New_ReceiptDate DATETIME
			, Plus_InstitutionalHieararchy UNIQUEIDENTIFIER
			, StatusCode INT
			' -- Create_Fields
		, 'New_RecognitionCreditId
			, New_RelatedConstituent
			, New_OrganizationId
			, New_RelatedGift
			, New_CreditAmount
			, Plus_Type
			--, Plus_SharedCreditType  /*Delete from source 5/15/17*/
			, Plus_OriginatingConstituent
			, Plus_SubType
			, New_ReceiptDate
			, Plus_InstitutionalHieararchy
			, StatusCode
			' -- Insert_Fields
		, 'New_RecognitionCreditBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_ReceiptDate) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_RecognitionCreditId
			, New_RelatedConstituent
			, New_OrganizationId
			, New_RelatedGift
			, New_CreditAmount
			, Plus_Type
			--, Plus_SharedCreditType  /*Delete from source 5/15/17*/
			, Plus_OriginatingConstituent
			, Plus_SubType
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, Plus_InstitutionalHieararchy
			, StatusCode
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Recognition_Credit'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''43H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Recognition_Credit''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL	
	)	
	,
-- --------------------------
-- Source (Ext_Source)
-- --------------------------
	('Source' -- Dim_Object
		, 'Ext_Source' -- Table_Name
		, 'New_SourceId UNIQUEIDENTIFIER
			, New_Source NVARCHAR(100)
			, New_LongDescription NVARCHAR(100)
			' -- Create_Fields
		, 'New_SourceId
			, New_Source
			, New_LongDescription
			' -- Insert_Fields
		, 'New_SourceBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_SourceId
			, New_Source
			, New_LongDescription
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Source'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''44H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Source''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- STATE (Ext_State)
-- --------------------------
	('Address' -- Dim_Object
		, 'Ext_State' -- Table_Name
		, 'New_StateId UNIQUEIDENTIFIER
			, New_Name NVARCHAR(100)
			, Plus_Abbreviation NVARCHAR(50)
			' -- Create_Fields
		, 'New_StateId
			, New_Name
			, Plus_Abbreviation
			' -- Insert_Fields
		, 'New_StateBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_StateId
			, New_Name
			, Plus_Abbreviation
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_State'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''45H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_State''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Student (Ext_Student)
-- --------------------------
	('Ext_Student' -- Dim_Object
		, 'Ext_Student' -- Table_Name
		, 'New_StudentAttendanceId UNIQUEIDENTIFIER
			, New_Term NVARCHAR(100)
			, New_Year NVARCHAR(100)
			, New_HoursCompleted INT
			, New_ExpectedGraduationDate DATETIME
			, Plus_Year NVARCHAR(10)
			, New_StudentsAttendanceId UNIQUEIDENTIFIER
			, New_Source UNIQUEIDENTIFIER
			, New_College UNIQUEIDENTIFIER
			, New_University UNIQUEIDENTIFIER
			, New_Major UNIQUEIDENTIFIER
			, Plus_Emphasis UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'New_StudentAttendanceId
			, New_Term
			, New_Year
			, New_HoursCompleted
			, New_ExpectedGraduationDate
			, Plus_Year
			, New_StudentsAttendanceId
			, New_Source
			, New_College
			, New_University
			, New_Major
			, Plus_Emphasis
			' -- Insert_Fields
		, 'New_StudentAttendanceBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.New_ExpectedGraduationDate) = B.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_StudentAttendanceId
			, New_Term
			, New_Year
			, New_HoursCompleted
			, CASE WHEN DATENAME(dy,A.New_ExpectedGraduationDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ExpectedGraduationDate)
					ELSE DATEADD(hh,-7,A.New_ExpectedGraduationDate) END AS New_ExpectedGraduationDate
			, Plus_Year
			, New_StudentsAttendanceId
			, New_Source
			, New_College
			, New_University
			, New_Major
			, Plus_Emphasis
			' -- Attribute_1
		, ' ' -- Attribute_2
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Student'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_StudentAttendanceBase_Orphans'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_StudentAttendanceBase_Orphans;
					CREATE TABLE Check_New_StudentAttendanceBase_Orphans (
						New_StudentAttendanceId NVARCHAR(100)
						, New_StudentsAttendanceId NVARCHAR(100)
						, Is_Orphaned NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_StudentAttendanceBase_Orphans (
						New_StudentAttendanceId
						, New_StudentsAttendanceId
						, Is_Orphaned
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_StudentAttendanceId) AS New_StudentAttendanceId
						, CASE WHEN CONVERT(NVARCHAR(100),New_StudentsAttendanceId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_StudentsAttendanceId) END AS New_StudentsAttendanceId
						, ''Y'' AS Is_Orphaned
						, ''N'' AS Record_Deleted
						FROM New_StudentAttendanceBase
						WHERE 1 = 1
							AND New_StudentsAttendanceId IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_3
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Student T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_StudentAttendanceId) AS New_StudentAttendanceId
								FROM Check_New_StudentAttendanceBase_Orphans
								WHERE 1 = 1 
									AND New_StudentAttendanceId != ''NULL''
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_StudentAttendanceBase_Orphans T
						USING (
								SELECT DISTINCT A.New_StudentAttendanceId
									FROM Check_New_StudentAttendanceBase_Orphans A
										LEFT JOIN Ext_Student B ON A.New_StudentAttendanceId = CONVERT(NVARCHAR(100),B.New_StudentAttendanceId)
									WHERE 1 = 1
										AND (B.New_StudentAttendanceId IS NULL
												OR A.New_StudentAttendanceId = ''NULL'')
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_4
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_StudentAttendanceBase_Orphans)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_StudentAttendanceId AS ''td'','''', New_StudentsAttendanceId AS ''td'','''', Is_Orphaned AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_StudentAttendanceBase_Orphans
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_StudentAttendanceId </th> <th> New_StudentsAttendanceId </th> <th> Is_Orphaned </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''								
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_StudentAttendanceBase Orphans''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_StudentAttendanceBase_Orphans''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_StudentAttendanceBase_Orphans.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_StudentAttendanceBase_Orphans)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_5
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Student'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_StudentAttendanceBase_Plus_Year'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_StudentAttendanceBase_Plus_Year;
					CREATE TABLE Check_New_StudentAttendanceBase_Plus_Year (
						New_StudentAttendanceId NVARCHAR(100)
						, New_StudentsAttendanceId NVARCHAR(100)
						, Plus_Year NVARCHAR(100)
						, Is_Invalid_Year NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_StudentAttendanceBase_Plus_Year (
						New_StudentAttendanceId
						, New_StudentsAttendanceId
						, Plus_Year
						, Is_Invalid_Year
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_StudentAttendanceId) AS New_StudentAttendanceId
						, CASE WHEN CONVERT(NVARCHAR(100),New_StudentsAttendanceId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_StudentsAttendanceId) END AS New_StudentsAttendanceId
						, CASE WHEN Plus_Year IS NULL THEN ''NULL'' ELSE Plus_Year END AS Plus_Year
						, ''Y'' AS Is_Invalid_Year
						, ''N'' AS Record_Deleted
						FROM New_StudentAttendanceBase
						WHERE 1 = 1
							AND LEN(Plus_Year) != 4
							OR Plus_Year IS NULL
							OR ISNUMERIC(Plus_Year) = 0
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_6
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Student T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_StudentAttendanceId) AS New_StudentAttendanceId
								FROM Check_New_StudentAttendanceBase_Plus_Year
								WHERE 1 = 1 
									AND New_StudentAttendanceId != ''NULL''
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_StudentAttendanceBase_Plus_Year T
						USING (
								SELECT DISTINCT A.New_StudentAttendanceId 
									FROM Check_New_StudentAttendanceBase_Plus_Year A
										LEFT JOIN Ext_Student B ON A.New_StudentAttendanceId = CONVERT(NVARCHAR(100),B.New_StudentAttendanceId)
									WHERE 1 = 1
										AND (B.New_StudentAttendanceId IS NULL
												OR A.New_StudentAttendanceId = ''NULL'')
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_7
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_StudentAttendanceBase_Plus_Year)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_StudentAttendanceId AS ''td'','''', New_StudentsAttendanceId AS ''td'','''', Plus_Year AS ''td'','''', Is_Invalid_Year AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_StudentAttendanceBase_Plus_Year
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_StudentAttendanceId </th> <th> New_StudentsAttendancId </th> <th> Plus_Year </th> <th> Is_Invalid_Year </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''				
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_StudentAttendanceBase Plus_Year''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_StudentAttendanceBase_Plus_Year''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_StudentAttendanceBase_Plus_Year.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_StudentAttendanceBase_Plus_Year)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_8
		, 'BEGIN TRY
				DECLARE @TABLE_CNT1 AS VARCHAR(100)
				DECLARE @TABLE_NAME VARCHAR(100)
				DECLARE @CHECK_TABLE_NAME NVARCHAR(100)
				SET @TABLE_NAME = ''Ext_Student'' ; ------> HARDCODE <------
				SET @CHECK_TABLE_NAME = ''Check_New_StudentAttendanceBase_New_Term'';  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - Begin'', @Alpha_Result = 1;   
				
					-- Detection
					DROP TABLE IF EXISTS Check_New_StudentAttendanceBase_New_Term;
					CREATE TABLE Check_New_StudentAttendanceBase_New_Term (
						New_StudentAttendanceId NVARCHAR(100)
						, New_StudentsAttendanceId NVARCHAR(100)
						, New_Term NVARCHAR(100)
						, Is_Invalid_New_Term NVARCHAR(1)
						, Record_Deleted NVARCHAR(1)
					)
					INSERT INTO Check_New_StudentAttendanceBase_New_Term (
						New_StudentAttendanceId
						, New_StudentsAttendanceId
						, New_Term
						, Is_Invalid_New_Term
						, Record_Deleted
					)
					SELECT CONVERT(NVARCHAR(100),New_StudentAttendanceId) AS New_StudentAttendanceId
						, CASE WHEN CONVERT(NVARCHAR(100),New_StudentsAttendanceId) IS NULL THEN ''NULL'' ELSE CONVERT(NVARCHAR(100),New_StudentsAttendanceId) END AS New_StudentsAttendanceId
						, CASE WHEN New_Term IS NULL THEN ''NULL'' ELSE New_Term END AS New_Term
						, ''Y'' AS Is_Invalid_New_Term
						, ''N'' AS Record_Deleted
						FROM New_StudentAttendanceBase
						WHERE 1 = 1
							AND New_Term NOT LIKE ''Winter%''
							AND New_Term NOT LIKE ''Spring%''
							AND New_Term NOT LIKE ''Summer%''
							AND New_Term NOT LIKE ''Fall%''
							OR New_Term IS NULL
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Detection - End'', @Alpha_Result = 1;
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
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Detection - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH	
			' -- Attribute_9
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Delete Records
					MERGE INTO Ext_Student T
						USING (
								SELECT DISTINCT CONVERT(UNIQUEIDENTIFIER,New_StudentAttendanceId) AS New_StudentAttendanceId
								FROM Check_New_StudentAttendanceBase_New_Term
								WHERE 1 = 1 
									AND New_StudentAttendanceId != ''NULL''
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							DELETE
								;
					-- Update Check Table
					MERGE INTO Check_New_StudentAttendanceBase_New_Term T
						USING (
								SELECT DISTINCT A.New_StudentAttendanceId 
									FROM Check_New_StudentAttendanceBase_New_Term A
										LEFT JOIN Ext_Student B ON A.New_StudentAttendanceId = CONVERT(NVARCHAR(100),B.New_StudentAttendanceId)
									WHERE 1 = 1
										AND (B.New_StudentAttendanceId IS NULL
												OR A.New_StudentAttendanceId = ''NULL'')
							) S ON T.New_StudentAttendanceId = S.New_StudentAttendanceId
						WHEN MATCHED THEN 
							UPDATE
								SET T.Record_Deleted = ''Y''
								;								
								
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH 
			' -- Attribute_10
		, 'BEGIN TRY
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Begin'', @Alpha_Result = 1;   
				
					-- Send Notification
					DECLARE @Email_Check_Cnt INT
					DECLARE @Email_Check_Body NVARCHAR(4000)
					SELECT @Email_Check_Cnt = (SELECT COUNT(*) FROM Check_New_StudentAttendanceBase_New_Term)
						IF (@Email_Check_Cnt > 0) 
							BEGIN	
								IF (@Email_Check_Cnt = 1)
									BEGIN
										SET @Email_Check_Body = ''There was '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check error.''
									END
								ELSE
									BEGIN
										SET @Email_Check_Body = ''There were '' + CONVERT(NVARCHAR(10),@Email_Check_Cnt) + '' data check errors.''
									END							
								DECLARE @Check_Xml NVARCHAR(MAX)
								DECLARE @Check_Body NVARCHAR(MAX)								
								SET @Check_Xml = CAST((SELECT New_StudentAttendanceId AS ''td'','''', New_StudentsAttendanceId AS ''td'','''', New_Term AS ''td'','''', Is_Invalid_New_Term AS ''td'','''', Record_Deleted AS ''td'' FROM Check_New_StudentAttendanceBase_New_Term
										FOR XML PATH(''tr''), ELEMENTS ) AS NVARCHAR(MAX))									
									SET @Check_Body =''<html><body><H3> '' + @Email_Check_Body + ''</H3>
										<table border = 1> 
										<tr>
										<th> New_StudentAttendanceId </th> <th> New_StudentsAttendancId </th> <th> New_Term </th> <th> Is_Invalid_New_Term </th> <th> Record_Deleted </th> </tr>''    										 
									SET @Check_Body = @Check_Body + @Check_Xml +''</table></body></html>''						
								EXEC msdb.dbo.sp_send_dbmail
									@recipients = ''fams@LDSChurch.org'' 
									, @subject = ''Check New_StudentAttendanceBase New_Term''  -->>>>>> EMAIL SUBJECT <<<<<<<--
									, @body = @Check_Body
									, @body_format = ''HTML''
									, @query = ''SELECT * FROM OneAccord_Warehouse.dbo.Check_New_StudentAttendanceBase_New_Term''
									, @query_result_header=1
									, @query_no_truncate=1
									, @attach_query_result_as_file=1
									, @query_attachment_filename = ''Check_New_StudentAttendanceBase_New_Term.csv''
									, @query_result_separator = ''^''
							END

				SELECT @TABLE_CNT1 = (SELECT CONVERT(NVARCHAR(100),COUNT(*)) FROM Check_New_StudentAttendanceBase_New_Term)  ----->  HARDCODE  <-----
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - Count'', @Alpha_Count = @TABLE_CNT1, @Alpha_Result = 1;
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1G'', @Alpha_Step_Name = ''Check Table Update - End'', @Alpha_Result = 1;
			END TRY 
			BEGIN CATCH
				SELECT @ERROR_NUMBER = (SELECT ERROR_NUMBER())
				SELECT @ERROR_SEVERITY = (SELECT ERROR_SEVERITY())
				SELECT @ERROR_STATE = (SELECT ERROR_STATE())
				SELECT @ERROR_PROCEDURE = (SELECT ERROR_PROCEDURE())
				SELECT @ERROR_LINE = (SELECT ERROR_LINE())
				SELECT @ERROR_MESSAGE = (SELECT ERROR_MESSAGE())
				EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @CHECK_TABLE_NAME, @Alpha_Step_Number = ''1X'', @Alpha_Step_Name = ''Check Table Update - Error'', @Alpha_Result = 0
				, @ErrorNumber = @ERROR_NUMBER, @ErrorSeverity = @ERROR_SEVERITY, @ErrorState = @ERROR_STATE, @ErrorProcedure = @ERROR_PROCEDURE, @ErrorLine = @ERROR_LINE, @ErrorMessage = @ERROR_MESSAGE;  
			END CATCH
			' -- Attribute_11
		, ' ' -- Attribute_12
		, ' ' -- Attribute_13
		, ' ' -- Attribute_14
		, ' ' -- Attribute_15
		, ' ' -- Attribute_16
		, ' ' -- Attribute_17
		, ' ' -- Attribute_18
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Student'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''46H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Student''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- TITLE (Ext_Title)
-- --------------------------
	('Donor' -- Dim_Object
		, 'Ext_Title' -- Table_Name
		, 'New_TitleId UNIQUEIDENTIFIER
			, New_Title NVARCHAR(100)
			' -- Create_Fields
		, 'New_TitleId
			, New_Title
			' -- Insert_Fields
		, 'New_TitleBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_TitleId
			, New_Title
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Title'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''47H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Title''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- University (Ext_University)
-- --------------------------
	('Ext_University' -- Dim_Object
		, 'Ext_University' -- Table_Name
		, 'New_UniversityId UNIQUEIDENTIFIER
			, New_University NVARCHAR(100)
			, New_UniversityCode NVARCHAR(10)
			, Plus_UniversityAcronym NVARCHAR(100)
			' -- Create_Fields
		, 'New_UniversityId
			, New_University
			, New_UniversityCode
			, Plus_UniversityAcronym
			' -- Insert_Fields
		, 'New_UniversityBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_UniversityId
			, New_University
			, New_UniversityCode
			, Plus_UniversityAcronym
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_University'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''48H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_University''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- USER (Ext_System_User)
-- --------------------------
	('User' -- Dim_Object
		, 'Ext_System_User' -- Table_Name
		, 'SystemUserId UNIQUEIDENTIFIER
			, FullName NVARCHAR(200)
			, FirstName NVARCHAR(64)
			, LastName NVARCHAR(64)
			, PersonalEmailAddress NVARCHAR(100)
			, Title NVARCHAR(128)
			, InternalEmailAddress NVARCHAR(100)
			, MobilePhone NVARCHAR(64)
			, DomainName NVARCHAR(1024)
			' -- Create_Fields
		, 'SystemUserId
			, FullName
			, FirstName
			, LastName
			, PersonalEmailAddress
			, Title
			, InternalEmailAddress
			, MobilePhone
			, DomainName
			' -- Insert_Fields
		, 'SystemUserBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'SystemUserId
			, FullName
			, FirstName
			, LastName
			, PersonalEmailAddress
			, Title
			, InternalEmailAddress
			, MobilePhone
			, DomainName
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_System_User'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''49H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_System_User''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,	
-- --------------------------
-- STRING_MAP (Ext_String_Map)
-- --------------------------
	('Ext_String_Map' -- Dim_Object
		, 'Ext_String_Map' -- Table_Name
		, 'ObjectTypeCode INT
			, AttributeName NVARCHAR(100)
			, AttributeValue INT
			, LangId INT
			, OrganizationId UNIQUEIDENTIFIER
			, Value NVARCHAR(4000)
			, DisplayOrder INT
			--, VersionNumber TIMESTAMP
			, StringMapId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ObjectTypeCode
			, AttributeName
			, AttributeValue
			, LangId
			, OrganizationId
			, Value
			, DisplayOrder
			--, VersionNumber
			, StringMapId
			' -- Insert_Fields
		, 'dbo.StringMapBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ObjectTypeCode
			, AttributeName
			, AttributeValue
			, LangId
			, OrganizationId
			, Value
			, DisplayOrder
			--, VersionNumber
			, StringMapId
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_String_Map'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''50H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_String_Map''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,	
-- --------------------------
-- Entity (Ext_Entity)
-- --------------------------
	('Ext_Entity' -- Dim_Object
		, 'Ext_Entity' -- Table_Name
		, 'ObjectTypeCode INT
			, PhysicalName NVARCHAR(64)
			, EntityId UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ObjectTypeCode
			, PhysicalName
			, EntityId
			' -- Insert_Fields
		, 'Entity
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ObjectTypeCode
			, PhysicalName
			, EntityId
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Entity'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''51H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Entity''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_LegacyM11Base (Ext_Plus_LegacyM11Base)
-- --------------------------
	('Ext_Plus_LegacyM11Base' -- Dim_Object
		, 'Ext_Plus_LegacyM11Base' -- Table_Name
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_Source UNIQUEIDENTIFIER
			, Plus_M11ActivityType INT
			, Plus_M11MessageType INT
			' -- Create_Fields
		, 'ActivityId
			, Plus_Source
			, Plus_M11ActivityType
			, Plus_M11MessageType
			' -- Insert_Fields
		, 'Plus_LegacyM11Base
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityId
			, Plus_Source
			, Plus_M11ActivityType
			, Plus_M11MessageType
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Plus_LegacyM11Base'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''52H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Plus_LegacyM11Base''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Date_Dim (Ext_Date_Dim)
-- --------------------------
	('Ext_Date_Dim' -- Dim_Object
		, 'Ext_Date_Dim' -- Table_Name
		, 'Date_Key NUMERIC(10,0)
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
			' -- Create_Fields
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
		, 'Date_Dim
			' -- From_Statement
		, ' ' -- Where_Statement
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
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Date_Dim'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''53H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Date_Dim''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Batch (Ext_Batch)
-- --------------------------
	('Batch' -- Dim_Object
		, 'Ext_Batch' -- Table_Name
		, 'New_BatchesId UNIQUEIDENTIFIER
			, New_BatchNumber NVARCHAR(100)
			, Lds_BatchType INT
			' -- Create_Fields
		, 'New_BatchesId
			, New_BatchNumber
			, Lds_BatchType
			' -- Insert_Fields
		, 'New_BatchesBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_BatchesId
			, New_BatchNumber
			, Lds_BatchType
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Batch'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''54H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Batch''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)	
	,
-- --------------------------
-- Gift_Hist (Ext_Gift_Hist)
-- --------------------------
	('Ext_Gift_Hist' -- Dim_Object
		, 'Ext_Gift_Hist' -- Table_Name
		, 'New_RelatedGift UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_Organization UNIQUEIDENTIFIER
			, Plus_FundAccount UNIQUEIDENTIFIER
			, OwnerId UNIQUEIDENTIFIER
			, Plus_AccountingDate DATETIME
			, StatusCode INT
			, New_Amount MONEY
			, New_ReceiptDate DATETIME
			, New_TenderType INT
			, Plus_Kind INT
			, Plus_Transmitted BIT
			, Plus_Description NVARCHAR(4000)
			, Plus_ReceiptText NVARCHAR(4000)
			, New_Name NVARCHAR(100)
			, Plus_GiftAdjustmentNote NVARCHAR(4000)
			, New_GiftHistoryId UNIQUEIDENTIFIER
			, Plus_GiftNumber NVARCHAR(50)
			, Plus_PostDate DATETIME
			' -- Create_Fields
		, 'New_RelatedGift
			, Plus_Constituent
			, Plus_Organization
			, Plus_FundAccount
			, OwnerId
			, Plus_AccountingDate
			, StatusCode
			, New_Amount
			, New_ReceiptDate
			, New_TenderType
			, Plus_Kind
			, Plus_Transmitted
			, Plus_Description
			, Plus_ReceiptText
			, New_Name
			, Plus_GiftAdjustmentNote
			, New_GiftHistoryId
			, Plus_GiftNumber
			, Plus_PostDate
			' -- Insert_Fields
		, 'New_GiftHistoryBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_AccountingDate) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.New_ReceiptDate) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.Plus_PostDate) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'New_RelatedGift
			, Plus_Constituent
			, Plus_Organization
			, Plus_FundAccount
			, OwnerId
			, CASE WHEN DATENAME(dy,A.Plus_AccountingDate) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_AccountingDate)
					ELSE DATEADD(hh,-7,A.Plus_AccountingDate) END AS Plus_AccountingDate
			, StatusCode
			, New_Amount
			, CASE WHEN DATENAME(dy,A.New_ReceiptDate) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.New_ReceiptDate)
					ELSE DATEADD(hh,-7,A.New_ReceiptDate) END AS New_ReceiptDate
			, New_TenderType
			, Plus_Kind
			, Plus_Transmitted
			, CONVERT(NVARCHAR(4000),Plus_Description) AS Plus_Description
			, CONVERT(NVARCHAR(4000),Plus_ReceiptText) AS Plus_ReceiptText
			, New_Name
			, CONVERT(NVARCHAR(4000),Plus_GiftAdjustmentNote) AS Plus_GiftAdjustmentNote
			, New_GiftHistoryId
			, Plus_GiftNumber
			, CASE WHEN DATENAME(dy,A.Plus_PostDate) BETWEEN D.Mdt_Begin_Date_Number AND D.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PostDate)
					ELSE DATEADD(hh,-7,A.Plus_PostDate) END AS Plus_PostDate
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Gift_Hist'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''55H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Gift_Hist''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_RecurringGiftRules (Ext_Recurring_Gift_Rules)
-- --------------------------
	('Ext_Recurring_Gift_Rules' -- Dim_Object
		, 'Ext_Recurring_Gift_Rules' -- Table_Name
		, 'Plus_RecurringGiftRulesId UNIQUEIDENTIFIER
			, Plus_Constituent UNIQUEIDENTIFIER
			, Plus_FundAccount UNIQUEIDENTIFIER
			, Plus_InstitutionalHiearchy UNIQUEIDENTIFIER
			, Plus_CampaignAppeal UNIQUEIDENTIFIER
			, StatusCode INT
			, StateCode INT
			, Plus_Frequency INT
			, Plus_PaymentStart DATETIME
			, Plus_PaymentStop DATETIME
			, Plus_Amount MONEY
			, Plus_Group UNIQUEIDENTIFIER
			, Plus_Type INT
			, Plus_Organization UNIQUEIDENTIFIER
			, CreatedOn DATETIME
			' -- Create_Fields
		, 'Plus_RecurringGiftRulesId
			, Plus_Constituent
			, Plus_FundAccount
			, Plus_InstitutionalHiearchy
			, Plus_CampaignAppeal
			, StatusCode
			, StateCode
			, Plus_Frequency
			, Plus_PaymentStart
			, Plus_PaymentStop
			, Plus_Amount
			, Plus_Group
			, Plus_Type
			, Plus_Organization
			, CreatedOn
			' -- Insert_Fields
		, 'Plus_RecurringGiftRulesBase A
				LEFT JOIN _MDT_Conversion_Dim B ON YEAR(A.Plus_PaymentStart) = B.Date_Year
				LEFT JOIN _MDT_Conversion_Dim C ON YEAR(A.Plus_PaymentStop) = C.Date_Year
				LEFT JOIN _MDT_Conversion_Dim D ON YEAR(A.CreatedOn) = D.Date_Year
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_RecurringGiftRulesId
			, Plus_Constituent
			, Plus_FundAccount
			, Plus_InstitutionalHiearchy
			, Plus_CampaignAppeal
			, StatusCode
			, StateCode
			, Plus_Frequency
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStart) BETWEEN B.Mdt_Begin_Date_Number AND B.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStart)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStart) END AS Plus_PaymentStart
			, CASE WHEN DATENAME(dy,A.Plus_PaymentStop) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.Plus_PaymentStop)
					ELSE DATEADD(hh,-7,A.Plus_PaymentStop) END AS Plus_PaymentStop 
			, Plus_Amount
			, Plus_Group
			, Plus_Type
			, Plus_Organization
			, CASE WHEN DATENAME(dy,A.CreatedOn) BETWEEN C.Mdt_Begin_Date_Number AND C.Mdt_End_Date_Number THEN DATEADD(hh,-6,A.CreatedOn)
					ELSE DATEADD(hh,-7,A.CreatedOn) END AS CreatedOn
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Recurring_Gift_Rules'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''56H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Recurring_Gift_Rules''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- CampaignResponseBase (Ext_Campaign_Response)
-- --------------------------
	('Ext_Campaign_Response' -- Dim_Object
		, 'Ext_Campaign_Response' -- Table_Name
		, 'ActivityId UNIQUEIDENTIFIER
			, Plus_CampaignAppeal UNIQUEIDENTIFIER
			' -- Create_Fields
		, 'ActivityId
			, Plus_CampaignAppeal
			' -- Insert_Fields
		, 'CampaignResponseBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'ActivityId
			, Plus_CampaignAppeal
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Campaign_Response'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''57H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Campaign_Response''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	,
-- --------------------------
-- Plus_PayrollGroupBase (Ext_Payroll_Group)
-- --------------------------
	('Ext_Payroll_Group' -- Dim_Object
		, 'Ext_Payroll_Group' -- Table_Name
		, 'Plus_PayrollGroupId UNIQUEIDENTIFIER
			, Plus_Name NVARCHAR(100)
			, Plus_Code NVARCHAR(100)
			' -- Create_Fields
		, 'Plus_PayrollGroupId
			, Plus_Name
			, Plus_Code
			' -- Insert_Fields
		, 'Plus_PayrollGroupBase
			' -- From_Statement
		, ' ' -- Where_Statement
		, 'Plus_PayrollGroupId
			, Plus_Name
			, Plus_Code
			' -- Attribute_1
		, ' ' -- Attribute_2
		, ' ' -- Attribute_3
		, ' ' -- Attribute_4
		, ' ' -- Attribute_5
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
		, 'DECLARE @TABLE_NAME VARCHAR(100)
			SET @TABLE_NAME = ''Ext_Payroll_Group'' ; ------> HARDCODE <------
			EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = @TABLE_NAME, @Alpha_Step_Number = ''58H'', @Alpha_Step_Name = ''End'', @Alpha_Result = 1;
			' -- Attribute_19
		, 'EXEC dbo.usp_Extract_Data @Extract_Data_Table_Name = ''Ext_Payroll_Group''; ------> HARDCODE <------
			' -- Attribute_20
		, 1
		, GETDATE()
		, NULL
	)
	
	;




	
EXEC dbo.usp_Insert_Alpha_1 @Alpha_Stage = 'End of extract DDLs', @Alpha_Step_Number = '0Z', @Alpha_Step_Name = 'Extract End', @Alpha_Result = 1;



-- -------------------------------------------------------------------------------------------------




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

						SELECT @TABLE_NAME4 = (SELECT Table_Name FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @CREATE_FIELDS4 = (SELECT Create_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @INSERT_FIELDS4 = (SELECT Insert_Fields FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @FROM_STATEMENT4 = (SELECT From_Statement FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @ATTRIBUTE14 = (SELECT Attribute_1 FROM OneAccord_Warehouse.dbo.Create_Extract_Tables WHERE Active = 1 AND Fields_Key = @Main_LOOP_NUM);
						SELECT @SQL_ATTRIBUTE2 = (SELECT ATTRIBUTE_2 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE3 = (SELECT ATTRIBUTE_3 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE4 = (SELECT ATTRIBUTE_4 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);
						SELECT @SQL_ATTRIBUTE5 = (SELECT ATTRIBUTE_5 FROM Create_Extract_Tables WHERE Table_Name = @Table_Name_By_Loop);

						SET @SQL_4A = 'INSERT INTO ' + @TABLE_NAME4 + ' (' + @INSERT_FIELDS4 + ') SELECT ' + @ATTRIBUTE14 + ' FROM ' + @FROM_STATEMENT4										
						EXEC(@SQL_4A + ' ' + @SQL_ATTRIBUTE2 + ' ' + @SQL_ATTRIBUTE3 + ' ' + @SQL_ATTRIBUTE4 + ' ' + @SQL_ATTRIBUTE5)														

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


	
	