
CREATE OR REPLACE PROCEDURE sp_AddProduct (PRODUCTNAME STRING, CATEGORY STRING, QUANTITYINSTOCK INT, REORDERLEVEL INT, PRICE DECIMAL(18,2))
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
BEGIN
INSERT INTO Inventory (ProductName, Category, QuantityInStock, ReorderLevel, Price, LastUpdated)
VALUES (PRODUCTNAME, CATEGORY, QUANTITYINSTOCK, REORDERLEVEL, PRICE, CURRENT_TIMESTAMP() :: TIMESTAMP);
END;
CREATE PROCEDURE sp_UpdateInventory
    @ProductID INT,
    @NewQuantity INT
AS
BEGIN
    UPDATE Inventory
    SET QuantityInStock = @NewQuantity, LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
END;
CREATE PROCEDURE sp_PlaceOrder
    @CustomerID INT,
    @OrderDate DATE,
    @TotalAmount DECIMAL(18,2),
    @OrderStatus NVARCHAR(50)
AS
BEGIN
    INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status)
    VALUES (@CustomerID, @OrderDate, @TotalAmount, @OrderStatus);
END;
CREATE PROCEDURE sp_UpdateOrderStatus
    @OrderID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    UPDATE Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;
END;
CREATE PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT OrderID, OrderDate, Status, TotalAmount
    FROM Orders
    WHERE CustomerID = @CustomerID
    ORDER BY OrderDate DESC;
END;
CREATE PROCEDURE sp_RecordSupplierDelivery
    @SupplierID INT,
    @ProductID INT,
    @QuantityDelivered INT,
    @DeliveryDate DATE
AS
BEGIN
    INSERT INTO SupplierDeliveries (SupplierID, ProductID, QuantityDelivered, DeliveryDate)
    VALUES (@SupplierID, @ProductID, @QuantityDelivered, @DeliveryDate);
    UPDATE Inventory
    SET QuantityInStock = QuantityInStock + @QuantityDelivered, LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
END;
CREATE PROCEDURE sp_CalculateSupplierPerformance
    @SupplierID INT
AS
BEGIN
    SELECT SupplierID, COUNT(PurchaseOrderID) AS TotalOrders,
           AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
    FROM PurchaseOrders
    WHERE SupplierID = @SupplierID
    GROUP BY SupplierID;
END;
CREATE PROCEDURE sp_CreateShipment
    @OrderID INT,
    @Carrier NVARCHAR(100),
    @TrackingNumber NVARCHAR(50),
    @EstimatedDeliveryDate DATE
AS
BEGIN
    INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShipmentDate, EstimatedDeliveryDate, Status)
    VALUES (@OrderID, @Carrier, @TrackingNumber, GETDATE(), @EstimatedDeliveryDate, 'Shipped');
    UPDATE Orders
    SET Status = 'Shipped'
    WHERE OrderID = @OrderID;
END;
CREATE PROCEDURE sp_GetLowStockItems
AS
BEGIN
    SELECT ProductID, ProductName, QuantityInStock, ReorderLevel
    FROM Inventory
    WHERE QuantityInStock < ReorderLevel;
END;
CREATE PROCEDURE sp_GetHighValueCustomers
    @MinSpent DECIMAL(18,2)
AS
BEGIN
    SELECT CustomerID, CustomerName, SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID, CustomerName
    HAVING SUM(TotalAmount) > @MinSpent;
END;
CREATE PROCEDURE spGetEmployee
As
BEGIN
  SELECT Name,Gender, DOB FROM Employee
END
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB
  FROM Employee
  ORDER BY Name
END
EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'
ALTER PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  RETURN 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
	END;
$$;;
CREATE OR REPLACE PROCEDURE spGetEmployeesByGenderAndDepartment (GENDER STRING, DEPTID INT)
	RETURNS TABLE()
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
ProcedureResultSet RESULTSET;
BEGIN
BlockResultSet1 := 'RESULTSET_' || REPLACE(UPPER(UUID_STRING()), '-', '_');
CREATE OR REPLACE TEMPORARY TABLE IDENTIFIER(BlockResultSet1) AS
    SELECT
    Name,
    Gender,
    DOB,
    DeptID
    FROM
    Employee
    WHERE
    Gender = GENDER
    AND DeptID = DEPTID;
return_arr := array_append(return_arr, BlockResultSet1);
RETURN TABLE(ProcedureResultSet);
END;
	$$;;
CREATE OR REPLACE PROCEDURE spUpdateEmployeeByID (ID INT, NAME STRING, GENDER STRING, DOB TIMESTAMP_NTZ, DEPTID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
UPDATE Employee
SET
    Name = NAME,
    Gender = GENDER,
    DOB = DOB,
    DeptID = DEPTID
WHERE
    ID = ID;
	END;
$$;;
CREATE OR REPLACE PROCEDURE spGetResult (NO1 INT, NO2 INT, RESULT INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
RESULT INT;
call_results VARIANT;
BEGIN
BEGIN
    RESULT := NO1 + NO2;
END;
call_results := (
    CALL spGetResult( 10, 20, RESULT)
);
RESULT := call_resultsResult;
RETURN @Result;
CREATE PROCEDURE spGetEmployeeCountByGender
  @Gender VARCHAR(30),
  @EmployeeCount INT OUTPUT
AS
BEGIN
  SELECT @EmployeeCount = COUNT(ID)
  FROM    Employee
  WHER     END /*ε*/
RETURN RESULT;
END;
	$$;;
CREATE OR REPLACE PROCEDURE spAddNumber
	(NO1 INT DEFAULT 100, NO2 INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
RESULT INT;
BEGIN
BEGIN
    RESULT := NO1 + NO2;
    RETURN 'The SUM of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
END;
CREATE PROCEDURE spGetEmployee
As
BEGIN
  SELECT Name,Gender, DOB FROM Employee
END
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB
  FROM Employee
  ORDER BY Name
END
EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'
ALTER PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  RETURN 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
END;
	$$;;
CREATE OR REPLACE PROCEDURE spGetEmployeesByGenderAndDepartment (GENDER STRING, DEPTID INT)
	RETURNS TABLE()
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
ProcedureResultSet RESULTSET;
BEGIN
BlockResultSet1 := 'RESULTSET_' || REPLACE(UPPER(UUID_STRING()), '-', '_');
CREATE OR REPLACE TEMPORARY TABLE IDENTIFIER(BlockResultSet1) AS
SELECT
Name,
Gender,
DOB,
DeptID
FROM
Employee
WHERE
Gender = GENDER
AND DeptID = DEPTID;
return_arr := array_append(return_arr, BlockResultSet1);
RETURN TABLE(ProcedureResultSet);
END;
	$$;;
CREATE OR REPLACE PROCEDURE spUpdateEmployeeByID (ID INT, NAME STRING, GENDER STRING, DOB TIMESTAMP_NTZ, DEPTID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
UPDATE Employee
SET
Name = NAME,
Gender = GENDER,
DOB = DOB,
DeptID = DEPTID
WHERE
ID = ID;
	END;
$$;;
CREATE OR REPLACE PROCEDURE spGetResult (NO1 INT, NO2 INT, RESULT INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
RESULT INT;
call_results VARIANT;
BEGIN
BEGIN
RESULT := NO1 + NO2;
END;
call_results := (
CALL spGetResult( 10, 20, RESULT)
);
RESULT := call_resultsResult;
RETURN @Result;
CREATE PROCEDURE spGetEmployeeCountByGender
  @Gender VARCHAR(30),
  @EmployeeCount INT OUTPUT
AS
BEGIN
  SELECT @EmployeeCount = COUNT(ID)
  FROM    Employee
  WHER     END /*ε*/
RETURN RESULT;
END;
	$$;;
CREATE OR REPLACE PROCEDURE spAddNumber
	(NO1 INT DEFAULT 100, NO2 INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
DECLARE
RESULT INT;
BEGIN
BEGIN
RESULT := NO1 + NO2;
RETURN 'The SUM of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
END;
RETURN '';
RETURN '*** Creating Stored Procedures';
END;
	$$;;
CREATE OR REPLACE PROCEDURE dbo.uspSearchCandidateResumes (SEARCHSTRING STRING, USEINFLECTIONAL BOOLEAN DEFAULT 0, USETHESAURUS BOOLEAN DEFAULT 0, LANGUAGE INT DEFAULT 0)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	DECLARE
STRING VARCHAR(1050);
	BEGIN

IF (LANGUAGE = NULL OR LANGUAGE = 0) THEN
BEGIN
SELECT
CAST(
serverproperty('lcid') AS INT)
INTO
LANGUAGE;
END;
END IF;
IF (USETHESAURUS = 1 AND USEINFLECTIONAL = 1) THEN
BEGIN
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN FREETEXTTABLE([HumanResources].[JobCandidate],*, @searchString,LANGUAGE @language) AS KEY_TBL  
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
ELSEIF (USETHESAURUS = 1) THEN
BEGIN
SELECT
'FORMSOF(THESAURUS,"' || SEARCHSTRING || '"' || ')'
INTO
STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*, @string,LANGUAGE @language) AS KEY_TBL  
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
ELSEIF (USEINFLECTIONAL = 1) THEN
BEGIN
SELECT
'FORMSOF(INFLECTIONAL,"' || SEARCHSTRING || '"' || ')'
INTO
STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*, @string,LANGUAGE @language) AS KEY_TBL  
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
ELSE
BEGIN
SELECT
'"' || SEARCHSTRING || '"'
INTO
STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*,@string,LANGUAGE @language) AS KEY_TBL  
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
END IF;
	END;
$$;;
