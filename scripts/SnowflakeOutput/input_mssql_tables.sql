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
;;
CREATE OR REPLACE TABLE dbo.DimCurrency (
	CurrencyKey INT IDENTITY(1,1) ORDER NOT NULL,
	CurrencyAlternateKey NCHAR NOT NULL,
	CurrencyName VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
;;
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
;;
CREATE OR REPLACE TABLE dbo.DimDepartmentGroup (
	DepartmentGroupKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentDepartmentGroupKey INT NULL,
	DepartmentGroupName VARCHAR(50) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
;;
CREATE OR REPLACE TABLE dbo.DimGeography (
	GeographyKey INT IDENTITY(1,1) ORDER NOT NULL,
	City VARCHAR(30) NULL,
	StateProvinceCode VARCHAR NULL,
	StateProvinceName VARCHAR(50) NULL,
	CountryRegionCode VARCHAR NULL,
	EnglishCountryRegionName VARCHAR(50) NULL,
	SpanishCountryRegionName VARCHAR(50) NULL,
	FrenchCountryRegionName VARCHAR(50) NULL,
	PostalCode VARCHAR(15) NULL,
	SalesTerritoryKey INT NULL,
	IpAddressLocator VARCHAR(15) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimOrganization (
	OrganizationKey INT IDENTITY(1,1) ORDER NOT NULL,
	ParentOrganizationKey INT NULL,
	PercentageOfOwnership VARCHAR(16) NULL,
	OrganizationName VARCHAR(50) NULL,
	CurrencyKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimProduct (
	ProductKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductAlternateKey VARCHAR(25) NULL,
	ProductSubcategoryKey INT NULL,
	WeightUnitMeasureCode NCHAR NULL,
	SizeUnitMeasureCode NCHAR NULL,
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
	StartDate TIMESTAMP_NTZ NULL,
	EndDate TIMESTAMP_NTZ NULL,
	Status VARCHAR(7) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimProductCategory (
	ProductCategoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductCategoryAlternateKey INT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	SpanishProductCategoryName VARCHAR(50) NOT NULL,
	FrenchProductCategoryName VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimProductSubcategory (
	ProductSubcategoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProductSubcategoryAlternateKey INT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	SpanishProductSubcategoryName VARCHAR(50) NOT NULL,
	FrenchProductSubcategoryName VARCHAR(50) NOT NULL,
	ProductCategoryKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
	StartDate TIMESTAMP_NTZ NOT NULL,
	EndDate TIMESTAMP_NTZ NULL,
	MinQty INT NULL,
	MaxQty INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
;;
CREATE OR REPLACE TABLE dbo.DimSalesReason (
	SalesReasonKey INT IDENTITY(1,1) ORDER NOT NULL,
	SalesReasonAlternateKey INT NOT NULL,
	SalesReasonName VARCHAR(50) NOT NULL,
	SalesReasonReasonType VARCHAR(50) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimSalesTerritory (
	SalesTerritoryKey INT IDENTITY(1,1) ORDER NOT NULL,
	SalesTerritoryAlternateKey INT NULL,
	SalesTerritoryRegion VARCHAR(50) NOT NULL,
	SalesTerritoryCountry VARCHAR(50) NOT NULL,
	SalesTerritoryGroup VARCHAR(50) NULL,
	SalesTerritoryImage VARBINARY NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.DimScenario (
	ScenarioKey INT IDENTITY(1,1) ORDER NOT NULL,
	ScenarioName VARCHAR(50) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactAdditionalInternationalProductDescription (
	ProductKey INT NOT NULL,
	CultureName VARCHAR(50) NOT NULL,
	ProductDescription VARCHAR NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
	Date TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactCurrencyRate (
	CurrencyKey INT NOT NULL,
	DateKey INT NOT NULL,
	AverageRate FLOAT NOT NULL,
	EndOfDayRate FLOAT NOT NULL,
	Date TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactFinance (
	FinanceKey INT IDENTITY(1,1) ORDER NOT NULL,
	DateKey INT NOT NULL,
	OrganizationKey INT NOT NULL,
	DepartmentGroupKey INT NOT NULL,
	ScenarioKey INT NOT NULL,
	AccountKey INT NOT NULL,
	Amount FLOAT NOT NULL,
	Date TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
	OrderDate TIMESTAMP_NTZ NULL,
	DueDate TIMESTAMP_NTZ NULL,
	ShipDate TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactInternetSalesReason (
	SalesOrderNumber VARCHAR(20) NOT NULL,
	SalesOrderLineNumber TINYINT NOT NULL,
	SalesReasonKey INT NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
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
;;
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
	OrderDate TIMESTAMP_NTZ NULL,
	DueDate TIMESTAMP_NTZ NULL,
	ShipDate TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactSalesQuota (
	SalesQuotaKey INT IDENTITY(1,1) ORDER NOT NULL,
	EmployeeKey INT NOT NULL,
	DateKey INT NOT NULL,
	CalendarYear SMALLINT NOT NULL,
	CalendarQuarter TINYINT NOT NULL,
	SalesAmountQuota NUMBER(38, 4) NOT NULL,
	Date TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.FactSurveyResponse (
	SurveyResponseKey INT IDENTITY(1,1) ORDER NOT NULL,
	DateKey INT NOT NULL,
	CustomerKey INT NOT NULL,
	ProductCategoryKey INT NOT NULL,
	EnglishProductCategoryName VARCHAR(50) NOT NULL,
	ProductSubcategoryKey INT NOT NULL,
	EnglishProductSubcategoryName VARCHAR(50) NOT NULL,
	Date TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.NewFactCurrencyRate (
	AverageRate REAL NULL,
	CurrencyID VARCHAR NULL,
	CurrencyDate DATE NULL,
	EndOfDayRate REAL NULL,
	CurrencyKey INT NULL,
	DateKey INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.ProspectiveBuyer (
	ProspectiveBuyerKey INT IDENTITY(1,1) ORDER NOT NULL,
	ProspectAlternateKey VARCHAR(15) NULL,
	FirstName VARCHAR(50) NULL,
	MiddleName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	BirthDate TIMESTAMP_NTZ NULL,
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
	StateProvinceCode VARCHAR NULL,
	PostalCode VARCHAR(15) NULL,
	Phone VARCHAR(20) NULL,
	Salutation VARCHAR(8) NULL,
	Unknown INT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.sysdiagrams (
	name VARCHAR(128) NOT NULL,
	principal_id INT NOT NULL,
	diagram_id INT IDENTITY(1,1) ORDER NOT NULL,
	version INT NULL,
	definition VARBINARY NULL
	)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
---PRINT '';
---PRINT '*** Creating Tables';
CREATE OR REPLACE TABLE Person.Address (
	AddressID INT IDENTITY(1, 1) ORDER NOT NULL,
	AddressLine1 VARCHAR(60) NOT NULL,
	AddressLine2 VARCHAR(60) NULL,
	City VARCHAR(30) NOT NULL,
	StateProvinceID INT NOT NULL,
	PostalCode VARCHAR(15) NOT NULL,
	SpatialLocation GEOGRAPHY NULL,
	rowguid VARCHAR DEFAULT (UUID_STRING()),
	ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.AddressType (
	AddressTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
	Name VARIANT  NOT NULL,
	rowguid VARCHAR DEFAULT (UUID_STRING()),
	ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE dbo.AWBuildVersion (
	SystemInformationID TINYINT IDENTITY(1, 1) ORDER NOT NULL,
	"Database Version" VARCHAR(25) NOT NULL,
	VersionDate TIMESTAMP_NTZ NOT NULL,
	ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.BillOfMaterials (
	BillOfMaterialsID INT IDENTITY(1, 1) ORDER NOT NULL,
	ProductAssemblyID INT NULL,
	ComponentID INT NOT NULL,
	StartDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
	EndDate TIMESTAMP_NTZ NULL,
	UnitMeasureCode NCHAR NOT NULL,
	BOMLevel SMALLINT NOT NULL,
	PerAssemblyQty DECIMAL(8, 2) NOT NULL DEFAULT (1.00),
	ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.BusinessEntity (
    BusinessEntityID INT IDENTITY(1, 1) ORDER NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.BusinessEntityAddress (
    BusinessEntityID INT NOT NULL,
    AddressID INT NOT NULL,
    AddressTypeID INT NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.BusinessEntityContact (
    BusinessEntityID INT NOT NULL,
    PersonID INT NOT NULL,
    ContactTypeID INT NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.ContactType (
    ContactTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.CountryRegionCurrency (
    CountryRegionCode VARCHAR NOT NULL,
    CurrencyCode NCHAR NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.CountryRegion (
    CountryRegionCode VARCHAR NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.CreditCard (
    CreditCardID INT IDENTITY(1, 1) ORDER NOT NULL,
    CardType VARCHAR(50) NOT NULL,
    CardNumber VARCHAR(25) NOT NULL,
    ExpMonth TINYINT NOT NULL,
    ExpYear SMALLINT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.Culture (
    CultureID NCHAR(6) NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.Currency (
    CurrencyCode NCHAR NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.CurrencyRate (
    CurrencyRateID INT IDENTITY(1, 1) ORDER NOT NULL,
    CurrencyRateDate TIMESTAMP_NTZ NOT NULL,
    FromCurrencyCode NCHAR NOT NULL,
    ToCurrencyCode NCHAR NOT NULL,
    AverageRate NUMBER(38, 4) NOT NULL,
    EndOfDayRate NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.Customer (
    CustomerID INT IDENTITY(1, 1) ORDER NOT NULL,
    PersonID INT NULL,
    StoreID INT NULL,
    TerritoryID INT NULL,
    AccountNumber VARIANT ,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.Department (
    DepartmentID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    GroupName VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.EmailAddress (
    BusinessEntityID INT NOT NULL,
    EmailAddressID INT IDENTITY(1, 1) ORDER NOT NULL,
    EmailAddress VARCHAR(50) NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.EmployeeDepartmentHistory (
    BusinessEntityID INT NOT NULL,
    DepartmentID SMALLINT NOT NULL,
    ShiftID TINYINT NOT NULL,
    StartDate DATE NOT NULL,
    EndDate DATE NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.EmployeePayHistory (
    BusinessEntityID INT NOT NULL,
    RateChangeDate TIMESTAMP_NTZ NOT NULL,
    Rate NUMBER(38, 4) NOT NULL,
    PayFrequency TINYINT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.Illustration (
    IllustrationID INT IDENTITY(1, 1) ORDER NOT NULL,
    Diagram VARIANT   NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.JobCandidate (
    JobCandidateID INT IDENTITY(1, 1) ORDER NOT NULL,
    BusinessEntityID INT NULL,
    Resume VARIANT   NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.Location (
    LocationID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    CostRate NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    Availability DECIMAL(8, 2) NOT NULL DEFAULT (0.00),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.Password (
    BusinessEntityID INT NOT NULL,
    PasswordHash VARCHAR(128) NOT NULL,
    PasswordSalt VARCHAR(10) NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.Person (
    BusinessEntityID INT NOT NULL,
    PersonType NCHAR(2) NOT NULL,
    NameStyle VARIANT  NOT NULL,
    Title VARCHAR(8) NULL,
    FirstName VARIANT  NOT NULL,
    MiddleName VARIANT  NULL,
    LastName VARIANT  NOT NULL,
    Suffix VARCHAR(10) NULL,
    EmailPromotion INT NOT NULL DEFAULT (0),
    AdditionalContactInfo VARIANT   NULL,
    Demographics VARIANT   NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.PersonCreditCard (
    BusinessEntityID INT NOT NULL,
    CreditCardID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.PersonPhone (
    BusinessEntityID INT NOT NULL,
    PhoneNumber VARIANT  NOT NULL,
    PhoneNumberTypeID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.PhoneNumberType (
    PhoneNumberTypeID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.Product (
    ProductID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ProductNumber VARCHAR(25) NOT NULL,
    MakeFlag VARIANT  NOT NULL,
    FinishedGoodsFlag VARIANT  NOT NULL,
    Color VARCHAR(15) NULL,
    SafetyStockLevel SMALLINT NOT NULL,
    ReorderPoint SMALLINT NOT NULL,
    StandardCost NUMBER(38, 4) NOT NULL,
    ListPrice NUMBER(38, 4) NOT NULL,
    Size VARCHAR(5) NULL,
    SizeUnitMeasureCode NCHAR NULL,
    WeightUnitMeasureCode NCHAR NULL,
    Weight DECIMAL(8, 2) NULL,
    DaysToManufacture INT NOT NULL,
    ProductLine NCHAR(2) NULL,
    Class NCHAR(2) NULL,
    Style NCHAR(2) NULL,
    ProductSubcategoryID INT NULL,
    ProductModelID INT NULL,
    SellStartDate TIMESTAMP_NTZ NOT NULL,
    SellEndDate TIMESTAMP_NTZ NULL,
    DiscontinuedDate TIMESTAMP_NTZ NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductCategory (
    ProductCategoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductCostHistory (
    ProductID INT NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ NULL,
    StandardCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductDescription (
    ProductDescriptionID INT IDENTITY(1, 1) ORDER NOT NULL,
    Description VARCHAR(400) NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductDocument (
    ProductID INT NOT NULL,
    DocumentNode VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductInventory (
    ProductID INT NOT NULL,
    LocationID SMALLINT NOT NULL,
    Shelf VARCHAR(10) NOT NULL,
    Bin TINYINT NOT NULL,
    Quantity SMALLINT NOT NULL DEFAULT (0),
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductListPriceHistory (
    ProductID INT NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ NULL,
    ListPrice NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductModel (
    ProductModelID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    CatalogDescription VARIANT   NULL,
    Instructions VARIANT   NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductModelIllustration (
    ProductModelID INT NOT NULL,
    IllustrationID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductModelProductDescriptionCulture (
    ProductModelID INT NOT NULL,
    ProductDescriptionID INT NOT NULL,
    CultureID NCHAR(6) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductPhoto (
    ProductPhotoID INT IDENTITY(1, 1) ORDER NOT NULL,
    ThumbNailPhoto VARBINARY NULL,
    ThumbnailPhotoFileName VARCHAR(50) NULL,
    LargePhoto VARBINARY NULL,
    LargePhotoFileName VARCHAR(50) NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductProductPhoto (
    ProductID INT NOT NULL,
    ProductPhotoID INT NOT NULL,
    Primary VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductReview (
    ProductReviewID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    ReviewerName VARIANT  NOT NULL,
    ReviewDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    EmailAddress VARCHAR(50) NOT NULL,
    Rating INT NOT NULL,
    Comments VARCHAR(3850),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ProductSubcategory (
    ProductSubcategoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductCategoryID INT NOT NULL,
    Name VARIANT  NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Purchasing.ProductVendor (
    ProductID INT NOT NULL,
    BusinessEntityID INT NOT NULL,
    AverageLeadTime INT NOT NULL,
    StandardPrice NUMBER(38, 4) NOT NULL,
    LastReceiptCost NUMBER(38, 4) NULL,
    LastReceiptDate TIMESTAMP_NTZ NULL,
    MinOrderQty INT NOT NULL,
    MaxOrderQty INT NOT NULL,
    OnOrderQty INT NULL,
    UnitMeasureCode NCHAR NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Purchasing.PurchaseOrderDetail (
    PurchaseOrderID INT NOT NULL,
    PurchaseOrderDetailID INT IDENTITY(1, 1) ORDER NOT NULL,
    DueDate TIMESTAMP_NTZ NOT NULL,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    UnitPrice NUMBER(38, 4) NOT NULL,
    LineTotal VARIANT ,
    ReceivedQty DECIMAL(8, 2) NOT NULL,
    RejectedQty DECIMAL(8, 2) NOT NULL,
    StockedQty VARIANT ,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Purchasing.PurchaseOrderHeader (
    PurchaseOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    RevisionNumber TINYINT NOT NULL DEFAULT (0),
    Status TINYINT NOT NULL DEFAULT (1),
    EmployeeID INT NOT NULL,
    VendorID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    OrderDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    ShipDate TIMESTAMP_NTZ NULL,
    SubTotal NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    TaxAmt NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    Freight NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    TotalDue VARIANT ,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesOrderDetail (
    SalesOrderID INT NOT NULL,
    SalesOrderDetailID INT IDENTITY(1, 1) ORDER NOT NULL,
    CarrierTrackingNumber VARCHAR(25) NULL,
    OrderQty SMALLINT NOT NULL,
    ProductID INT NOT NULL,
    SpecialOfferID INT NOT NULL,
    UnitPrice NUMBER(38, 4) NOT NULL,
    UnitPriceDiscount NUMBER(38, 4) NOT NULL DEFAULT (0.0),
    LineTotal VARIANT ,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesOrderHeaderSalesReason (
    SalesOrderID INT NOT NULL,
    SalesReasonID INT NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesPerson (
    BusinessEntityID INT NOT NULL,
    TerritoryID INT NULL,
    SalesQuota NUMBER(38, 4) NULL,
    Bonus NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    CommissionPct NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    SalesYTD NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    SalesLastYear NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesPersonQuotaHistory (
    BusinessEntityID INT NOT NULL,
    QuotaDate TIMESTAMP_NTZ NOT NULL,
    SalesQuota NUMBER(38, 4) NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesReason (
    SalesReasonID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ReasonType VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesTaxRate (
    SalesTaxRateID INT IDENTITY(1, 1) ORDER NOT NULL,
    StateProvinceID INT NOT NULL,
    TaxType TINYINT NOT NULL,
    TaxRate NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    Name VARIANT  NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesTerritory (
    TerritoryID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    CountryRegionCode VARCHAR NOT NULL,
    "Group" VARCHAR(50) NOT NULL,
    SalesYTD NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    SalesLastYear NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    CostYTD NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    CostLastYear NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesTerritoryHistory (
    BusinessEntityID INT NOT NULL,
    TerritoryID INT NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.ScrapReason (
    ScrapReasonID SMALLINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.Shift (
    ShiftID TINYINT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    StartTime TIME NOT NULL,
    EndTime TIME NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Purchasing.ShipMethod (
    ShipMethodID INT IDENTITY(1, 1) ORDER NOT NULL,
    Name VARIANT  NOT NULL,
    ShipBase NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    ShipRate NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.ShoppingCartItem (
    ShoppingCartItemID INT IDENTITY(1, 1) ORDER NOT NULL,
    ShoppingCartID VARCHAR(50) NOT NULL,
    Quantity INT NOT NULL DEFAULT (1),
    ProductID INT NOT NULL,
    DateCreated TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SpecialOffer (
    SpecialOfferID INT IDENTITY(1, 1) ORDER NOT NULL,
    Description VARCHAR(255) NOT NULL,
    DiscountPct NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    Type VARCHAR(50) NOT NULL,
    Category VARCHAR(50) NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ NOT NULL,
    MinQty INT NOT NULL DEFAULT (0),
    MaxQty INT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SpecialOfferProduct (
    SpecialOfferID INT NOT NULL,
    ProductID INT NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Person.StateProvince (
    StateProvinceID INT IDENTITY(1, 1) ORDER NOT NULL,
    StateProvinceCode NCHAR NOT NULL,
    CountryRegionCode VARCHAR NOT NULL,
    IsOnlyStateProvinceFlag VARIANT  NOT NULL,
    Name VARIANT  NOT NULL,
    TerritoryID INT NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.Store (
    BusinessEntityID INT NOT NULL,
    Name VARIANT  NOT NULL,
    SalesPersonID INT NULL,
    Demographics VARIANT   NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.TransactionHistory (
    TransactionID INT IDENTITY(100000, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    ReferenceOrderID INT NOT NULL,
    ReferenceOrderLineID INT NOT NULL DEFAULT (0),
    TransactionDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    TransactionType NCHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.TransactionHistoryArchive (
    TransactionID INT NOT NULL,
    ProductID INT NOT NULL,
    ReferenceOrderID INT NOT NULL,
    ReferenceOrderLineID INT NOT NULL DEFAULT (0),
    TransactionDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    TransactionType NCHAR(1) NOT NULL,
    Quantity INT NOT NULL,
    ActualCost NUMBER(38, 4) NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.UnitMeasure (
    UnitMeasureCode NCHAR NOT NULL,
    Name VARIANT  NOT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP)
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Purchasing.Vendor (
    BusinessEntityID INT NOT NULL,
    AccountNumber VARIANT  NOT NULL,
    Name VARIANT  NOT NULL,
    CreditRating TINYINT NOT NULL,
    PreferredVendorStatus VARIANT  NOT NULL,
    ActiveFlag VARIANT  NOT NULL,
    PurchasingWebServiceURL VARCHAR(1024) NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.WorkOrder (
    WorkOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    ProductID INT NOT NULL,
    OrderQty INT NOT NULL,
    StockedQty VARIANT ,
    ScrappedQty SMALLINT NOT NULL,
    StartDate TIMESTAMP_NTZ NOT NULL,
    EndDate TIMESTAMP_NTZ NULL,
    DueDate TIMESTAMP_NTZ NOT NULL,
    ScrapReasonID SMALLINT NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.WorkOrderRouting (
    WorkOrderID INT NOT NULL,
    ProductID INT NOT NULL,
    OperationSequence SMALLINT NOT NULL,
    LocationID SMALLINT NOT NULL,
    ScheduledStartDate TIMESTAMP_NTZ NOT NULL,
    ScheduledEndDate TIMESTAMP_NTZ NOT NULL,
    ActualStartDate TIMESTAMP_NTZ NULL,
    ActualEndDate TIMESTAMP_NTZ NULL,
    ActualResourceHrs DECIMAL(9, 4) NULL,
    PlannedCost NUMBER(38, 4) NOT NULL,
    ActualCost NUMBER(38, 4) NULL,
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
