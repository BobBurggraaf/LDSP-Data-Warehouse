

-- --------------------------
-- Create Extract_Tables Table
-- --------------------------

DROP TABLE IF EXISTS Extract_Tables;

CREATE TABLE Extract_Tables (
	Extract_Tables_Key INT IDENTITY(10000,1) PRIMARY KEY
	, Extract_Table_Id INT
	, Extract_Table_Name NVARCHAR(100)
)

INSERT INTO Extract_Tables (
	Extract_Table_Id
	, Extract_Table_Name
)
VALUES
	(10001,'Ext_Account')
	, (10002,'Ext_Activity')
	, (10003,'Ext_Activity_Pointer')
	, (10004,'Ext_Address')
	, (10005,'Ext_Address_Format')
	, (10006,'Ext_Alumni')
	, (10007,'Ext_Appointment')
	, (10008,'Ext_Association')
	, (10009,'Ext_Association_Membership')
	, (10010,'Ext_Recognition_Association')
	, (10011,'Ext_Campaign')
	, (10012,'Ext_Campaign_Activity')
	, (10013,'Ext_College')
	, (10014,'Ext_City')
	, (10015,'Ext_Connection')
	, (10016,'Ext_Connection_Role')
	, (10017,'Ext_Contact')
	, (10018,'Ext_Country')
	, (10019,'Ext_County')
	, (10020,'Ext_Degree')
	, (10021,'Ext_Donor_Score')
	, (10022,'Ext_Drop_Include')
	, (10023,'Ext_Email')
	, (10024,'Ext_Employment')
	, (10025,'Ext_Envelope_Names_And_Salutations')
	, (10026,'Ext_Fund_Account')
	, (10027,'Ext_Gift')
	, (10028,'Ext_Industry')
	, (10029,'Ext_Institution')
	, (10030,'Ext_Interest')
	, (10031,'Ext_International_Experience')
	, (10032,'Ext_Job_Code')
	, (10033,'Ext_Language')
	, (10034,'Ext_Major')
	, (10035,'Ext_Opportunity')
	, (10036,'Ext_Other_Identifiers')
	, (10037,'Ext_Phone')
	, (10038,'Ext_Pledge')
	, (10039,'Ext_Postal')
	, (10040,'Ext_Professional_Suffix')
	, (10041,'Ext_Psa')
	, (10042,'Ext_Recognition')
	, (10043,'Ext_Recognition_Credit')
	, (10044,'Ext_Source')
	, (10045,'Ext_State')
	, (10046,'Ext_Student')
	, (10047,'Ext_Title')
	, (10048,'Ext_University')
	, (10049,'Ext_System_User')
	, (10050,'Ext_String_Map')
	, (10051,'Ext_Entity')
	, (10052,'Ext_Plus_LegacyM11Base')
	, (10053,'Ext_Date_Dim')
	, (10054,'Ext_Batch')
	, (10055,'Ext_Gift_Hist')
	, (10056,'Ext_Recurring_Gift_Rules')
	, (10057,'Ext_Campaign_Response')
	, (10058,'Ext_Payroll_Group')