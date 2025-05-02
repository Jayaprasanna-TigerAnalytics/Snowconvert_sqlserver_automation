
---PRINT '';
---PRINT '*** Creating Tables';
CREATE OR REPLACE TABLE dbo.AdventureWorksDWBuildVersion (
	DBVersion VARCHAR(50) NULL,
	VersionDate TIMESTAMP_NTZ NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Suppliers (
	SupplierID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	SupplierName VARCHAR(255) NOT NULL,
	ContactName VARCHAR(255),
	Phone VARCHAR(50),
	Email VARCHAR(255),
	Address VARCHAR(500),
	City VARCHAR(100),
	Country VARCHAR(100),
	CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Products (
	ProductID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	ProductName VARCHAR(255) NOT NULL,
	SupplierID INT,
	Category VARCHAR(100),
	Price DECIMAL(10,2) NOT NULL,
	UnitOfMeasure VARCHAR(50),
	CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Warehouses (
	WarehouseID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	WarehouseName VARCHAR(255) NOT NULL,
	Location VARCHAR(255),
	Capacity INT NOT NULL,
	Manager VARCHAR(255),
	CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Inventory (
	InventoryID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	ProductID INT,
	WarehouseID INT,
	Quantity INT NOT NULL,
	LastUpdated TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Customers (
	CustomerID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	CustomerName VARCHAR(255) NOT NULL,
	ContactName VARCHAR(255),
	Phone VARCHAR(50),
	Email VARCHAR(255),
	Address VARCHAR(500),
	City VARCHAR(100),
	Country VARCHAR(100),
	CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Orders (
	OrderID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	CustomerID INT,
	OrderDate TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
	Status VARCHAR(50)
 CHECK (Status  ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
	TotalAmount DECIMAL(18,2) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE OrderDetails (
	OrderDetailID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	Quantity INT NOT NULL,
	UnitPrice DECIMAL(10,2) NOT NULL,
	TotalPrice NUMERIC(18,2) AS (Quantity * UnitPrice) 
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Shipments (
	ShipmentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT,
	ShipmentDate TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
	Carrier VARCHAR(255),
	TrackingNumber VARCHAR(50),
	Status VARCHAR(50)
 CHECK (Status  ('In Transit', 'Delivered', 'Delayed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Returns (
	ReturnID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT,
	ProductID INT,
	Quantity INT NOT NULL,
	ReturnReason VARCHAR(255),
	ReturnDate TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
	Status VARCHAR(50)
 CHECK (Status  ('Pending', 'Approved', 'Rejected'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Payments (
	PaymentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
	OrderID INT,
	PaymentDate TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
	PaymentMethod VARCHAR(50)
 CHECK (PaymentMethod  ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
	AmountPaid DECIMAL(18,2) NOT NULL,
	Status VARCHAR(50)
 CHECK (Status  ('Completed', 'Pending', 'Failed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Production.Document (
    DocumentNode VARIANT  NOT NULL,
    DocumentLevel VARIANT AS
    DocumentNode.GetLevel() ,
    Title VARCHAR(50) NOT NULL,
    Owner INT NOT NULL,
    FolderFlag BOOLEAN NOT NULL DEFAULT FALSE,
    FileName VARCHAR(400) NOT NULL,
    FileExtension VARCHAR(8) NOT NULL,
    Revision NCHAR(5) NOT NULL,
    ChangeNumber INT NOT NULL DEFAULT (0),
    Status TINYINT NOT NULL,
    DocumentSummary VARCHAR NULL,
    Document VARBINARY NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE HumanResources.Employee (
    BusinessEntityID INT NOT NULL,
    NationalIDNumber VARCHAR(15) NOT NULL,
    LoginID VARCHAR(256) NOT NULL,
    OrganizationNode VARIANT  NULL,
    OrganizationLevel VARIANT AS
    OrganizationNode.GetLevel() ,
    JobTitle VARCHAR(50) NOT NULL,
    BirthDate DATE NOT NULL,
    MaritalStatus NCHAR(1) NOT NULL,
    Gender NCHAR(1) NOT NULL,
    HireDate DATE NOT NULL,
    SalariedFlag VARIANT  NOT NULL,
    VacationHours SMALLINT NOT NULL DEFAULT (0),
    SickLeaveHours SMALLINT NOT NULL DEFAULT (0),
    CurrentFlag VARIANT  NOT NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
CREATE OR REPLACE TABLE Sales.SalesOrderHeader (
    SalesOrderID INT IDENTITY(1, 1) ORDER NOT NULL,
    RevisionNumber TINYINT NOT NULL DEFAULT (0),
    OrderDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP),
    DueDate TIMESTAMP_NTZ NOT NULL,
    ShipDate TIMESTAMP_NTZ NULL,
    Status TINYINT NOT NULL DEFAULT (1),
    OnlineOrderFlag VARIANT  NOT NULL,
    SalesOrderNumber VARIANT AS NVL('SO' || CAST(SalesOrderID AS VARCHAR(23)), '*** ERROR ***') ,
    PurchaseOrderNumber VARIANT  NULL,
    AccountNumber VARIANT  NULL,
    CustomerID INT NOT NULL,
    SalesPersonID INT NULL,
    TerritoryID INT NULL,
    BillToAddressID INT NOT NULL,
    ShipToAddressID INT NOT NULL,
    ShipMethodID INT NOT NULL,
    CreditCardID INT NULL,
    CreditCardApprovalCode VARCHAR(15) NULL,
    CurrencyRateID INT NULL,
    SubTotal NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    TaxAmt NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    Freight NUMBER(38, 4) NOT NULL DEFAULT (0.00),
    TotalDue VARIANT ,
    Comment VARCHAR(128) NULL,
    rowguid VARCHAR DEFAULT (UUID_STRING()),
    ModifiedDate TIMESTAMP_NTZ NOT NULL DEFAULT (CURRENT_TIMESTAMP() :: TIMESTAMP))
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
;;
