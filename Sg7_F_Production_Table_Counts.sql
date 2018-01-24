/******************************************************************************
   NAME: Sg7_F_Production_Table_Counts.sql 
   DATE: 01/24/2018
   PURPOSE: Have a history of the counts on the production tables for ETL BI
   
******************************************************************************/

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








