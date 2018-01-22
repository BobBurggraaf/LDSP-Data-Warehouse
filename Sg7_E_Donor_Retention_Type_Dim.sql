/******************************************************************************
   NAME: Donor_Retention_Type_Dim 
   PURPOSE: DML for the _Donor_Retention_Type_Dim
   PLATFORM: Sql Server Management Studio

   REVISIONS:
   Ver        Date        Author           Description
   ---------  ----------  ---------------  ------------------------------------
   1.0        2/23/2017      Fams           1. Development of the initial script

   
******************************************************************************/


IF OBJECT_ID('_Donor_Retention_Type_Dim') IS NOT NULL
	DROP TABLE _Donor_Retention_Type_Dim
	
CREATE TABLE _Donor_Retention_Type_Dim (
	Donor_Retention_Type_Key INT PRIMARY KEY
	, Donor_Retention_Type_Code NVARCHAR(2)
	, Donor_Retention_Type_Description NVARCHAR(100)
	, Donor_Retention_Type_National_Average NUMERIC(10,4)
	, Donor_Retention_Type_Ldsp_Description NVARCHAR(200)
	, Donor_Retention_Type_Other_Description NVARCHAR(200)
)

INSERT INTO _Donor_Retention_Type_Dim (
	Donor_Retention_Type_Key
	, Donor_Retention_Type_Code
	, Donor_Retention_Type_Description
	, Donor_Retention_Type_National_Average
	, Donor_Retention_Type_Ldsp_Description
	, Donor_Retention_Type_Other_Description
)
VALUES
(10001,'A0',NULL,.49,'Reactivated','Reactivated'),
(10002,'A1',NULL,.31,'First-Time Donor','First-Time Donor'),
(10003,'A2',NULL,.60,'2 Years Consecutively','LY(2 Years Consecutively)'),
(10004,'A3',NULL,.67,'3 Years Consecutively','LY(3 Years Consecutively)'),
(10005,'A4',NULL,.72,'4 Years Consecutively','LY(4 Years Consecutively)'),
(10006,'A5',NULL,.84,'5 Years Consecutively','LY(5+ Years Consecutively)'),
(10007,'A6',NULL,.84,'6+ Years Consecutively','LY(5+ Years Consecutively)'),
(10008,'B0',NULL,NULL,'Reactivated Then Lapsed',NULL),
(10009,'B1',NULL,.31,'First-Time Donor Then Lapsed','SY(Lapsed, 1 Year)'),
(10010,'B2',NULL,.31,'2 Years Consecutively Then Lapsed','SY(Lapsed, 1 Year)'),
(10011,'B3',NULL,.31,'3 Years Consecutively Then Lapsed','SY(Lapsed, 1 Year)'),
(10012,'B4',NULL,.31,'4 Years Consecutively Then Lapsed','SY(Lapsed, 1 Year)'),
(10013,'B5',NULL,.31,'5 Years Consecutively Then Lapsed','SY(Lapsed, 1 Year)'),
(10014,'B6',NULL,.31,'6 Years Consecutively Then Lapsed','SY(Lapsed, 1 Year)'),
(10015,'C2',NULL,.17,'2 Years Lapsed','SY(Lapsed, 2 Year)'),
(10016,'C3',NULL,.11,'3 Years Lapsed','SY(Lapsed, 3 Year)'),
(10017,'C4',NULL,.08,'4 Years Lapsed','SY(Lapsed, 4 Year)'),
(10018,'C5',NULL,.03,'5 Years Lapsed','SY(Lapsed, 5 Year)'),
(10019,'C6',NULL,NULL,'6+ Years Lapsed',NULL),
(10020,'D1',NULL,.02,'Never Donated Before','Nondonors')