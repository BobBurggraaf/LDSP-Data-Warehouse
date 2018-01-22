/****************************************************

	Name: usp_Insert_Alpha_3
	Date: 01/20/2018
	
	This stored procedure is use over and over again in the [Copy Tables to Prod].sql script
	It will insert data into the Alpha_Table_3 table
	
	**This is installed on the Production server.

****************************************************/



USE [OneAccord_Warehouse]
GO
/****** Object:  StoredProcedure [dbo].[usp_Insert_Alpha_3]    Script Date: 1/20/2018 3:04:20 PM ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO




ALTER PROCEDURE [dbo].[usp_Insert_Alpha_3]

	@Alpha_Stage NVARCHAR(50) = NULL
	, @Alpha_Step_Number NVARCHAR(10) = NULL
	, @Alpha_Step_Name NVARCHAR(200) = NULL
	, @Alpha_Begin_Time DATETIME = NULL
	, @Alpha_End_Time DATETIME = NULL
	, @Alpha_Duration_In_Seconds INT = NULL
	, @Alpha_Count INT = NULL
	, @Alpha_Query NVARCHAR(MAX) = NULL
	, @Alpha_Result BIT = 0
	, @ErrorNumber INT = NULL
	, @ErrorSeverity INT = NULL
	, @ErrorState INT = NULL
	, @ErrorProcedure NVARCHAR(500) = NULL
	, @ErrorLine INT = NULL
	, @ErrorMessage NVARCHAR(MAX) = NULL

AS

BEGIN

		SET NOCOUNT ON
		
		INSERT INTO OneAccord_Warehouse.dbo.Alpha_Table_3
			(Alpha_DateTime,Alpha_Stage,Alpha_Step_Number,Alpha_Step_Name,Alpha_Begin_Time,Alpha_End_Time,Alpha_Duration_In_Seconds,Alpha_Count,Alpha_Query,Alpha_Result,ErrorNumber,ErrorSeverity,ErrorState,ErrorProcedure,ErrorLine,ErrorMessage)
		VALUES(GETDATE(),@Alpha_Stage 
						, @Alpha_Step_Number
						, @Alpha_Step_Name
						, @Alpha_Begin_Time
						, @Alpha_End_Time
						, @Alpha_Duration_In_Seconds
						, @Alpha_Count
						, @Alpha_Query
						, @Alpha_Result
						, @ErrorNumber
						, @ErrorSeverity
						, @ErrorState
						, @ErrorProcedure
						, @ErrorLine
						, @ErrorMessage
				)

END



