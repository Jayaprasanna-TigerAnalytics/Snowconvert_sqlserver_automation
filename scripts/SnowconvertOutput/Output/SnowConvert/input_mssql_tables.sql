-- ******************************************************
-- Create tables
-- ******************************************************
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
PRINT '';

!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
PRINT '*** Creating Tables';

CREATE OR REPLACE TABLE dbo.AdventureWorksDWBuildVersion (
	DBVersion VARCHAR(50) NULL,
	VersionDate TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimAccount (
	AccountKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentAccountKey INT NULL,
	AccountCodeAlternateKey INT NULL,
	ParentAccountCodeAlternateKey INT NULL,
	AccountDescription VARCHAR(50) NULL,
	AccountType VARCHAR(50) NULL,
	Operator VARCHAR(50) NULL,
	CustomMembers VARCHAR(300) NULL,
	ValueType VARCHAR(50) NULL,
	CustomMemberOptions VARCHAR(200) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimCurrency (
	CurrencyKey INT IDENTITY(1,1) ORDER NOT NULL,
	CurrencyAlternateKey NCHAR(3) NOT NULL,
	CurrencyName VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimCustomer (
	CustomerKey INT IDENTITY(1,1) ORDER NOT NULL,
	GeographyKey INT NULL,
	CustomerAlternateKey VARCHAR(15) NOT NULL,
	Title VARCHAR(8) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	NameStyle BOOLEAN NULL,
	BirthDate DATE NULL,
	MaritalStatus NCHAR(1) NULL,
	Suffix VARCHAR(10) NULL,
	Gender VARCHAR(1) NULL,
	EmailAddress VARCHAR(50) NULL,
	YearlyIncome NUMBER(38, 4) NULL,
	TotalChildren TINYINT NULL,
	NumberChildrenAtHome TINYINT NULL,
	EnglishEducation VARCHAR(40) NULL,
	SpanishEducation VARCHAR(40) NULL,
	FrenchEducation VARCHAR(40) NULL,
	EnglishOccupation VARCHAR(100) NULL,
	SpanishOccupation VARCHAR(100) NULL,
	FrenchOccupation VARCHAR(100) NULL,
	HouseOwnerFlag NCHAR(1) NULL,
	NumberCarsOwned TINYINT NULL,
	AddressLine1 VARCHAR(120) NULL,
	AddressLine2 VARCHAR(120) NULL,
	Phone VARCHAR(20) NULL,
	DateFirstPurchase DATE NULL,
	CommuteDistance VARCHAR(15) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimDate (
	DateKey INT NOT NULL,
	FullDateAlternateKey DATE NOT NULL,
	DayNumberOfWeek TINYINT NOT NULL,
	EnglishDayNameOfWeek VARCHAR(10) NOT NULL,
	SpanishDayNameOfWeek VARCHAR(10) NOT NULL,
	FrenchDayNameOfWeek VARCHAR(10) NOT NULL,
	DayNumberOfMonth TINYINT NOT NULL,
	DayNumberOfYear SMALLINT NOT NULL,
	WeekNumberOfYear TINYINT NOT NULL,
	EnglishMonthName VARCHAR(10) NOT NULL,
	SpanishMonthName VARCHAR(10) NOT NULL,
	FrenchMonthName VARCHAR(10) NOT NULL,
	MonthNumberOfYear TINYINT NOT NULL,
	CalendarQuarter TINYINT NOT NULL,
	CalendarYear SMALLINT NOT NULL,
	CalendarSemester TINYINT NOT NULL,
	FiscalQuarter TINYINT NOT NULL,
	FiscalYear SMALLINT NOT NULL,
	FiscalSemester TINYINT NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimDepartmentGroup (
	DepartmentGroupKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentDepartmentGroupKey INT NULL,
	DepartmentGroupName VARCHAR(50) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimEmployee (
	EmployeeKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentEmployeeKey INT NULL,
	EmployeeNationalIDAlternateKey VARCHAR(15) NULL,
	ParentEmployeeNationalIDAlternateKey VARCHAR(15) NULL,
	SalesTerritoryKey INT NULL,
	FirstName VARCHAR(50) NOT NULL,
	LastName VARCHAR(50) NOT NULL,
	MiddleName VARCHAR(50) NULL,
	NameStyle BOOLEAN NOT NULL,
	Title VARCHAR(50) NULL,
	HireDate DATE NULL,
	BirthDate DATE NULL,
	LoginID VARCHAR(256) NULL,
	EmailAddress VARCHAR(50) NULL,
	Phone VARCHAR(25) NULL,
	MaritalStatus NCHAR(1) NULL,
	EmergencyContactName VARCHAR(50) NULL,
	EmergencyContactPhone VARCHAR(25) NULL,
	SalariedFlag BOOLEAN NULL,
	Gender NCHAR(1) NULL,
	PayFrequency TINYINT NULL,
	BaseRate NUMBER(38, 4) NULL,
	VacationHours SMALLINT NULL,
	SickLeaveHours SMALLINT NULL,
	CurrentFlag BOOLEAN NOT NULL,
	SalesPersonFlag BOOLEAN NOT NULL,
	DepartmentName VARCHAR(50) NULL,
	StartDate DATE NULL,
	EndDate DATE NULL,
	Status VARCHAR(50) NULL,
	EmployeePhoto VARBINARY NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimGeography (
	GeographyKey INT IDENTITY(1,1) ORDER NOT NULL,
	City VARCHAR(30) NULL,
	StateProvinceCode VARCHAR(3) NULL,
	StateProvinceName VARCHAR(50) NULL,
	CountryRegionCode VARCHAR(3) NULL,
	EnglishCountryRegionName VARCHAR(50) NULL,
	SpanishCountryRegionName VARCHAR(50) NULL,
	FrenchCountryRegionName VARCHAR(50) NULL,
	PostalCode VARCHAR(15) NULL,
	SalesTerritoryKey INT NULL,
	IpAddressLocator VARCHAR(15) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimOrganization (
	OrganizationKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentOrganizationKey INT NULL,
	PercentageOfOwnership VARCHAR(16) NULL,
	OrganizationName VARCHAR(50) NULL,
	CurrencyKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimProduct (
	ProductKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductAlternateKey VARCHAR(25) NULL,
	ProductSubcategoryKey INT NULL,
	WeightUnitMeasureCode NCHAR(3) NULL,
	SizeUnitMeasureCode NCHAR(3) NULL,
	EnglishProductName VARCHAR(50) NOT NULL,
	SpanishProductName VARCHAR(50) NOT NULL,
	FrenchProductName VARCHAR(50) NOT NULL,
	StandardCost NUMBER(38, 4) NULL,
	FinishedGoodsFlag BOOLEAN NOT NULL,
	Color VARCHAR(15) NOT NULL,
	SafetyStockLevel SMALLINT NULL,
	ReorderPoint SMALLINT NULL,
	ListPrice NUMBER(38, 4) NULL,
	Size VARCHAR(50) NULL,
	SizeRange VARCHAR(50) NULL,
	Weight FLOAT NULL,
	DaysToManufacture INT NULL,
	ProductLine NCHAR(2) NULL,
	DealerPrice NUMBER(38, 4) NULL,
	Class NCHAR(2) NULL,
	Style NCHAR(2) NULL,
	ModelName VARCHAR(50) NULL,
	LargePhoto VARBINARY NULL,
	EnglishDescription VARCHAR(400) NULL,
	FrenchDescription VARCHAR(400) NULL,
	ChineseDescription VARCHAR(400) NULL,
	ArabicDescription VARCHAR(400) NULL,
	HebrewDescription VARCHAR(400) NULL,
	ThaiDescription VARCHAR(400) NULL,
	GermanDescription VARCHAR(400) NULL,
	JapaneseDescription VARCHAR(400) NULL,
	TurkishDescription VARCHAR(400) NULL,
	StartDate TIMESTAMP_NTZ(3) NULL,
	EndDate TIMESTAMP_NTZ(3) NULL,
	Status VARCHAR(7) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimProductCategory (
	ProductCategoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductCategoryAlternateKey INT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	SpanishProductCategoryName VARCHAR(50) NOT NULL,
	FrenchProductCategoryName VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimProductSubcategory (
	ProductSubcategoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductSubcategoryAlternateKey INT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	SpanishProductSubcategoryName VARCHAR(50) NOT NULL,
	FrenchProductSubcategoryName VARCHAR(50) NOT NULL,
	ProductCategoryKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimPromotion (
	PromotionKey INT IDENTITY(1,1) ORDER NOT NULL,
	PromotionAlternateKey INT NULL,
	EnglishPromotionName VARCHAR(255) NULL,
	SpanishPromotionName VARCHAR(255) NULL,
	FrenchPromotionName VARCHAR(255) NULL,
	DiscountPct FLOAT NULL,
	EnglishPromotionType VARCHAR(50) NULL,
	SpanishPromotionType VARCHAR(50) NULL,
	FrenchPromotionType VARCHAR(50) NULL,
	EnglishPromotionCategory VARCHAR(50) NULL,
	SpanishPromotionCategory VARCHAR(50) NULL,
	FrenchPromotionCategory VARCHAR(50) NULL,
	StartDate TIMESTAMP_NTZ(3) NOT NULL,
	EndDate TIMESTAMP_NTZ(3) NULL,
	MinQty INT NULL,
	MaxQty INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimReseller (
	ResellerKey INT IDENTITY(1,1) ORDER NOT NULL,
	GeographyKey INT NULL,
	ResellerAlternateKey VARCHAR(15) NULL,
	Phone VARCHAR(25) NULL,
	BusinessType VARCHAR(20) NOT NULL,
	ResellerName VARCHAR(50) NOT NULL,
	NumberEmployees INT NULL,
	OrderFrequency CHAR(1) NULL,
	OrderMonth TINYINT NULL,
	FirstOrderYear INT NULL,
	LastOrderYear INT NULL,
	ProductLine VARCHAR(50) NULL,
	AddressLine1 VARCHAR(60) NULL,
	AddressLine2 VARCHAR(60) NULL,
	AnnualSales NUMBER(38, 4) NULL,
	BankName VARCHAR(50) NULL,
	MinPaymentType TINYINT NULL,
	MinPaymentAmount NUMBER(38, 4) NULL,
	AnnualRevenue NUMBER(38, 4) NULL,
	YearOpened INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimSalesReason (
	SalesReasonKey INT IDENTITY(1,1) ORDER NOT NULL,
	SalesReasonAlternateKey INT NOT NULL,
	SalesReasonName VARCHAR(50) NOT NULL,
	SalesReasonReasonType VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimSalesTerritory (
	SalesTerritoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	SalesTerritoryAlternateKey INT NULL,
	SalesTerritoryRegion VARCHAR(50) NOT NULL,
	SalesTerritoryCountry VARCHAR(50) NOT NULL,
	SalesTerritoryGroup VARCHAR(50) NULL,
	SalesTerritoryImage VARBINARY NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.DimScenario (
	ScenarioKey INT IDENTITY(1,1) ORDER NOT NULL,
	ScenarioName VARCHAR(50) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactAdditionalInternationalProductDescription (
	ProductKey INT NOT NULL,
	CultureName VARCHAR(50) NOT NULL,
	ProductDescription VARCHAR NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactCallCenter (
	FactCallCenterID INT IDENTITY(1,1) ORDER NOT NULL,
	DateKey INT NOT NULL,
	WageType VARCHAR(15) NOT NULL,
	Shift VARCHAR(20) NOT NULL,
	LevelOneOperators SMALLINT NOT NULL,
	LevelTwoOperators SMALLINT NOT NULL,
	TotalOperators SMALLINT NOT NULL,
	Calls INT NOT NULL,
	AutomaticResponses INT NOT NULL,
	Orders INT NOT NULL,
	IssuesRaised SMALLINT NOT NULL,
	AverageTimePerIssue SMALLINT NOT NULL,
	ServiceGrade FLOAT NOT NULL,
	Date TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactCurrencyRate (
	CurrencyKey INT NOT NULL,
	DateKey INT NOT NULL,
	AverageRate FLOAT NOT NULL,
	EndOfDayRate FLOAT NOT NULL,
	Date TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactFinance (
	FinanceKey INT IDENTITY(1,1) ORDER NOT NULL,
	DateKey INT NOT NULL,
	OrganizationKey INT NOT NULL,
	DepartmentGroupKey INT NOT NULL,
	ScenarioKey INT NOT NULL,
	AccountKey INT NOT NULL,
	Amount FLOAT NOT NULL,
	Date TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactInternetSales (
	ProductKey INT NOT NULL,
	OrderDateKey INT NOT NULL,
	DueDateKey INT NOT NULL,
	ShipDateKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	PromotionKey INT NOT NULL,
	CurrencyKey INT NOT NULL,
	SalesTerritoryKey INT NOT NULL,
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	RevisionNumber TINYINT NOT NULL,
	OrderQuantity SMALLINT NOT NULL,
	UnitPrice NUMBER(38, 4) NOT NULL,
	ExtendedAmount NUMBER(38, 4) NOT NULL,
	UnitPriceDiscountPct FLOAT NOT NULL,
	DiscountAmount FLOAT NOT NULL,
	ProductStandardCost NUMBER(38, 4) NOT NULL,
	TotalProductCost NUMBER(38, 4) NOT NULL,
	SalesAmount NUMBER(38, 4) NOT NULL,
	TaxAmt NUMBER(38, 4) NOT NULL,
	Freight NUMBER(38, 4) NOT NULL,
	CarrierTrackingNumber VARCHAR(25) NULL,
	CustomerPONumber VARCHAR(25) NULL,
	OrderDate TIMESTAMP_NTZ(3) NULL,
	DueDate TIMESTAMP_NTZ(3) NULL,
	ShipDate TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactInternetSalesReason (
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	SalesReasonKey INT NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactProductInventory (
	ProductKey INT NOT NULL,
	DateKey INT NOT NULL,
	MovementDate DATE NOT NULL,
	UnitCost NUMBER(38, 4) NOT NULL,
	UnitsIn INT NOT NULL,
	UnitsOut INT NOT NULL,
	UnitsBalance INT NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactResellerSales (
	ProductKey INT NOT NULL,
	OrderDateKey INT NOT NULL,
	DueDateKey INT NOT NULL,
	ShipDateKey INT NOT NULL,
	ResellerKey INT NOT NULL,
	EmployeeKey INT NOT NULL,
	PromotionKey INT NOT NULL,
	CurrencyKey INT NOT NULL,
	SalesTerritoryKey INT NOT NULL,
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	RevisionNumber TINYINT NULL,
	OrderQuantity SMALLINT NULL,
	UnitPrice NUMBER(38, 4) NULL,
	ExtendedAmount NUMBER(38, 4) NULL,
	UnitPriceDiscountPct FLOAT NULL,
	DiscountAmount FLOAT NULL,
	ProductStandardCost NUMBER(38, 4) NULL,
	TotalProductCost NUMBER(38, 4) NULL,
	SalesAmount NUMBER(38, 4) NULL,
	TaxAmt NUMBER(38, 4) NULL,
	Freight NUMBER(38, 4) NULL,
	CarrierTrackingNumber VARCHAR(25) NULL,
	CustomerPONumber VARCHAR(25) NULL,
	OrderDate TIMESTAMP_NTZ(3) NULL,
	DueDate TIMESTAMP_NTZ(3) NULL,
	ShipDate TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactSalesQuota (
	SalesQuotaKey INT IDENTITY(1,1) ORDER NOT NULL,
	EmployeeKey INT NOT NULL,
	DateKey INT NOT NULL,
	CalendarYear SMALLINT NOT NULL,
	CalendarQuarter TINYINT NOT NULL,
	SalesAmountQuota NUMBER(38, 4) NOT NULL,
	Date TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.FactSurveyResponse (
	SurveyResponseKey INT IDENTITY(1,1) ORDER NOT NULL,
	DateKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	ProductCategoryKey INT NOT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	ProductSubcategoryKey INT NOT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	Date TIMESTAMP_NTZ(3) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.NewFactCurrencyRate (
	AverageRate REAL NULL,
	CurrencyID VARCHAR(3) NULL,
	CurrencyDate DATE NULL,
	EndOfDayRate REAL NULL,
	CurrencyKey INT NULL,
	DateKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.ProspectiveBuyer (
	ProspectiveBuyerKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProspectAlternateKey VARCHAR(15) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	BirthDate TIMESTAMP_NTZ(3) NULL,
	MaritalStatus NCHAR(1) NULL,
	Gender VARCHAR(1) NULL,
	EmailAddress VARCHAR(50) NULL,
	YearlyIncome NUMBER(38, 4) NULL,
	TotalChildren TINYINT NULL,
	NumberChildrenAtHome TINYINT NULL,
	Education VARCHAR(40) NULL,
	Occupation VARCHAR(100) NULL,
	HouseOwnerFlag NCHAR(1) NULL,
	NumberCarsOwned TINYINT NULL,
	AddressLine1 VARCHAR(120) NULL,
	AddressLine2 VARCHAR(120) NULL,
	City VARCHAR(30) NULL,
	StateProvinceCode VARCHAR(3) NULL,
	PostalCode VARCHAR(15) NULL,
	Phone VARCHAR(20) NULL,
	Salutation VARCHAR(8) NULL,
	Unknown INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.sysdiagrams (
	name VARCHAR(128) NOT NULL,
	principal_id INT NOT NULL,
	diagram_id INT IDENTITY(1,1) ORDER NOT NULL,
	version INT NULL,
	definition VARBINARY NULL
	)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!

SET ANSI_PADDING ON;

CALL SP_ADDEXTENDEDPROPERTY_UDP('microsoft_database_tools_support', 1, 'SCHEMA', 'dbo', 'TABLE', 'sysdiagrams');

-- Suppliers Table
CREATE OR REPLACE TABLE Suppliers (
	SupplierID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	SupplierName VARCHAR(255) NOT NULL,
	ContactName VARCHAR(255),
	Phone VARCHAR(50),
	Email VARCHAR(255),
	Address VARCHAR(500),
	City VARCHAR(100),
	Country VARCHAR(100),
	CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Products Table
CREATE OR REPLACE TABLE Products (
	ProductID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	ProductName VARCHAR(255) NOT NULL,
	SupplierID INT FOREIGN KEY REFERENCES Suppliers (SupplierID),
	Category VARCHAR(100),
	Price DECIMAL(10,2) NOT NULL,
	UnitOfMeasure VARCHAR(50),
	CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Warehouses Table
CREATE OR REPLACE TABLE Warehouses (
	WarehouseID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	WarehouseName VARCHAR(255) NOT NULL,
	Location VARCHAR(255),
	Capacity INT NOT NULL,
	Manager VARCHAR(255),
	CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Inventory Table
CREATE OR REPLACE TABLE Inventory (
	InventoryID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
	WarehouseID INT FOREIGN KEY REFERENCES Warehouses (WarehouseID),
	Quantity INT NOT NULL,
	LastUpdated TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Customers Table
CREATE OR REPLACE TABLE Customers (
	CustomerID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	CustomerName VARCHAR(255) NOT NULL,
	ContactName VARCHAR(255),
	Phone VARCHAR(50),
	Email VARCHAR(255),
	Address VARCHAR(500),
	City VARCHAR(100),
	Country VARCHAR(100),
	CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Orders Table
CREATE OR REPLACE TABLE Orders (
	OrderID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	CustomerID INT FOREIGN KEY REFERENCES Customers (CustomerID),
	OrderDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3),
	Status VARCHAR(50)
 	                  !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
	TotalAmount DECIMAL(18,2) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- OrderDetails Table
CREATE OR REPLACE TABLE OrderDetails (
	OrderDetailID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
	ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
	Quantity INT NOT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL,
	TotalPrice VARIANT AS (Quantity * UnitPrice) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Shipments Table
CREATE OR REPLACE TABLE Shipments (
	ShipmentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
	ShipmentDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3),
	Carrier VARCHAR(255),
	TrackingNumber VARCHAR(50),
	Status VARCHAR(50)
 	                  !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('In Transit', 'Delivered', 'Delayed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Returns Table
CREATE OR REPLACE TABLE Returns (
	ReturnID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
	ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
	Quantity INT NOT NULL,
	ReturnReason VARCHAR(255),
	ReturnDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3),
	Status VARCHAR(50)
 	                  !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- Payments Table
CREATE OR REPLACE TABLE Payments (
	PaymentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
	PaymentDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP(3),
	PaymentMethod VARCHAR(50)
 	                         !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
	AmountPaid DECIMAL(18,2) NOT NULL,
	Status VARCHAR(50)
 	                  !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Completed', 'Pending', 'Failed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

-- ******************************************************
-- Create tables
-- ******************************************************
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
PRINT '';

!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
PRINT '*** Creating Tables';

CREATE OR REPLACE TABLE Person.Address (
	AddressID INT IDENTITY(1, 1) ORDER NOT NULL,
	AddressLine1 VARCHAR(60) NOT NULL,
	AddressLine2 VARCHAR(60) NULL,
	City VARCHAR(30) NOT NULL,
	StateProvinceID INT NOT NULL,
	PostalCode VARCHAR(15) NOT NULL,
	SpatialLocation GEOGRAPHY NULL,
	rowguid VARCHAR
 	               !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
 	               ROWGUIDCOL NOT NULL
  	                                  --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
  	                                  DEFAULT (UUID_STRING()),
	ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
 	                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                      DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.AddressType (
	AddressTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
	Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
	rowguid VARCHAR
 	               !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
 	               ROWGUIDCOL NOT NULL
  	                                  --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
  	                                  DEFAULT (UUID_STRING()),
	ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
 	                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                      DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE dbo.AWBuildVersion (
	SystemInformationID TINYINT IDENTITY(1, 1) ORDER NOT NULL,
	"Database Version" VARCHAR(25) NOT NULL,
	VersionDate TIMESTAMP_NTZ(3) NOT NULL,
	ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
 	                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                      DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.BillOfMaterials (
	BillOfMaterialsID INT IDENTITY(1, 1) ORDER NOT NULL,
	ProductAssemblyID INT NULL,
	ComponentID INT NOT NULL,
	StartDate TIMESTAMP_NTZ(3) NOT NULL
 	                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                   DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
	EndDate TIMESTAMP_NTZ(3) NULL,
	UnitMeasureCode NCHAR(3) NOT NULL,
	BOMLevel SMALLINT NOT NULL,
	PerAssemblyQty DECIMAL(8, 2) NOT NULL
 	                                     --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                     DEFAULT (1.00),
	ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
 	                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
 	                                      DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_BillOfMaterials_EndDate CHECK (([EndDate] > [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_BillOfMaterials_ProductAssemblyID CHECK ([ProductAssemblyID] <> [ComponentID]) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_BillOfMaterials_BOMLevel CHECK ((([ProductAssemblyID] IS NULL)
        AND ([BOMLevel] = 0) AND ([PerAssemblyQty] = 1.00))
        OR (([ProductAssemblyID] IS NOT NULL) AND ([BOMLevel] >= 1))) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_BillOfMaterials_PerAssemblyQty CHECK ([PerAssemblyQty] >= 1.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.BusinessEntity (
    BusinessEntityID INT IDENTITY(1, 1) ORDER NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.BusinessEntityAddress (
    BusinessEntityID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressTypeID INT NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.BusinessEntityContact (
    BusinessEntityID INT NOT NULL,
    PersonID INT NOT NULL,
    ContactTypeID INT NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.ContactType (
    ContactTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.CountryRegionCurrency (
    CountryRegionCode VARCHAR(3) NOT NULL,
    CurrencyCode NCHAR(3) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.CountryRegion (
    CountryRegionCode VARCHAR(3) NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.CreditCard (
    CreditCardID INT IDENTITY(1, 1) ORDER NOT NULL,
    CardType VARCHAR(50) NOT NULL,
    CardNumber VARCHAR(25) NOT NULL,
    ExpMonth TINYINT NOT NULL,
    ExpYear SMALLINT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.Culture (
    CultureID NCHAR(6) NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.Currency (
    CurrencyCode NCHAR(3) NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.CurrencyRate (
    CurrencyRateID INT IDENTITY(1, 1) ORDER NOT NULL,
    CurrencyRateDate TIMESTAMP_NTZ(3) NOT NULL,
    FromCurrencyCode NCHAR(3) NOT NULL,
    ToCurrencyCode NCHAR(3) NOT NULL,
    AverageRate NUMBER(38, 4) NOT NULL,
    EndOfDayRate NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[dbo].[ufnLeadingZeros]" **
CREATE OR REPLACE TABLE Sales.Customer (
    CustomerID INT IDENTITY(1, 1) ORDER NOT NULL,
    -- A customer may either be a person, a store, or a person who works for a store
    PersonID INT NULL, -- If this customer represents a person, this is non-null

    StoreID INT NULL,  -- If the customer is a store, or is associated with a store then this is non-null.

    TerritoryID INT NULL,
    AccountNumber VARIANT AS NVL('AW' +
    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ufnLeadingZeros' NODE ***/!!!
    dbo.ufnLeadingZeros(CustomerID), 0) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE HumanResources.Department (
    DepartmentID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    GroupName VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.Document (
    DocumentNode VARIANT /*** SSC-FDM-TS0015 - DATA TYPE HIERARCHYID IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    DocumentLevel VARIANT AS
    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetLevel' NODE ***/!!!
    DocumentNode.GetLevel() /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    Title VARCHAR(50) NOT NULL,
    Owner INT NOT NULL,
    FolderFlag BOOLEAN NOT NULL
                                --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                DEFAULT (0),
    FileName VARCHAR(400) NOT NULL,
    FileExtension VARCHAR(8) NOT NULL,
    Revision NCHAR(5) NOT NULL,
    ChangeNumber INT NOT NULL
                              --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                              DEFAULT (0),
    Status TINYINT NOT NULL,
    DocumentSummary VARCHAR NULL,
    Document VARBINARY NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL UNIQUE
                                               --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                               DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Document_Status CHECK ([Status] BETWEEN 1 AND 3) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.EmailAddress (
    BusinessEntityID INT NOT NULL,
    EmailAddressID INT IDENTITY(1, 1) ORDER NOT NULL,
    EmailAddress VARCHAR(50) NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Flag]" **
CREATE OR REPLACE TABLE HumanResources.Employee (
    BusinessEntityID INT NOT NULL,
    NationalIDNumber VARCHAR(15) NOT NULL,
    LoginID VARCHAR(256) NOT NULL,
    OrganizationNode VARIANT /*** SSC-FDM-TS0015 - DATA TYPE HIERARCHYID IS NOT SUPPORTED IN SNOWFLAKE ***/ NULL,
    OrganizationLevel VARIANT AS
    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetLevel' NODE ***/!!!
    OrganizationNode.GetLevel() /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    JobTitle VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    MaritalStatus NCHAR(1) NOT NULL,
    Gender NCHAR(1) NOT NULL,
    HireDate DATE NOT NULL,
    SalariedFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                          --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                          DEFAULT (1),
    VacationHours SMALLINT NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0),
    SickLeaveHours SMALLINT NOT NULL
                                     --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                     DEFAULT (0),
    CurrentFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                         --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                         DEFAULT (1),
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Employee_BirthDate CHECK ([BirthDate] BETWEEN '1930-01-01' AND DATEADD(YEAR, -18, GETDATE())) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Employee_MaritalStatus CHECK (UPPER([MaritalStatus]) IN ('M', 'S')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!, -- Married or Single
    CONSTRAINT CK_Employee_HireDate CHECK ([HireDate] BETWEEN '1996-07-01' AND DATEADD(DAY, 1, GETDATE())) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Employee_Gender CHECK (UPPER([Gender]) IN ('M', 'F')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!, -- Male or Female
    CONSTRAINT CK_Employee_VacationHours CHECK ([VacationHours] BETWEEN -40 AND 240) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Employee_SickLeaveHours CHECK ([SickLeaveHours] BETWEEN 0 AND 120) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE HumanResources.EmployeeDepartmentHistory (
    BusinessEntityID INT NOT NULL,
    DepartmentID SMALLINT NOT NULL,
    ShiftID TINYINT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_EmployeeDepartmentHistory_EndDate CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE HumanResources.EmployeePayHistory (
    BusinessEntityID INT NOT NULL,
    RateChangeDate TIMESTAMP_NTZ(3) NOT NULL,
    Rate NUMBER(38, 4) NOT NULL,
    PayFrequency TINYINT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_EmployeePayHistory_PayFrequency CHECK ([PayFrequency] IN (1, 2)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!, -- 1 = monthly salary, 2 = biweekly salary
    CONSTRAINT CK_EmployeePayHistory_Rate CHECK ([Rate] BETWEEN 6.50 AND 200.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.Illustration (
    IllustrationID INT IDENTITY(1, 1) ORDER NOT NULL,
    Diagram VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE HumanResources.JobCandidate (
    JobCandidateID INT IDENTITY(1, 1) ORDER NOT NULL,
    BusinessEntityID INT NULL,
    Resume VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.Location (
    LocationID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    CostRate NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    Availability DECIMAL(8, 2) NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (0.00),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Location_CostRate CHECK ([CostRate] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Location_Availability CHECK ([Availability] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.Password (
    BusinessEntityID INT NOT NULL,
    PasswordHash VARCHAR(128) NOT NULL,
    PasswordSalt VARCHAR(10) NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)

)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Name]" **
CREATE OR REPLACE TABLE Person.Person (
    BusinessEntityID INT NOT NULL,
    PersonType NCHAR(2) NOT NULL,
    NameStyle VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAMESTYLE IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                            --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                            DEFAULT (0),
    Title VARCHAR(8) NULL,
    FirstName VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    MiddleName VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NULL,
    LastName VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    Suffix VARCHAR(10) NULL,
    EmailPromotion INT NOT NULL
                                --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                DEFAULT (0),
    AdditionalContactInfo VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    Demographics VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Person_EmailPromotion CHECK ([EmailPromotion] BETWEEN 0 AND 2) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Person_PersonType CHECK ([PersonType] IS NULL OR UPPER([PersonType]) IN ('SC', 'VC', 'IN', 'EM', 'SP', 'GC')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.PersonCreditCard (
    BusinessEntityID INT NOT NULL,
    CreditCardID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Phone]" **
CREATE OR REPLACE TABLE Person.PersonPhone (
    BusinessEntityID INT NOT NULL,
    PhoneNumber VARIANT /*** SSC-FDM-TS0015 - DATA TYPE PHONE IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    PhoneNumberTypeID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Person.PhoneNumberType (
    PhoneNumberTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Flag]" **
CREATE OR REPLACE TABLE Production.Product (
    ProductID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    MakeFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                      DEFAULT (1),
    FinishedGoodsFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                               --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                               DEFAULT (1),
    Color VARCHAR(15) NULL,
    SafetyStockLevel SMALLINT NOT NULL,
    ReorderPoint SMALLINT NOT NULL,
    StandardCost NUMBER(38, 4) NOT NULL,
    ListPrice NUMBER(38, 4) NOT NULL,
    Size VARCHAR(5) NULL,
    SizeUnitMeasureCode NCHAR(3) NULL,
    WeightUnitMeasureCode NCHAR(3) NULL,
    Weight DECIMAL(8, 2) NULL,
    DaysToManufacture INT NOT NULL,
    ProductLine NCHAR(2) NULL,
    Class NCHAR(2) NULL,
    Style NCHAR(2) NULL,
    ProductSubcategoryID INT NULL,
    ProductModelID INT NULL,
    SellStartDate TIMESTAMP_NTZ(3) NOT NULL,
    SellEndDate TIMESTAMP_NTZ(3) NULL,
    DiscontinuedDate TIMESTAMP_NTZ(3) NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Product_SafetyStockLevel CHECK ([SafetyStockLevel] > 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_ReorderPoint CHECK ([ReorderPoint] > 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_StandardCost CHECK ([StandardCost] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_ListPrice CHECK ([ListPrice] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_Weight CHECK ([Weight] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_DaysToManufacture CHECK ([DaysToManufacture] >= 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_ProductLine CHECK (UPPER([ProductLine]) IN ('S', 'T', 'M', 'R') OR [ProductLine] IS NULL) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_Class CHECK (UPPER([Class]) IN ('L', 'M', 'H') OR [Class] IS NULL) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_Style CHECK (UPPER([Style]) IN ('W', 'M', 'U') OR [Style] IS NULL) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_Product_SellEndDate CHECK (([SellEndDate] >= [SellStartDate]) OR ([SellEndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductCategory (
    ProductCategoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductCostHistory (
    ProductID INT NOT NULL,
    StartDate TIMESTAMP_NTZ(3) NOT NULL,
    EndDate TIMESTAMP_NTZ(3) NULL,
    StandardCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ProductCostHistory_EndDate CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductCostHistory_StandardCost CHECK ([StandardCost] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductDescription (
    ProductDescriptionID INT IDENTITY(1, 1) ORDER NOT NULL,
    Description VARCHAR(400) NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductDocument (
    ProductID INT NOT NULL,
    DocumentNode VARIANT /*** SSC-FDM-TS0015 - DATA TYPE HIERARCHYID IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductInventory (
    ProductID INT NOT NULL,
    LocationID SMALLINT NOT NULL,
    Shelf VARCHAR(10) NOT NULL,
    Bin TINYINT NOT NULL,
    Quantity SMALLINT NOT NULL
                               --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                               DEFAULT (0),
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ProductInventory_Shelf CHECK (([Shelf] LIKE '[A-Za-z]') OR ([Shelf] = 'N/A')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductInventory_Bin CHECK ([Bin] BETWEEN 0 AND 100) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductListPriceHistory (
    ProductID INT NOT NULL,
    StartDate TIMESTAMP_NTZ(3) NOT NULL,
    EndDate TIMESTAMP_NTZ(3) NULL,
    ListPrice NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ProductListPriceHistory_EndDate CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductListPriceHistory_ListPrice CHECK ([ListPrice] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductModel (
    ProductModelID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    CatalogDescription VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    Instructions VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductModelIllustration (
    ProductModelID INT NOT NULL,
    IllustrationID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductModelProductDescriptionCulture (
    ProductModelID INT NOT NULL,
    ProductDescriptionID INT NOT NULL,
    CultureID NCHAR(6) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductPhoto (
    ProductPhotoID INT IDENTITY(1, 1) ORDER NOT NULL,
    ThumbNailPhoto VARBINARY NULL,
    ThumbnailPhotoFileName VARCHAR(50) NULL,
    LargePhoto VARBINARY NULL,
    LargePhotoFileName VARCHAR(50) NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Flag]" **
CREATE OR REPLACE TABLE Production.ProductProductPhoto (
    ProductID INT NOT NULL,
    ProductPhotoID INT NOT NULL,
    Primary VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                     --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                     DEFAULT (0),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Name]" **
CREATE OR REPLACE TABLE Production.ProductReview (
    ProductReviewID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    ReviewerName VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ReviewDate TIMESTAMP_NTZ(3) NOT NULL
                                         --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                         DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    EmailAddress VARCHAR(50) NOT NULL,
    Rating INT NOT NULL,
    Comments VARCHAR(3850),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ProductReview_Rating CHECK ([Rating] BETWEEN 1 AND 5) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ProductSubcategory (
    ProductSubcategoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductCategoryID INT NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Purchasing.ProductVendor (
    ProductID INT NOT NULL,
    BusinessEntityID INT NOT NULL,
    AverageLeadTime INT NOT NULL,
    StandardPrice NUMBER(38, 4) NOT NULL,
    LastReceiptCost NUMBER(38, 4) NULL,
    LastReceiptDate TIMESTAMP_NTZ(3) NULL,
    MinOrderQty INT NOT NULL,
    MaxOrderQty INT NOT NULL,
    OnOrderQty INT NULL,
    UnitMeasureCode NCHAR(3) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ProductVendor_AverageLeadTime CHECK ([AverageLeadTime] >= 1) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductVendor_StandardPrice CHECK ([StandardPrice] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductVendor_LastReceiptCost CHECK ([LastReceiptCost] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductVendor_MinOrderQty CHECK ([MinOrderQty] >= 1) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductVendor_MaxOrderQty CHECK ([MaxOrderQty] >= 1) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ProductVendor_OnOrderQty CHECK ([OnOrderQty] >= 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Purchasing.PurchaseOrderDetail (
    PurchaseOrderID INT NOT NULL,
    PurchaseOrderDetailID INT IDENTITY(1, 1) ORDER NOT NULL,
    DueDate TIMESTAMP_NTZ(3) NOT NULL,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice NUMBER(38, 4) NOT NULL,
    LineTotal VARIANT AS NVL(OrderQty * UnitPrice, 0.00) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    ReceivedQty DECIMAL(8, 2) NOT NULL,
    RejectedQty DECIMAL(8, 2) NOT NULL,
    StockedQty VARIANT AS NVL(ReceivedQty - RejectedQty, 0.00) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_PurchaseOrderDetail_OrderQty CHECK ([OrderQty] > 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderDetail_UnitPrice CHECK ([UnitPrice] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderDetail_ReceivedQty CHECK ([ReceivedQty] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderDetail_RejectedQty CHECK ([RejectedQty] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Purchasing.PurchaseOrderHeader (
    PurchaseOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    RevisionNumber TINYINT NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0),
    Status TINYINT NOT NULL
                            --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                            DEFAULT (1),
    EmployeeID INT NOT NULL,
    VendorID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    OrderDate TIMESTAMP_NTZ(3) NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    ShipDate TIMESTAMP_NTZ(3) NULL,
    SubTotal NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    TaxAmt NUMBER(38, 4) NOT NULL
                                  --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                  DEFAULT (0.00),
    Freight NUMBER(38, 4) NOT NULL
                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                   DEFAULT (0.00),
    TotalDue VARIANT AS NVL(SubTotal + TaxAmt + Freight, 0) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_PurchaseOrderHeader_Status CHECK ([Status] BETWEEN 1 AND 4) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!, -- 1 = Pending; 2 = Approved; 3 = Rejected; 4 = Complete 
    CONSTRAINT CK_PurchaseOrderHeader_ShipDate CHECK (([ShipDate] >= [OrderDate]) OR ([ShipDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderHeader_SubTotal CHECK ([SubTotal] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderHeader_TaxAmt CHECK ([TaxAmt] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_PurchaseOrderHeader_Freight CHECK ([Freight] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesOrderDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT IDENTITY(1, 1) ORDER NOT NULL,
    CarrierTrackingNumber VARCHAR(25) NULL,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    SpecialOfferID INT NOT NULL,
    UnitPrice NUMBER(38, 4) NOT NULL,
    UnitPriceDiscount NUMBER(38, 4) NOT NULL
                                             --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                             DEFAULT (0.0),
    LineTotal VARIANT AS NVL(UnitPrice * (1.0 - UnitPriceDiscount) * OrderQty, 0.0) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesOrderDetail_OrderQty CHECK ([OrderQty] > 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderDetail_UnitPrice CHECK ([UnitPrice] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderDetail_UnitPriceDiscount CHECK ([UnitPriceDiscount] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "[Flag]", "[OrderNumber]" **
CREATE OR REPLACE TABLE Sales.SalesOrderHeader (
    SalesOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    RevisionNumber TINYINT NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0),
    OrderDate TIMESTAMP_NTZ(3) NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    DueDate TIMESTAMP_NTZ(3) NOT NULL,
    ShipDate TIMESTAMP_NTZ(3) NULL,
    Status TINYINT NOT NULL
                            --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                            DEFAULT (1),
    OnlineOrderFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                             --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                             DEFAULT (1),
    SalesOrderNumber VARIANT AS NVL('SO' || CAST(SalesOrderID AS VARCHAR(23)), '*** ERROR ***') /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    PurchaseOrderNumber VARIANT /*** SSC-FDM-TS0015 - DATA TYPE ORDERNUMBER IS NOT SUPPORTED IN SNOWFLAKE ***/ NULL,
    AccountNumber VARIANT /*** SSC-FDM-TS0015 - DATA TYPE ACCOUNTNUMBER IS NOT SUPPORTED IN SNOWFLAKE ***/ NULL,
    CustomerID INT NOT NULL,
    SalesPersonID INT NULL,
    TerritoryID INT NULL,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    CreditCardID INT NULL,
    CreditCardApprovalCode VARCHAR(15) NULL,
    CurrencyRateID INT NULL,
    SubTotal NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    TaxAmt NUMBER(38, 4) NOT NULL
                                  --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                  DEFAULT (0.00),
    Freight NUMBER(38, 4) NOT NULL
                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                   DEFAULT (0.00),
    TotalDue VARIANT AS NVL(SubTotal + TaxAmt + Freight, 0) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    Comment VARCHAR(128) NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesOrderHeader_Status CHECK ([Status] BETWEEN 0 AND 8) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderHeader_DueDate CHECK ([DueDate] >= [OrderDate]) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderHeader_ShipDate CHECK (([ShipDate] >= [OrderDate]) OR ([ShipDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderHeader_SubTotal CHECK ([SubTotal] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderHeader_TaxAmt CHECK ([TaxAmt] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesOrderHeader_Freight CHECK ([Freight] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesOrderHeaderSalesReason (
    SalesOrderID INT NOT NULL,
    SalesReasonID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesPerson (
    BusinessEntityID INT NOT NULL,
    TerritoryID INT NULL,
    SalesQuota NUMBER(38, 4) NULL,
    Bonus NUMBER(38, 4) NOT NULL
                                 --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                 DEFAULT (0.00),
    CommissionPct NUMBER(38, 4) NOT NULL
                                         --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                         DEFAULT (0.00),
    SalesYTD NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    SalesLastYear NUMBER(38, 4) NOT NULL
                                         --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                         DEFAULT (0.00),
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesPerson_SalesQuota CHECK ([SalesQuota] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesPerson_Bonus CHECK ([Bonus] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesPerson_CommissionPct CHECK ([CommissionPct] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesPerson_SalesYTD CHECK ([SalesYTD] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesPerson_SalesLastYear CHECK ([SalesLastYear] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesPersonQuotaHistory (
    BusinessEntityID INT NOT NULL,
    QuotaDate TIMESTAMP_NTZ(3) NOT NULL,
    SalesQuota NUMBER(38, 4) NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesPersonQuotaHistory_SalesQuota CHECK ([SalesQuota] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesReason (
    SalesReasonID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ReasonType VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesTaxRate (
    SalesTaxRateID INT IDENTITY(1, 1) ORDER NOT NULL,
    StateProvinceID INT NOT NULL,
    TaxType TINYINT NOT NULL,
    TaxRate NUMBER(38, 4) NOT NULL
                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                   DEFAULT (0.00),
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesTaxRate_TaxType CHECK ([TaxType] BETWEEN 1 AND 3) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesTerritory (
    TerritoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    "Group" VARCHAR(50) NOT NULL,
    SalesYTD NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    SalesLastYear NUMBER(38, 4) NOT NULL
                                         --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                         DEFAULT (0.00),
    CostYTD NUMBER(38, 4) NOT NULL
                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                   DEFAULT (0.00),
    CostLastYear NUMBER(38, 4) NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (0.00),
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesTerritory_SalesYTD CHECK ([SalesYTD] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesTerritory_SalesLastYear CHECK ([SalesLastYear] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesTerritory_CostYTD CHECK ([CostYTD] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SalesTerritory_CostLastYear CHECK ([CostLastYear] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SalesTerritoryHistory (
    BusinessEntityID INT NOT NULL,  -- A sales person

    TerritoryID INT NOT NULL,
    StartDate TIMESTAMP_NTZ(3) NOT NULL,
    EndDate TIMESTAMP_NTZ(3) NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SalesTerritoryHistory_EndDate CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.ScrapReason (
    ScrapReasonID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE HumanResources.Shift (
    ShiftID TINYINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    StartTime TIME(7) NOT NULL,
    EndTime TIME(7) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Purchasing.ShipMethod (
    ShipMethodID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ShipBase NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    ShipRate NUMBER(38, 4) NOT NULL
                                    --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                    DEFAULT (0.00),
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ShipMethod_ShipBase CHECK ([ShipBase] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_ShipMethod_ShipRate CHECK ([ShipRate] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.ShoppingCartItem (
    ShoppingCartItemID INT IDENTITY(1, 1) ORDER NOT NULL,
    ShoppingCartID VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL
                          --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                          DEFAULT (1),
    ProductID INT NOT NULL,
    DateCreated TIMESTAMP_NTZ(3) NOT NULL
                                          --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                          DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_ShoppingCartItem_Quantity CHECK ([Quantity] >= 1) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SpecialOffer (
    SpecialOfferID INT IDENTITY(1, 1) ORDER NOT NULL,
    Description VARCHAR(255) NOT NULL,
    DiscountPct NUMBER(38, 4) NOT NULL
                                       --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                       DEFAULT (0.00),
    Type VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    StartDate TIMESTAMP_NTZ(3) NOT NULL,
    EndDate TIMESTAMP_NTZ(3) NOT NULL,
    MinQty INT NOT NULL
                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                        DEFAULT (0),
    MaxQty INT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_SpecialOffer_EndDate CHECK ([EndDate] >= [StartDate]) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SpecialOffer_DiscountPct CHECK ([DiscountPct] >= 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SpecialOffer_MinQty CHECK ([MinQty] >= 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_SpecialOffer_MaxQty CHECK ([MaxQty] >= 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.SpecialOfferProduct (
    SpecialOfferID INT NOT NULL,
    ProductID INT NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Flag]" **
CREATE OR REPLACE TABLE Person.StateProvince (
    StateProvinceID INT IDENTITY(1, 1) ORDER NOT NULL,
    StateProvinceCode NCHAR(3) NOT NULL,
    CountryRegionCode VARCHAR(3) NOT NULL,
    IsOnlyStateProvinceFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                                     --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                                     DEFAULT (1),
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    TerritoryID INT NOT NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Sales.Store (
    BusinessEntityID INT NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    SalesPersonID INT NULL,
    Demographics VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!! NULL,
    rowguid VARCHAR
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
                    ROWGUIDCOL NOT NULL
                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                        DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.TransactionHistory (
    TransactionID INT IDENTITY(100000, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    ReferenceOrderID INT NOT NULL,
    ReferenceOrderLineID INT NOT NULL
                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                      DEFAULT (0),
    TransactionDate TIMESTAMP_NTZ(3) NOT NULL
                                              --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                              DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    TransactionType NCHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_TransactionHistory_TransactionType CHECK (UPPER([TransactionType]) IN ('W', 'S', 'P')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.TransactionHistoryArchive (
    TransactionID INT NOT NULL,
    ProductID INT NOT NULL,
    ReferenceOrderID INT NOT NULL,
    ReferenceOrderLineID INT NOT NULL
                                      --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                      DEFAULT (0),
    TransactionDate TIMESTAMP_NTZ(3) NOT NULL
                                              --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                              DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    TransactionType NCHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_TransactionHistoryArchive_TransactionType CHECK (UPPER([TransactionType]) IN ('W', 'S', 'P')) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.UnitMeasure (
    UnitMeasureCode NCHAR(3) NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[Flag]" **
CREATE OR REPLACE TABLE Purchasing.Vendor (
    BusinessEntityID INT NOT NULL,
    AccountNumber VARIANT /*** SSC-FDM-TS0015 - DATA TYPE ACCOUNTNUMBER IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    Name VARIANT /*** SSC-FDM-TS0015 - DATA TYPE NAME IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL,
    CreditRating TINYINT NOT NULL,
    PreferredVendorStatus VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                                   --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                                   DEFAULT (1),
    ActiveFlag VARIANT /*** SSC-FDM-TS0015 - DATA TYPE FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/ NOT NULL
                                                                                                        --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                                                                                        DEFAULT (1),
    PurchasingWebServiceURL VARCHAR(1024) NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_Vendor_CreditRating CHECK ([CreditRating] BETWEEN 1 AND 5) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.WorkOrder (
    WorkOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    OrderQty INT NOT NULL,
    StockedQty VARIANT AS NVL(OrderQty - ScrappedQty, 0) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/,
    ScrappedQty SMALLINT NOT NULL,
    StartDate TIMESTAMP_NTZ(3) NOT NULL,
    EndDate TIMESTAMP_NTZ(3) NULL,
    DueDate TIMESTAMP_NTZ(3) NOT NULL,
    ScrapReasonID SMALLINT NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_WorkOrder_OrderQty CHECK ([OrderQty] > 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrder_ScrappedQty CHECK ([ScrappedQty] >= 0) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrder_EndDate CHECK (([EndDate] >= [StartDate]) OR ([EndDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Production.WorkOrderRouting (
    WorkOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    OperationSequence SMALLINT NOT NULL,
    LocationID SMALLINT NOT NULL,
    ScheduledStartDate TIMESTAMP_NTZ(3) NOT NULL,
    ScheduledEndDate TIMESTAMP_NTZ(3) NOT NULL,
    ActualStartDate TIMESTAMP_NTZ(3) NULL,
    ActualEndDate TIMESTAMP_NTZ(3) NULL,
    ActualResourceHrs DECIMAL(9, 4) NULL,
    PlannedCost NUMBER(38, 4) NOT NULL,
    ActualCost NUMBER(38, 4) NULL,
    ModifiedDate TIMESTAMP_NTZ(3) NOT NULL
                                           --** SSC-FDM-0012 - CONSTRAINT IN DEFAULT EXPRESSION IS NOT SUPPORTED IN SNOWFLAKE **
                                           DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    CONSTRAINT CK_WorkOrderRouting_ScheduledEndDate CHECK ([ScheduledEndDate] >= [ScheduledStartDate]) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrderRouting_ActualEndDate CHECK (([ActualEndDate] >= [ActualStartDate])
        OR ([ActualEndDate] IS NULL) OR ([ActualStartDate] IS NULL)) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrderRouting_ActualResourceHrs CHECK ([ActualResourceHrs] >= 0.0000) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrderRouting_PlannedCost CHECK ([PlannedCost] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!,
    CONSTRAINT CK_WorkOrderRouting_ActualCost CHECK ([ActualCost] > 0.00) !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CheckConstraintDefinition' NODE ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;