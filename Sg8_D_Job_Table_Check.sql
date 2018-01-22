/****************************************************

	Name: Job_Ldsp_Table_Check
	Date: 01/20/2018
	
	These are the parameters for this job.

****************************************************/

	-- Step name: Ldsp_Table_Check
	-- Type: Transact-SQL script (T-SQL)
	-- Run as: [blank]
	-- Database: OneAccord_Warehouse
	-- Command: 
			DECLARE @Barsoom_Base BIGINT
			SET @Barsoom_Base = ((113 - 1373500)/-1)
			EXEC usp_Barsoom_usp @Barsoom_Cnt = @Barsoom_Base
	