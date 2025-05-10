CREATE TABLE EmployeeDetails (
    EmployeeID INT IDENTITY(1,1) PRIMARY KEY,   
    FullName NVARCHAR(100) NOT NULL,           
    Email VARCHAR(255) UNIQUE,                 
    Phone CHAR(10),                            
    DateOfBirth DATE,                          
    JoiningTime DATETIME,                      
    Salary MONEY,                              
    EmployeeCode UNIQUEIDENTIFIER DEFAULT NEWID(),  
    ProfileImage VARBINARY(MAX),               
    Remarks TEXT                               
);

CREATE TABLE ProductCatalog (
    ProductID INT PRIMARY KEY,
    ProductName NVARCHAR(100),
    ProductSpecs NVARCHAR(MAX)
);	

CREATE TABLE EmployeeRecords (
    EmployeeID INT PRIMARY KEY,
    FullName NVARCHAR(100),
    EmployeeData XML
);

CREATE TABLE LocationInfo (
    LocationID INT PRIMARY KEY,
    LocationName NVARCHAR(100),
    GeoCoordinates GEOGRAPHY
);	

CREATE TABLE UserStatus (
    UserID INT PRIMARY KEY,
    UserName NVARCHAR(100),
    IsActive BIT
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    AmountPaid DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Completed', 'Pending', 'Failed'))
);

CREATE TABLE OrderDetails (
    OrderDetailID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(10,2) NOT NULL,
    TotalPrice AS (Quantity * UnitPrice) PERSISTED
);

CREATE TABLE Suppliers (
    SupplierID INT IDENTITY(1,1) PRIMARY KEY,
    SupplierName NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255),
    Phone NVARCHAR(50),
    Email NVARCHAR(255),
    Address NVARCHAR(500),
    City NVARCHAR(100),
    Country NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Products (
    ProductID INT IDENTITY(1,1) PRIMARY KEY,
    ProductName NVARCHAR(255) NOT NULL,
    SupplierID INT FOREIGN KEY REFERENCES Suppliers(SupplierID),
    Category NVARCHAR(100),
    Price DECIMAL(10,2) NOT NULL,
    UnitOfMeasure NVARCHAR(50),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Warehouses (
    WarehouseID INT IDENTITY(1,1) PRIMARY KEY,
    WarehouseName NVARCHAR(255) NOT NULL,
    Location NVARCHAR(255),
    Capacity INT NOT NULL,
    Manager NVARCHAR(255),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Inventory (
    InventoryID INT IDENTITY(1,1) PRIMARY KEY,
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    WarehouseID INT FOREIGN KEY REFERENCES Warehouses(WarehouseID),
    Quantity INT NOT NULL,
    LastUpdated DATETIME DEFAULT GETDATE()
);

CREATE TABLE Customers (
    CustomerID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerName NVARCHAR(255) NOT NULL,
    ContactName NVARCHAR(255),
    Phone NVARCHAR(50),
    Email NVARCHAR(255),
    Address NVARCHAR(500),
    City NVARCHAR(100),
    Country NVARCHAR(100),
    CreatedAt DATETIME DEFAULT GETDATE()
);

CREATE TABLE Orders (
    OrderID INT IDENTITY(1,1) PRIMARY KEY,
    CustomerID INT FOREIGN KEY REFERENCES Customers(CustomerID),
    OrderDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Shipped', 'Delivered', 'Cancelled')),
    TotalAmount DECIMAL(18,2) NOT NULL
);

CREATE TABLE Returns (
    ReturnID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    ProductID INT FOREIGN KEY REFERENCES Products(ProductID),
    Quantity INT NOT NULL,
    ReturnReason NVARCHAR(255),
    ReturnDate DATETIME DEFAULT GETDATE(),
    Status NVARCHAR(50) CHECK (Status IN ('Pending', 'Approved', 'Rejected'))
);

CREATE TABLE Payments (
    PaymentID INT IDENTITY(1,1) PRIMARY KEY,
    OrderID INT FOREIGN KEY REFERENCES Orders(OrderID),
    PaymentDate DATETIME DEFAULT GETDATE(),
    PaymentMethod NVARCHAR(50) CHECK (PaymentMethod IN ('Credit Card', 'PayPal', 'Bank Transfer', 'Cash')),
    AmountPaid DECIMAL(18,2) NOT NULL,
    Status NVARCHAR(50) CHECK (Status IN ('Completed', 'Pending', 'Failed'))
);
