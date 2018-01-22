/*******************************************************

	DECLARE @StartDate DATE = '20000101', @NumberOfYears INT = 30;

	SET DATEFIRST 7;
	SET DATEFORMAT mdy;
	SET LANGUAGE US_ENGLISH;

	DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);


	DROP TABLE IF EXISTS #dim
	CREATE TABLE #dim
	(
	  [date]       DATE PRIMARY KEY, 
	 -- [day]        AS DATEPART(DAY,      [date]),
	 -- [month]      AS DATEPART(MONTH,    [date]),
	 -- FirstOfMonth AS CONVERT(DATE, DATEADD(MONTH, DATEDIFF(MONTH, 0, [date]), 0)),
	 -- [MonthName]  AS DATENAME(MONTH,    [date]),
	  [week]       AS DATEPART(WEEK,     [date]),
	 -- [ISOweek]    AS DATEPART(ISO_WEEK, [date]),
	  [DayOfWeek]  AS DATEPART(WEEKDAY,  [date]),
	 -- [quarter]    AS DATEPART(QUARTER,  [date]),
	 -- [year]       AS DATEPART(YEAR,     [date]),
	 -- FirstOfYear  AS CONVERT(DATE, DATEADD(YEAR,  DATEDIFF(YEAR,  0, [date]), 0)),
	 -- Style112     AS CONVERT(CHAR(8),   [date], 112),
	 -- Style101     AS CONVERT(CHAR(10),  [date], 101)
	);


	INSERT #dim([date]) 
	SELECT d
	FROM
	(
	  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
	  FROM 
	  (
		SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
		  rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
		FROM sys.all_objects AS s1
		CROSS JOIN sys.all_objects AS s2
		-- on my system this would support > 5 million days
		ORDER BY s1.[object_id]
	  ) AS x
	) AS y;

	SELECT *
		FROM #dim

********************************************************/


-- --------------------------
-- Create _Accounting_Week Table
-- --------------------------

DROP TABLE IF EXISTS _Accounting_Week;

CREATE TABLE _Accounting_Week (
	Accounting_Week_Key INT IDENTITY(10000, 1)
	, Accounting_Week_Date DATE
	, Accounting_Week_Number INT
	, Accounting_Week_Day_Of_Week INT
	, Accounting_Week_Number_Date DATE -- Friday
	, Accounting_Week_Last_Week_Yn NVARCHAR(1) -- Number week prior to this week
	, Accounting_Week_Last_Week_Minus_1_Yn NVARCHAR(1) -- Number week prior to last week
	, Accounting_Week_Current_Week_Number_Last_Year_Yn NVARCHAR(1)
)


-- --------------------------
-- Insert Date, Week Number, and Week Day into _Accounting_Week Table
-- --------------------------

DECLARE @StartDate DATE = '20000101', @NumberOfYears INT = 30;

SET DATEFIRST 7;
SET DATEFORMAT mdy;
SET LANGUAGE US_ENGLISH;

DECLARE @CutoffDate DATE = DATEADD(YEAR, @NumberOfYears, @StartDate);

INSERT INTO _Accounting_Week (
	Accounting_Week_Date
	, Accounting_Week_Number
	, Accounting_Week_Day_Of_Week
)
SELECT d AS Accounting_Week_Date
	, DATEPART(WEEK, d) AS Accounting_Week_Number
	, DATEPART(WEEKDAY, d) AS Accounting_Week_Day_Of_Week
FROM
(
  SELECT d = DATEADD(DAY, rn - 1, @StartDate)
  FROM 
  (
    SELECT TOP (DATEDIFF(DAY, @StartDate, @CutoffDate)) 
      rn = ROW_NUMBER() OVER (ORDER BY s1.[object_id])
    FROM sys.all_objects AS s1
    CROSS JOIN sys.all_objects AS s2
    -- on my system this would support > 5 million days
    ORDER BY s1.[object_id]
  ) AS x
) AS y;


-- --------------------------
-- Insert Accounting_Week_Number_Date
-- --------------------------
MERGE INTO _Accounting_Week T
	USING (
		SELECT A.Accounting_Week_Key
			, B.Accounting_Week_Date
			FROM _Accounting_Week A
				LEFT JOIN
					(SELECT Accounting_Week_Number
						, Accounting_Week_Date
						, YEAR(Accounting_Week_Date) AS Accounting_Week_Year
						FROM _Accounting_Week
						WHERE 1 = 1
							AND Accounting_Week_Day_Of_Week = 6
					) B ON A.Accounting_Week_Number = B.Accounting_Week_Number
							AND YEAR(A.Accounting_Week_Date) = B.Accounting_Week_Year
		) S ON T.Accounting_Week_Key = S.Accounting_Week_Key
	WHEN MATCHED THEN 
		UPDATE
			SET T.Accounting_Week_Number_Date = S.Accounting_Week_Date
			;

-- --------------------------
-- Insert Accounting_Week_Last_Week_Yn
-- --------------------------
			
MERGE INTO _Accounting_Week T
	USING (
		SELECT *
			FROM _Accounting_Week
			WHERE 1 = 1
				AND Accounting_Week_Number_Date IN
					(SELECT Accounting_Week_Number_Date
						FROM _Accounting_Week
						WHERE 1 = 1
							AND Accounting_Week_Date = CONVERT(DATE,GETDATE() - 7,101)
					)
		) S ON T.Accounting_Week_Key = S.Accounting_Week_Key
	WHEN MATCHED THEN 
		UPDATE
			SET T.Accounting_Week_Last_Week_Yn = 'Y'
			;	

-- --------------------------
-- Insert Accounting_Week_Last_Week_Minus_1_Yn
-- --------------------------

MERGE INTO _Accounting_Week T
	USING (
		SELECT *
			FROM _Accounting_Week
			WHERE 1 = 1
				AND Accounting_Week_Number_Date IN
					(SELECT Accounting_Week_Number_Date
						FROM _Accounting_Week
						WHERE 1 = 1
							AND Accounting_Week_Date = CONVERT(DATE,GETDATE() - 14,101)
					)
		) S ON T.Accounting_Week_Key = S.Accounting_Week_Key
	WHEN MATCHED THEN 
		UPDATE
			SET T.Accounting_Week_Last_Week_Minus_1_Yn = 'Y'
			;				

-- --------------------------
-- Insert Accounting_Week_Current_Week_Number_Last_Year_Yn
-- --------------------------
			
MERGE INTO _Accounting_Week T
	USING (
		SELECT *
			FROM _Accounting_Week
			WHERE 1 = 1
				AND Accounting_Week_Number_Date IN
					(SELECT Accounting_Week_Number_Date
						FROM _Accounting_Week
						WHERE 1 = 1
							AND Accounting_Week_Date = CONVERT(DATE,GETDATE() - 365,101)
					)
		) S ON T.Accounting_Week_Key = S.Accounting_Week_Key
	WHEN MATCHED THEN 
		UPDATE
			SET T.Accounting_Week_Current_Week_Number_Last_Year_Yn = 'Y'
			;
			
			
			
			
			
			
			
			