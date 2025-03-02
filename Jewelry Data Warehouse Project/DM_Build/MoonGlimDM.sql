--- MoonGlim Jewelry database developed and written by Mouyseang An, Audrey Stuart, Roshan Cranford Luitel 
--- Publication date: October 2024


IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'MoonGlimJewelryDM')
	CREATE DATABASE MoonGlimJewelryDM 

GO
USE MoonGlimJewelryDM

-- Drop the existing tables. 
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'FactOrder'
       )
	DROP TABLE FactOrder;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimProduct'
       )
	DROP TABLE DimProduct;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimEmployee'
       )
	DROP TABLE DimEmployee;
--
IF EXISTS(

	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimCustomer'
       )
	DROP TABLE DimCustomer;
--
IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE NAME = N'DimDate'
       )
	DROP TABLE DimDate;


---Create Tables

CREATE TABLE DimDate (
	Date_SK				INT CONSTRAINT pk_date_key PRIMARY KEY, 
	Date				DATE,
	FullDate			NCHAR(10), -- Date in MM-DD-YYYY format
	DayOfMonth			INT, -- Day number of Month
	DayName				NVARCHAR(9), -- Monday, Tuesday, etc. 
	DayOfWeek			INT, -- First Day Sunday=1 and Saturday=7
	DayOfWeekInMonth	INT, -- 1st Monday or 2nd Monday in Month
	DayOfWeekInYear		INT,
	DayOfQuarter		INT,
	DayOfYear			INT,
	WeekOfMonth			INT,-- Week Number of Month 
	WeekOfQuarter		INT, -- Week Number of the Quarter
	WeekOfYear			INT,-- Week Number of the Year
	Month				INT, -- Number of the Month 1 to 12.
	MonthName			NVARCHAR(9), -- January, February etc.
	MonthOfQuarter		INT, -- Month Number belongs to Quarter
	Quarter				NCHAR(2),
	QuarterName			NCHAR(2), -- First,Second..
	Year				INT, -- Year value of Date stored in Row
	CYearName			NCHAR(7), -- CY 2017,CY 2018
	FYearName			NCHAR(7), -- CY 2017,CY 2018
	MonthYear			NCHAR(10), -- Jan-2018,Feb-2018
	MMYYYY				INT,
	FirstDayOfMonth		DATE,
	LastDayOfMonth		DATE,
	FirstDayOfQuarter	DATE,
	LastDayOfQuarter	DATE,
	FirstDayOfYear		DATE,
	LastDayOfYear		DATE,
	IsWeekday			BIT, -- 0=Weekend ,1=Weekday,
	IsWeekdayName		NVARCHAR(55), -- Weekend, Weekday
	IsHoliday			BIT, -- 1=National Holiday, 0-Not a National Holiday
	IsHolidayName		NVARCHAR(55), -- National Holiday or Not a National Holiday
	Holiday				NVARCHAR(55), --Name of Holiday in US
	Season				INT, --Number of season 1 (Fall to Summer)
	SeasonName			NVARCHAR(10)
);


CREATE TABLE DimEmployee( 
	Employee_SK					INT IDENTITY CONSTRAINT pk_employee_key PRIMARY KEY,
	Employee_BK					INT NOT NULL,
	Employee_LastName			NVARCHAR(100) NOT NULL,
	Employee_FirstName			NVARCHAR(100) NOT NULL,
	Employee_Region				NVARCHAR(100) NOT NULL,
	Employee_State				NVARCHAR(50) NOT NULL,
	Employee_TenureLength		NVARCHAR(20) NOT NULL,
	Employee_PhoneNumber		NVARCHAR(20) NOT NULL,
	Employee_Position			NVARCHAR(100) NOT NULL
	);


CREATE TABLE DimCustomer
	(Customer_SK				INT IDENTITY CONSTRAINT pk_customer_key PRIMARY KEY,
	Customer_BK					INT NOT NULL,
	Customer_LastName			NVARCHAR(30) NOT NULL,
	Customer_FirstName			NVARCHAR(30) NOT NULL,
	Customer_Address            NVARCHAR(100)NOT NULL,
	Customer_State				NVARCHAR(60) NOT NULL,
	Customer_Zip				NVARCHAR(15) NOT NULL,
	Customer_City				NVARCHAR(55) NOT NULL,
	Customer_Region				NVARCHAR(55) NOT NULL
	);


CREATE TABLE DimProduct
	(Product_SK					INT IDENTITY CONSTRAINT pk_product_key PRIMARY KEY,
	Product_BK					INT NOT NULL,
	Product_Name				NVARCHAR(60) NOT NULL,
	Product_Type				NVARCHAR(50) NOT NULL,
	Product_MaterialType		NVARCHAR(50) NOT NULL
	);

CREATE TABLE FactOrder
	(
	Order_ID				INT NOT NULL,
	Order_Date			INT CONSTRAINT fk_order_date_key FOREIGN KEY REFERENCES DimDate(Date_SK),
	Product_SK			INT CONSTRAINT fk_product_key FOREIGN KEY REFERENCES DimProduct(Product_SK), 
	Customer_SK			INT CONSTRAINT fk_customer_key FOREIGN KEY REFERENCES DimCustomer(Customer_SK),
	Employee_SK			INT CONSTRAINT fk_employee_key FOREIGN KEY REFERENCES DimEmployee(Employee_SK),
	UnitPrice			MONEY NOT NULL,
	UnitCost			MONEY NOT NULL,
	Quantity			INT NOT NULL,
	Revenue				MONEY NOT NULL,
	Cost				MONEY NOT NULL,
	Profit				MONEY NOT NULL,
	CONSTRAINT pk_fact_order_key PRIMARY KEY(Order_ID, Order_Date, Customer_SK, Employee_SK, Product_SK)
);
