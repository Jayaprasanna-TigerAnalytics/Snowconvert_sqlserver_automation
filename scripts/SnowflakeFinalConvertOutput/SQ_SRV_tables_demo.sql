CREATE OR REPLACE TABLE EmployeeDetails (
    EmployeeID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Phone CHAR(10),
    DateOfBirth DATE,
    JoiningTime TIMESTAMP_NTZ,
    Salary NUMBER(38, 4),
    EmployeeCode VARCHAR DEFAULT UUID_STRING(),
    ProfileImage VARBINARY,
    Remarks TEXT
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE ProductCatalog (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductSpecs VARCHAR
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE EmployeeRecords (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    EmployeeData VARIANT  
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE LocationInfo (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    GeoCoordinates GEOGRAPHY
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE UserStatus (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    IsActive BOOLEAN
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
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
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    OrderID INT,
    ProductID INT,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice NUMERIC(18,2) AS (Quantity * UnitPrice) 
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
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
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE Products (
    ProductID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT,
    Category VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    UnitOfMeasure VARCHAR(50),
    CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    WarehouseName VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    Capacity INT NOT NULL,
    Manager VARCHAR(255),
    CreatedAt TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    ProductID INT,
    WarehouseID INT,
    Quantity INT NOT NULL,
    LastUpdated TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
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
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
CREATE OR REPLACE TABLE Orders (
    OrderID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    CustomerID INT,
    OrderDate TIMESTAMP_NTZ DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
    Status VARCHAR(50)
 CHECK (Status  ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    TotalAmount DECIMAL(18,2) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
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
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;
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
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
;