/****************************************************

	Name: Synonym Template
	Date: 01/20/2018
	
	This template can be used to create a synonym for tables that are in the source system to the stage environment.

****************************************************/


USE [OneAccord_Warehouse]
GO

/****** Object:  Synonym [dbo].[AccountBase]    Script Date: 1/20/2018 1:04:23 PM ******/
CREATE SYNONYM [dbo].[AccountBase] FOR [MSSQL12316\S06].[OneAccord_MSCRM].[dbo].[AccountBase]
GO