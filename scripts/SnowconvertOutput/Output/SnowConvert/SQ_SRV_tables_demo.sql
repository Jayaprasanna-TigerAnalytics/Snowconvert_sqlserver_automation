CREATE OR REPLACE TABLE EmployeeDetails (
    EmployeeID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    FullName VARCHAR(100) NOT NULL,
    Email VARCHAR(255) UNIQUE,
    Phone CHAR(10),
    DateOfBirth DATE,
    JoiningTime TIMESTAMP_NTZ(3),
    Salary NUMBER(38, 4),
    EmployeeCode VARCHAR DEFAULT UUID_STRING(),
    ProfileImage VARBINARY,
    Remarks TEXT
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE ProductCatalog (
    ProductID INT PRIMARY KEY,
    ProductName VARCHAR(100),
    ProductSpecs VARCHAR
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE EmployeeRecords (
    EmployeeID INT PRIMARY KEY,
    FullName VARCHAR(100),
    EmployeeData VARIANT !!!RESOLVE EWI!!! /*** SSC-EWI-0036 - XML DATA TYPE CONVERTED TO VARIANT ***/!!!
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE LocationInfo (
    LocationID INT PRIMARY KEY,
    LocationName VARCHAR(100),
    GeoCoordinates GEOGRAPHY
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE UserStatus (
    UserID INT PRIMARY KEY,
    UserName VARCHAR(100),
    IsActive BOOLEAN
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Payments (
    PaymentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
    PaymentDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
    PaymentMethod VARCHAR(50)
                              !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    AmountPaid DECIMAL(18,2) NOT NULL,
    Status VARCHAR(50)
                       !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Completed', 'Pending', 'Failed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice VARIANT AS (Quantity * UnitPrice) /*** SSC-FDM-TS0014 - COMPUTED COLUMN WAS TRANSFORMED TO ITS SNOWFLAKE EQUIVALENT, FUNCTIONAL EQUIVALENCE VERIFICATION PENDING. ***/
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
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
    CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Products (
    ProductID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    ProductName VARCHAR(255) NOT NULL,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers (SupplierID),
    Category VARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    UnitOfMeasure VARCHAR(50),
    CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    WarehouseName VARCHAR(255) NOT NULL,
    Location VARCHAR(255),
    Capacity INT NOT NULL,
    Manager VARCHAR(255),
    CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
    WarehouseID INT FOREIGN KEY REFERENCES Warehouses (WarehouseID),
    Quantity INT NOT NULL,
    LastUpdated TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
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
    CreatedAt TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Orders (
    OrderID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers (CustomerID),
    OrderDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
    Status VARCHAR(50)
                       !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    TotalAmount DECIMAL(18,2) NOT NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

CREATE OR REPLACE TABLE Returns (
    ReturnID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products (ProductID),
    Quantity INT NOT NULL,
    ReturnReason VARCHAR(255),
    ReturnDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
    Status VARCHAR(50)
                       !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;

--** SSC-FDM-0019 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR Payments. CHECK IF THE NAME IS INVALID OR DUPLICATED. **
CREATE OR REPLACE TABLE Payments (
    PaymentID INT IDENTITY(1,1) ORDER PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders (OrderID),
    PaymentDate TIMESTAMP_NTZ(3) DEFAULT CURRENT_TIMESTAMP() :: TIMESTAMP,
    PaymentMethod VARCHAR(50)
                              !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    AmountPaid DECIMAL(18,2) NOT NULL,
    Status VARCHAR(50)
                       !!!RESOLVE EWI!!! /*** SSC-EWI-0035 - CHECK STATEMENT NOT SUPPORTED ***/!!!
 CHECK (Status IN ('Completed', 'Pending', 'Failed'))
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
;