/*
	The following SQL code creates a date table that can be used for data analysis.
*/

DECLARE @StartDate DATE
SET @StartDate = '1900-01-01' -- This parameter sets the date with which the date table should begin.

DECLARE @EndDate DATE
SET @EndDate = '2099-12-31' -- This parameter sets the date with which the date table should end.

DECLARE @BeginFiscalYear DATE
SET @BeginFiscalYear = '1899-07-01' -- This parameter sets the beginning of the fiscal year. Note, that the year portion of the date is chosen arbitary.

DECLARE @EndFiscalYear DATE
SET @EndFiscalYear = '1900-06-30' -- This parameter stes the end of the fiscal year. Note, that the year portion of the date is chosen arbitary.

-- Creating a temporary table, which stores all dates begining from @StartDate till @EndDate, with additional column which counts the rows of the table.
DECLARE @tmp_DateTable TABLE(
	RowNumber INT,
	Date DATE
);

-- Loop, which inserts the date values into @tmp_DateTable.
DECLARE @DayCounter INT
SET @DayCounter = 0 -- Loop parameter that adds days to the start date until the end date is reached.

WHILE (@DayCounter <= DATEDIFF(DAY, @StartDate, @EndDate))
BEGIN
	INSERT INTO @tmp_DateTable
	VALUES (@DayCounter + 1, DATEADD(DAY, @DayCounter, @StartDate))
	SET @DayCounter = @DayCounter + 1
END;

-- Creating the schema for the date table.
CREATE TABLE DateTable (
	Date DATE PRIMARY KEY, 
	DateAsInteger INT NOT NULL,
	YearNumber INT NOT NULL,
	MonthAsNumber INT NOT NULL,
	MonthAsString CHAR(2) NOT NULL,
	DayAsNumber INT NOT NULL,
	DayAsString CHAR(2) NOT NULL,
	NameOfMonth VARCHAR(10) NOT NULL,
	MonthNumberAndNameOfMonth VARCHAR(14) NOT NULL,
	NameOfMonthShort VARCHAR(5) NOT NULL,
	MonthNumberAndNameOfMonthShort VARCHAR(9) NOT NULL,
	YearAndMonthNumber VARCHAR(7) NOT NULL,
	NameOfMonthAndYear VARCHAR(15) NOT NULL,
	NameOfMonthShortAndYear VARCHAR(10) NOT NULL,
	QuarterOfYear CHAR(2) NOT NULL,
	QuarterNumber INT NOT NULL,
	YearAndQuarterOfYear CHAR(7) NOT NULL,
	HalfYear CHAR(2) NOT NULL,
	YearAndHalfYear CHAR(7) NOT NULL,
	WeekDayName VARCHAR(10) NOT NULL,
	WeekDayNameShort CHAR(4) NOT NULL,
	WeekDayNumber INT NOT NULL,
	WeekOfYear INT NOT NULL,
	WeekOfYearName VARCHAR(7) NOT NULL,
	WeekOfYearNameShort VARCHAR(5) NOT NULL,
	YearAndWeekOfYearName VARCHAR(12) NOT NULL,
	MonthNameAndWeekOfYearName VARCHAR(18) NOT NULL,
	MonthNameShortAndWeekOfYearNameShort VARCHAR(13) NOT NULL,
	YearAndMonthNameAndWeekOfYearName VARCHAR(23) NOT NULL,
	YearAndMonthNameShortAndWeekOfYearNameShort VARCHAR(18) NOT NULL,
	DayYear INT NOT NULL,
	DayOfYearName VARCHAR(7) NOT NULL,
	YearAndDayOfYearName VARCHAR(12) NOT NULL,
	YearAndWeekOfYearNameAndDayOfYearName VARCHAR(20) NOT NULL,
	YearAndMonthNameAndWeekOfYearNameAndDayOfYearName VARCHAR(31) NOT NULL,
	YearAndMonthNameShortAndWeekOfYearNameShortAndDayOfYearName VARCHAR(26) NOT NULL,
	LeapYear BIT NOT NULL,
	CurrentYear BIT NOT NULL,
	CurrentHalfYear BIT NOT NULL,
	CurrentQuarter BIT NOT NULL,
	CurrentMonth BIT NOT NULL,
	CurrentWeek BIT NOT NULL,
	CurrentDate BIT NOT NULL,
	FiscalYear INT NOT NULL
);

INSERT INTO DateTable
SELECT 
	Date,
	CAST(TRIM(STR(YEAR(Date))) +  CASE WHEN LEN(TRIM(STR(MONTH(Date)))) = 1 THEN '0' + TRIM(STR(MONTH(Date))) ELSE TRIM(STR(MONTH(Date))) END + CASE WHEN LEN(TRIM(STR(DAY(Date)))) = 1 THEN '0' + TRIM(STR(DAY(Date))) ELSE TRIM(STR(DAY(Date))) END AS INT) AS DateAsInteger,
	YEAR(Date) AS YearNumber,
	Month(Date) AS MonthAsNumber,
	CASE WHEN LEN(TRIM(STR(MONTH(Date)))) = 1 THEN '0' + TRIM(STR(MONTH(Date))) ELSE TRIM(STR(MONTH(Date))) END AS MonthAsString,
	DAY(Date) AS DayAsNumber,
	CASE WHEN LEN(TRIM(STR(DAY(Date)))) = 1 THEN '0' + TRIM(STR(DAY(Date))) ELSE TRIM(STR(DAY(Date))) END AS DayAsString,
	CASE
		WHEN Month(Date) = 1 THEN 'January'
		WHEN Month(Date) = 2 THEN 'February'
		WHEN Month(Date) = 3 THEN 'March'
		WHEN Month(Date) = 4 THEN 'April' 
		WHEN Month(Date) = 5 THEN 'May'
		WHEN Month(Date) = 6 THEN 'June'
		WHEN Month(Date) = 7 THEN 'July'
		WHEN Month(Date) = 8 THEN 'August'
		WHEN Month(Date) = 9 THEN 'September'
		WHEN Month(Date) = 10 THEN 'October'
		WHEN Month(Date) = 11 THEN 'November'
		WHEN Month(Date) = 12 THEN 'December'
	END AS NameOfMonth,
	CASE
		WHEN Month(Date) = 1 THEN '0' + TRIM(STR(MONTH(Date))) + '-January'
		WHEN Month(Date) = 2 THEN '0' + TRIM(STR(MONTH(Date))) + '-February'
		WHEN Month(Date) = 3 THEN '0' + TRIM(STR(MONTH(Date))) + '-March'
		WHEN Month(Date) = 4 THEN '0' + TRIM(STR(MONTH(Date))) + '-April' 
		WHEN Month(Date) = 5 THEN '0' + TRIM(STR(MONTH(Date))) + '-May'
		WHEN Month(Date) = 6 THEN '0' + TRIM(STR(MONTH(Date))) + '-June'
		WHEN Month(Date) = 7 THEN '0' + TRIM(STR(MONTH(Date))) + '-July'
		WHEN Month(Date) = 8 THEN '0' + TRIM(STR(MONTH(Date))) + '-August'
		WHEN Month(Date) = 9 THEN '0' + TRIM(STR(MONTH(Date))) + '-September'
		WHEN Month(Date) = 10 THEN '0' + TRIM(STR(MONTH(Date))) + '-October'
		WHEN Month(Date) = 11 THEN '0' + TRIM(STR(MONTH(Date))) + '-November'
		WHEN Month(Date) = 12 THEN '0' + TRIM(STR(MONTH(Date))) + '-December'
	END AS MonthNumberAndNameOfMonth,
	CASE
		WHEN Month(Date) = 1 THEN 'Jan.'
		WHEN Month(Date) = 2 THEN 'Feb.'
		WHEN Month(Date) = 3 THEN 'Mar.'
		WHEN Month(Date) = 4 THEN 'Apr.' 
		WHEN Month(Date) = 5 THEN 'May'
		WHEN Month(Date) = 6 THEN 'June'
		WHEN Month(Date) = 7 THEN 'July'
		WHEN Month(Date) = 8 THEN 'Aug.'
		WHEN Month(Date) = 9 THEN 'Sept.'
		WHEN Month(Date) = 10 THEN 'Oct.'
		WHEN Month(Date) = 11 THEN 'Nov.'
		WHEN Month(Date) = 12 THEN 'Dec.'
	END AS NameOfMonthShort,
	CASE
		WHEN Month(Date) = 1 THEN '0' + TRIM(STR(MONTH(Date))) + '-Jan.'
		WHEN Month(Date) = 2 THEN '0' + TRIM(STR(MONTH(Date))) + '-Feb.'
		WHEN Month(Date) = 3 THEN '0' + TRIM(STR(MONTH(Date))) + '-Mar.'
		WHEN Month(Date) = 4 THEN '0' + TRIM(STR(MONTH(Date))) + '-Apr.' 
		WHEN Month(Date) = 5 THEN '0' + TRIM(STR(MONTH(Date))) + '-May'
		WHEN Month(Date) = 6 THEN '0' + TRIM(STR(MONTH(Date))) + '-June'
		WHEN Month(Date) = 7 THEN '0' + TRIM(STR(MONTH(Date))) + '-July'
		WHEN Month(Date) = 8 THEN '0' + TRIM(STR(MONTH(Date))) + '-Aug.'
		WHEN Month(Date) = 9 THEN '0' + TRIM(STR(MONTH(Date))) + '-Sept.'
		WHEN Month(Date) = 10 THEN '0' + TRIM(STR(MONTH(Date))) + '-Oct.'
		WHEN Month(Date) = 11 THEN '0' + TRIM(STR(MONTH(Date))) + '-Nov.'
		WHEN Month(Date) = 12 THEN '0' + TRIM(STR(MONTH(Date))) + '-Dec.'
	END AS MonthNumberAndNameOfMonthShort,
	TRIM(STR(YEAR(Date))) + '-' + CASE WHEN LEN(TRIM(STR(MONTH(Date)))) = 1 THEN '0' + TRIM(STR(MONTH(Date))) ELSE TRIM(STR(MONTH(Date))) END AS YearAndMonthNumber,
	CASE
		WHEN Month(Date) = 1 THEN 'January' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 2 THEN 'February' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 3 THEN 'March' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 4 THEN 'April' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 5 THEN 'May' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 6 THEN 'June' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 7 THEN 'July' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 8 THEN 'August' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 9 THEN 'September' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 10 THEN 'October' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 11 THEN 'November' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 12 THEN 'December' + ' ' + TRIM(STR(YEAR(Date)))
	END AS NameOfMonthAndYear,
	CASE
		WHEN Month(Date) = 1 THEN 'Jan.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 2 THEN 'Feb.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 3 THEN 'Mar.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 4 THEN 'Apr.' + ' ' + TRIM(STR(YEAR(Date))) 
		WHEN Month(Date) = 5 THEN 'May' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 6 THEN 'June' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 7 THEN 'July' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 8 THEN 'Aug.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 9 THEN 'Sept.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 10 THEN 'Oct.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 11 THEN 'Nov.' + ' ' + TRIM(STR(YEAR(Date)))
		WHEN Month(Date) = 12 THEN 'Dec.' + ' ' + TRIM(STR(YEAR(Date)))
	END AS NameOfMonthShortAndYear,
	CASE
		WHEN Month(Date) = 1 THEN 'Q1'
		WHEN Month(Date) = 2 THEN 'Q1'
		WHEN Month(Date) = 3 THEN 'Q1'
		WHEN Month(Date) = 4 THEN 'Q2' 
		WHEN Month(Date) = 5 THEN 'Q2'
		WHEN Month(Date) = 6 THEN 'Q2'
		WHEN Month(Date) = 7 THEN 'Q3'
		WHEN Month(Date) = 8 THEN 'Q3'
		WHEN Month(Date) = 9 THEN 'Q3'
		WHEN Month(Date) = 10 THEN 'Q4'
		WHEN Month(Date) = 11 THEN 'Q4'
		WHEN Month(Date) = 12 THEN 'Q4'
	END AS QuarterOfYear,
	CASE
		WHEN Month(Date) = 1 THEN 1
		WHEN Month(Date) = 2 THEN 1
		WHEN Month(Date) = 3 THEN 1
		WHEN Month(Date) = 4 THEN 2 
		WHEN Month(Date) = 5 THEN 2
		WHEN Month(Date) = 6 THEN 2
		WHEN Month(Date) = 7 THEN 3
		WHEN Month(Date) = 8 THEN 3
		WHEN Month(Date) = 9 THEN 3
		WHEN Month(Date) = 10 THEN 4
		WHEN Month(Date) = 11 THEN 4
		WHEN Month(Date) = 12 THEN 4
	END AS QuarterNumber,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q1'
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q1'
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q1'
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q2' 
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q2'
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q2'
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q3'
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q3'
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q3'
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q4'
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q4'
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + '/' + 'Q4'
	END AS YearAndQuarterOfYear,
	CASE
		WHEN Month(Date) = 1 THEN 'H1'
		WHEN Month(Date) = 2 THEN 'H1'
		WHEN Month(Date) = 3 THEN 'H1'
		WHEN Month(Date) = 4 THEN 'H1' 
		WHEN Month(Date) = 5 THEN 'H1'
		WHEN Month(Date) = 6 THEN 'H1'
		WHEN Month(Date) = 7 THEN 'H2'
		WHEN Month(Date) = 8 THEN 'H2'
		WHEN Month(Date) = 9 THEN 'H2'
		WHEN Month(Date) = 10 THEN 'H2'
		WHEN Month(Date) = 11 THEN 'H2'
		WHEN Month(Date) = 12 THEN 'H2'
	END AS HalfYear,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1'
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1'
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1'
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1' 
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1'
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + '/' + 'H1'
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + '/' + 'H2'
	END AS YearAndHalfYear,
	CASE
		WHEN RowNumber % 7 = 0 THEN 'Sunday'
		WHEN RowNumber % 7 = 1 THEN 'Monday'
		WHEN RowNumber % 7 = 2 THEN 'Tuesday'
		WHEN RowNumber % 7 = 3 THEN 'Wednesday'
		WHEN RowNumber % 7 = 4 THEN 'Thursday'
		WHEN RowNumber % 7 = 5 THEN 'Friday'
		WHEN RowNumber % 7 = 6 THEN 'Saturday'
	END AS WeekDayName,
	CASE
		WHEN RowNumber % 7 = 0 THEN 'Sun.'
		WHEN RowNumber % 7 = 1 THEN 'Mon.'
		WHEN RowNumber % 7 = 2 THEN 'Tue.'
		WHEN RowNumber % 7 = 3 THEN 'Wed.'
		WHEN RowNumber % 7 = 4 THEN 'Thu.'
		WHEN RowNumber % 7 = 5 THEN 'Fri.'
		WHEN RowNumber % 7 = 6 THEN 'Sat.'
	END AS WeekDayNameShort,
	CASE
		WHEN RowNumber % 7 = 0 THEN 7
		WHEN RowNumber % 7 = 1 THEN 1
		WHEN RowNumber % 7 = 2 THEN 2
		WHEN RowNumber % 7 = 3 THEN 3
		WHEN RowNumber % 7 = 4 THEN 4
		WHEN RowNumber % 7 = 5 THEN 5
		WHEN RowNumber % 7 = 6 THEN 6
	END AS WeekDayNumber,
	DATEPART(WEEK, Date) AS WeekOfYear,
	'Week ' + TRIM(STR(DATEPART(WEEK, Date))) AS WeekOfYearName,
	'Wk ' + TRIM(STR(DATEPART(WEEK, Date))) AS WeekOfYearNameShort,
	TRIM(STR(YEAR(Date))) + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) AS YearAndWeekOfYearName,
	CASE
		WHEN Month(Date) = 1 THEN 'January' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 2 THEN 'February' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 3 THEN 'March' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 4 THEN 'April' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 5 THEN 'May' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 6 THEN 'June' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 7 THEN 'July' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 8 THEN 'August' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 9 THEN 'September' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 10 THEN 'October' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 11 THEN 'November' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 12 THEN 'December' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
	END AS MonthNameAndWeekOfYearName,
	CASE
		WHEN Month(Date) = 1 THEN 'Jan.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 2 THEN 'Feb.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 3 THEN 'Mar.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 4 THEN 'Apr.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 5 THEN 'May' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 6 THEN 'June' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 7 THEN 'July' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 8 THEN 'Aug.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 9 THEN 'Sept.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 10 THEN 'Oct.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 11 THEN 'Nov.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 12 THEN 'Dec.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
	END AS MonthNameShortAndWeekOfYearNameShort,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + ' January' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + ' February' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + ' March' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + ' April' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + ' May' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + ' June' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + ' July' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + ' August' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + ' September' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + ' October' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + ' November' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + ' December' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date)))
	END AS YearAndMonthNameAndWeekOfYearName,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + ' Jan.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + ' Feb.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + ' Mar.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + ' Apr.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + ' May' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + ' June' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + ' July' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + ' Aug.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + ' Sept.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + ' Oct.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + ' Nov.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + ' Dec.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date)))
	END AS YearAndMonthNameShortAndWeekOfYearNameShort,
	DATEPART(DAYOFYEAR, DATE) AS DayYear,
	'Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE))) AS DayOfYearName,
	TRIM(STR(YEAR(Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE))) AS YearAndDayOfYearName,
	TRIM(STR(YEAR(Date))) + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE))) AS YearAndWeekOfYearNameAndDayOfYearName,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + ' January' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + ' February' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + ' March' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + ' April' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + ' May' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + ' June' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + ' July' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + ' August' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + ' September' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + ' October' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + ' November' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + ' December' + ' Week ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
	END AS YearAndMonthNameAndWeekOfYearNameAndDayOfYearName,
	CASE
		WHEN Month(Date) = 1 THEN TRIM(STR(YEAR(Date))) + ' Jan.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 2 THEN TRIM(STR(YEAR(Date))) + ' Feb.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 3 THEN TRIM(STR(YEAR(Date))) + ' Mar.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 4 THEN TRIM(STR(YEAR(Date))) + ' Apr.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 5 THEN TRIM(STR(YEAR(Date))) + ' May' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 6 THEN TRIM(STR(YEAR(Date))) + ' June' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 7 THEN TRIM(STR(YEAR(Date))) + ' July' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 8 THEN TRIM(STR(YEAR(Date))) + ' Aug.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 9 THEN TRIM(STR(YEAR(Date))) + ' Sept.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 10 THEN TRIM(STR(YEAR(Date))) + ' Oct.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 11 THEN TRIM(STR(YEAR(Date))) + ' Nov.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
		WHEN Month(Date) = 12 THEN TRIM(STR(YEAR(Date))) + ' Dec.' + ' Wk ' + TRIM(STR(DATEPART(WEEK, Date))) + ' Day ' + TRIM(STR(DATEPART(DAYOFYEAR, DATE)))
	END AS YearAndMonthNameShortAndWeekOfYearNameShortAndDayOfYearName,
	CASE
		WHEN YEAR(Date) IN (SELECT YEAR(Date) FROM @tmp_DateTable WHERE MONTH(Date) = 2 AND DAY(Date) = 29) THEN 1
		ELSE 0
	END AS LeapYear,
	CASE
		WHEN YEAR(Date) = YEAR(GETDATE()) THEN 1
		ELSE 0
	END AS CurrentYear,
	CASE
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 1 AND 6 AND MONTH(GETDATE()) BETWEEN 1 AND 6 THEN 1
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 7 AND 12 AND MONTH(GETDATE()) BETWEEN 7 AND 12 THEN 1
		ELSE 0
	END AS CurrentHalfYear,
	CASE
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 1 AND 3 AND MONTH(GETDATE()) BETWEEN 1 AND 3 THEN 1
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 4 AND 6 AND MONTH(GETDATE()) BETWEEN 4 AND 6 THEN 1
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 7 AND 9 AND MONTH(GETDATE()) BETWEEN 7 AND 9 THEN 1
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) BETWEEN 10 AND 12 AND MONTH(GETDATE()) BETWEEN 10 AND 12 THEN 1
		ELSE 0
	END AS CurrentQuarter,
	CASE
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) = MONTH(GETDATE()) THEN 1
		ELSE 0
	END AS CurrentMonth,
	CASE
		WHEN YEAR(Date) = YEAR(GETDATE()) AND MONTH(Date) = MONTH(GETDATE()) AND DATEPART(WEEK, Date) = DATEPART(WEEK, GETDATE()) THEN 1
		ELSE 0
	END AS CurrentWeek,
	CASE
		WHEN Date = CAST(GETDATE() AS DATE) THEN 1
		ELSE 0
	END AS CurrentDate,
	CASE
		WHEN MONTH(Date) BETWEEN MONTH(@BeginFiscalYear) AND 12 THEN YEAR(Date) + 1
		WHEN MONTH(Date) BETWEEN 1 AND MONTH(@EndFiscalYear) THEN YEAR(Date)
	END AS FiscalYear
FROM @tmp_DateTable