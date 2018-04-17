/******************************************************************************
   NAME: usp_Barsoom 
   PURPOSE: Check for changes in the Create_Trans_Load_Tables
   PLATFORM: Sql Server Management Studio

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        1/30/2017      Fams           1. Development of the initial script

   
   Set in the Create_Trans_Load_Table
   Line: 11644
	DECLARE @Barsoom_Base BIGINT
		SET @Barsoom_Base = ((189 - 1465900)/-1)
	EXEC usp_Barsoom @Barsoom_Cnt = @Barsoom_Base

	SELECT * 
		FROM Barsoom
   
******************************************************************************/

USE [OneAccord_Warehouse]
GO

SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER PROCEDURE dbo.usp_Barsoom @Barsoom_Cnt AS BIGINT
AS
BEGIN

	IF NOT EXISTS (SELECT * FROM sysobjects WHERE Name = 'Barsoom' AND xtype = 'U')
		CREATE TABLE Barsoom(
			Barsoom_Date DATETIME
		)

	DECLARE @Jasoom_Cnt BIGINT
	SELECT @Jasoom_Cnt = (SELECT Len_1
							+ Len_2
							+ Len_3
							+ Len_4
							+ Len_5
							+ Len_6
							+ Len_7
							+ Len_8
							+ Len_9
							+ Len_10
							+ Len_11
							+ Len_12
							+ Len_13
							+ Len_14
							+ Len_15
							+ Len_16
							+ Len_17
							+ Len_18
							+ Len_19
							+ Len_20
							+ Len_21
							+ Len_22
							+ Len_23
							+ Len_24
							+ Len_25
							+ Len_26 AS Jasoom_Cnt -- 603,005
							FROM
								(SELECT SUM(LEN(Dim_Object)) AS Len_1
									, SUM(LEN(Table_Name)) AS Len_2
									, SUM(LEN(Create_Fields)) AS Len_3
									, SUM(LEN(Insert_Fields)) AS Len_4
									, SUM(LEN(From_Statement)) AS Len_5
									, SUM(LEN(Where_Statement)) AS Len_6
									, SUM(LEN(Attribute_1)) AS Len_7
									, SUM(LEN(Attribute_2)) AS Len_8
									, SUM(LEN(Attribute_3)) AS Len_9
									, SUM(LEN(Attribute_4)) AS Len_10
									, SUM(LEN(Attribute_5)) AS Len_11
									, SUM(LEN(Attribute_6)) AS Len_12
									, SUM(LEN(Attribute_7)) AS Len_13
									, SUM(LEN(Attribute_8)) AS Len_14
									, SUM(LEN(Attribute_9)) AS Len_15
									, SUM(LEN(Attribute_10)) AS Len_16
									, SUM(LEN(Attribute_11)) AS Len_17
									, SUM(LEN(Attribute_12)) AS Len_18
									, SUM(LEN(Attribute_13)) AS Len_19
									, SUM(LEN(Attribute_14)) AS Len_20
									, SUM(LEN(Attribute_15)) AS Len_21
									, SUM(LEN(Attribute_16)) AS Len_22
									, SUM(LEN(Attribute_17)) AS Len_23
									, SUM(LEN(Attribute_18)) AS Len_24
									, SUM(LEN(Attribute_19)) AS Len_25
									, SUM(LEN(Attribute_20)) AS Len_26
									FROM Create_Trans_Load_Tables
								) A
							)

	IF @Barsoom_Cnt != @Jasoom_Cnt
		BEGIN

			DECLARE @Email_Body NVARCHAR(MAX)
			DECLARE @Barsoom_Date_Cnt INT
			DECLARE @Barsoom_Multiplier INT
			DECLARE @Barsoom_Multiplier2 NVARCHAR(10)
			DECLARE @Wait_Time NVARCHAR(10)

			SET @Barsoom_Multiplier2 = '0'
			SET @Email_Body = 'The ETL table has been altered.   Barsoom: ' + CONVERT(VARCHAR(12),@Barsoom_Cnt) + '     Jasoom: ' + CONVERT(VARCHAR(12),@Jasoom_Cnt)
				
				EXEC msdb.dbo.sp_send_dbmail
				@recipients = 'fams@LDSChurch.org; rburggraaf@comcast.net' 
				, @subject = 'Transform - Barsoom'  -->>>>>> EMAIL SUBJECT <<<<<<<--
				, @body = @Email_Body	
				
			INSERT INTO Barsoom (
				Barsoom_Date
			)
			SELECT GETDATE()
			
			SELECT @Barsoom_Date_Cnt = (SELECT COUNT(*) FROM Barsoom)
			
			SET @Barsoom_Multiplier = 10 * @Barsoom_Date_Cnt
				IF @Barsoom_Multiplier >= 60
					BEGIN
						SET @Barsoom_Multiplier = 50
						SET @Barsoom_Multiplier2 = '1'
					END
			
			SET @Wait_Time = '0' + @Barsoom_Multiplier2 + ':' + CONVERT(VARCHAR(12),@Barsoom_Multiplier) + ':00'

			WAITFOR DELAY @Wait_Time
			
			RETURN

		END

	DELETE Barsoom
		
END

