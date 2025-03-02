--- MoonGlim Jewelry database developed and written by Mouyseang An 
IF NOT EXISTS(SELECT * FROM sys.databases
	WHERE NAME = N'MoonGlimJewelry')
	CREATE DATABASE MoonGlimJewelry 


GO
USE MoonGlimJewelry

DECLARE
	@data_path NVARCHAR(256);
SELECT @data_path = 'C:\Users\Mouyseang.An\Downloads\MoonGlims Project Part 3\MoonGlims Project Part 3\DM_ETL\MoonGlim OLTP\'; 

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'ORDER'
       )
	DROP TABLE [ORDER];

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'EMPLOYEE'
       )
	DROP TABLE EMPLOYEE;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'CUSTOMER'
       )
	DROP TABLE CUSTOMER;

IF EXISTS(
	SELECT *
	FROM sys.tables
	WHERE name = N'PRODUCT'
       )
	DROP TABLE PRODUCT;
---Create Tables

CREATE TABLE EMPLOYEE
	(Employee_ID			INT CONSTRAINT pk_employee PRIMARY KEY,
	Employee_FirstName			NVARCHAR(30) CONSTRAINT nn_employee_first_name NOT NULL,
	Employee_LastName			NVARCHAR(30) CONSTRAINT nn_employee_last_name NOT NULL,
	Employee_PhoneNumber		NVARCHAR(15) CONSTRAINT nn_employee_phone_number NOT NULL,
	Employee_TenureLength		NVARCHAR(20) CONSTRAINT nn_employee_tenure_length NOT NULL,
	Employee_Position			NVARCHAR(100) CONSTRAINT nn_employee_position NOT NULL,
	Employee_State				NVARCHAR(50) CONSTRAINT nn_employee_state NOT NULL,
	Employee_Region				NVARCHAR(50) CONSTRAINT nn_employee_region NOT NULL
	);



CREATE TABLE CUSTOMER
	(Customer_ID			INT CONSTRAINT pk_customer PRIMARY KEY,
	Customer_FirstName			NVARCHAR(30) CONSTRAINT nn_customer_first_name NOT NULL,
	Customer_LastName			NVARCHAR(30) CONSTRAINT nn_customer_last_name NOT NULL,
	Customer_Address            NVARCHAR(100) CONSTRAINT nn_customer_address NOT NULL,
	Customer_State				NVARCHAR(60) CONSTRAINT nn_customer_state NOT NULL,
	Customer_Zip				NVARCHAR(11) CONSTRAINT nn_customer_zip_ NOT NULL,
	Customer_City				NVARCHAR(30) CONSTRAINT nn_customer_city NOT NULL,
	Customer_Region				NVARCHAR(30) CONSTRAINT nn_customer_region NOT NULL
	);


CREATE TABLE PRODUCT
	(Product_ID				INT CONSTRAINT pk_product PRIMARY KEY,
	Product_Name				NVARCHAR(60) CONSTRAINT nn_product_name NOT NULL,
	Product_Type				NVARCHAR(20) CONSTRAINT nn_product_type NOT NULL,
	Product_MaterialType        NVARCHAR(40) CONSTRAINT nn_product_materialtype NOT NULL,
	Product_UnitCost			MONEY CONSTRAINT nn_product_unitcost NOT NULL,
	Product_UnitPrice			MONEY CONSTRAINT nn_product_unitprice NOT NULL
	);


CREATE TABLE [ORDER]
	(Order_ID		INT CONSTRAINT pk_Order PRIMARY KEY,
	Order_Date				DATE CONSTRAINT nn_order_date NOT NULL,
	Order_Time				TIME CONSTRAINT nn_order_time NOT NULL,
	Order_Quantity			INT NOT NULL,
	Product_ID				INT CONSTRAINT fk_order_product FOREIGN KEY REFERENCES PRODUCT(Product_ID),	
	Customer_ID				INT CONSTRAINT fk_order_customer FOREIGN KEY REFERENCES CUSTOMER(Customer_ID),
	Employee_ID				INT CONSTRAINT fk_order_employee FOREIGN KEY REFERENCES EMPLOYEE(Employee_ID)
	);


---Load the table

EXECUTE (N'BULK INSERT EMPLOYEE FROM ''' + @data_path + N'EMPLOYEE.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');


--
EXECUTE (N'BULK INSERT CUSTOMER FROM ''' + @data_path + N'CUSTOMER.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--
EXECUTE (N'BULK INSERT PRODUCT FROM ''' + @data_path + N'PRODUCT.csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');

--
EXECUTE (N'BULK INSERT [Order] FROM ''' + @data_path + N'[Order].csv''
WITH (
	CHECK_CONSTRAINTS,
	CODEPAGE=''ACP'',
	DATAFILETYPE = ''char'',
	FIELDTERMINATOR= '','',
	ROWTERMINATOR = ''\n'',
	KEEPIDENTITY,
	TABLOCK
	);
');
--

-- List table names and row counts for confirmation
--
SET NOCOUNT ON
SELECT 'CUSTOMER'AS "Table",	COUNT(*) AS "Rows"	FROM CUSTOMER				UNION
SELECT 'EMPLOYEE',				COUNT(*)			FROM EMPLOYEE				UNION
SELECT 'PRODUCT',				COUNT(*)			FROM PRODUCT				UNION
SELECT '[Order]',				COUNT(*)			FROM [Order]							
ORDER BY 1;
SET NOCOUNT OFF
GO
