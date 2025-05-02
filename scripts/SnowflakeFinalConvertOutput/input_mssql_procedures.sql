
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
$$;
DECLARE
	NO1 INT;
	NO2 INT;
	BlockResultSet1 VARCHAR;
BEGIN
	CALL spAddTwoNumbers(10, 20);
	CALL spAddTwoNumbers();
	NO1 := 10;
	NO2 := 20;
	CALL spAddTwoNumbers(NO1, NO2);
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
	$$;
END;
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
$$;
DECLARE
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
BEGIN
CALL spUpdateEmployeeByID(3, 'Palak', 'Female', '1994-06-17 105327.060', 3);
CALL spUpdateEmployeeByID(3, 'Female', '1994-06-17 105327.060', 3, 'Palak');
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
	$$;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	---PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	---PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	IF ((EMPLOYEETOTAL IS NULL)) THEN
---PRINT '@EmployeeTotal IS NULL'
	ELSE
---PRINT '@EmployeeTotal IS NOT NULL';
	END IF;
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
	$$;
END;
DECLARE
	NO1 INT;
	NO2 INT;
	BlockResultSet1 VARCHAR;
BEGIN
	CALL spAddTwoNumbers(10, 20);
	CALL spAddTwoNumbers();
	NO1 := 10;
	NO2 := 20;
	CALL spAddTwoNumbers(NO1, NO2);
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
	$$;
END;
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
$$;
DECLARE
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
BEGIN
CALL spUpdateEmployeeByID(3, 'Palak', 'Female', '1994-06-17 105327.060', 3);
CALL spUpdateEmployeeByID(3, 'Female', '1994-06-17 105327.060', 3, 'Palak');
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
	$$;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	---PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	---PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', EMPLOYEETOTAL);
	IF ((EMPLOYEETOTAL IS NULL)) THEN
---PRINT '@EmployeeTotal IS NULL'
	ELSE
---PRINT '@EmployeeTotal IS NOT NULL';
	END IF;
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
	$$;
END;
CREATE OR REPLACE PROCEDURE dbo.uspGetBillOfMaterials (STARTPRODUCTID INT, CHECKDATE TIMESTAMP_NTZ)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

WITH BOM_cte (
ProductAssemblyID,
ComponentID,
ComponentDesc,
PerAssemblyQty,
StandardCost,
ListPrice,
BOMLevel,
RecursionLevel
)
AS (
SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel, 0
FROM
Production.BillOfMaterials b
INNER JOIN
Production.Product p
ON b.ComponentID = p.ProductID
WHERE
b.ProductAssemblyID = STARTPRODUCTID
AND CHECKDATE >= b.StartDate
AND CHECKDATE <= NVL(b.EndDate, CHECKDATE)
UNION ALL
SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel,
RecursionLevel + 1
FROM
BOM_cte cte
INNER JOIN
Production.BillOfMaterials b
ON b.ProductAssemblyID = cte.ComponentID
INNER JOIN
Production.Product p
ON b.ComponentID = p.ProductID
WHERE
CHECKDATE >= b.StartDate
AND CHECKDATE <= NVL(b.EndDate, CHECKDATE)
)
SELECT
b.ProductAssemblyID,
b.ComponentID,
b.ComponentDesc,
SUM(b.PerAssemblyQty) AS TotalQuantity,
b.StandardCost,
b.ListPrice,
b.BOMLevel,
b.RecursionLevel
FROM
BOM_cte b
GROUP BY
b.ComponentID,
b.ComponentDesc,
b.ProductAssemblyID,
b.BOMLevel,
b.RecursionLevel,
b.StandardCost,
b.ListPrice
ORDER BY b.BOMLevel, b.ProductAssemblyID, b.ComponentID;
	END;
$$;
CREATE OR REPLACE PROCEDURE dbo.uspGetEmployeeManagers (BUSINESSENTITYID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

WITH EMP_cte (
BusinessEntityID,
OrganizationNode,
FirstName,
LastName,
JobTitle,
RecursionLevel
)
AS (
SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
e.JobTitle, 0
FROM
HumanResources.Employee e
	INNER JOIN
Person.Person as p
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE
e.BusinessEntityID = BUSINESSENTITYID
UNION ALL
SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
e.JobTitle,
RecursionLevel + 1
FROM
HumanResources.Employee e
INNER JOIN
EMP_cte
ON e.OrganizationNode =
EMP_cte.OrganizationNode.GetAncestor(1)
INNER JOIN
Person.Person p
ON p.BusinessEntityID = e.BusinessEntityID
)
SELECT
EMP_cte.RecursionLevel,
EMP_cte.BusinessEntityID,
EMP_cte.FirstName,
EMP_cte.LastName,
EMP_cte.OrganizationNode.ToString() AS OrganizationNode,
p.FirstName AS "ManagerFirstName",
p.LastName AS "ManagerLastName"
FROM
EMP_cte
INNER JOIN
HumanResources.Employee e
ON
EMP_cte.OrganizationNode.GetAncestor(1) = e.OrganizationNode
INNER JOIN
Person.Person p
ON p.BusinessEntityID = e.BusinessEntityID
ORDER BY RecursionLevel,
EMP_cte.OrganizationNode.ToString();
	END;
$$;
CREATE OR REPLACE PROCEDURE dbo.uspGetManagerEmployees (BUSINESSENTITYID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

WITH EMP_cte (
BusinessEntityID,
OrganizationNode,
FirstName,
LastName,
RecursionLevel
)
AS (
SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName, 0
FROM
HumanResources.Employee e
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
WHERE
e.BusinessEntityID = BUSINESSENTITYID
UNION ALL
SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
RecursionLevel + 1
FROM
HumanResources.Employee e
INNER JOIN
EMP_cte
ON
e.OrganizationNode.GetAncestor(1) = EMP_cte.OrganizationNode
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
)
SELECT
EMP_cte.RecursionLevel,
EMP_cte.OrganizationNode.ToString() as OrganizationNode,
p.FirstName AS "ManagerFirstName",
p.LastName AS "ManagerLastName",
EMP_cte.BusinessEntityID,
EMP_cte.FirstName,
EMP_cte.LastName
FROM
EMP_cte
INNER JOIN
HumanResources.Employee e
ON
EMP_cte.OrganizationNode.GetAncestor(1) = e.OrganizationNode
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
ORDER BY RecursionLevel,
EMP_cte.OrganizationNode.ToString();
	END;
$$;
CREATE OR REPLACE PROCEDURE dbo.uspGetWhereUsedProductID (STARTPRODUCTID INT, CHECKDATE TIMESTAMP_NTZ)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

WITH BOM_cte (
ProductAssemblyID,
ComponentID,
ComponentDesc,
PerAssemblyQty,
StandardCost,
ListPrice,
BOMLevel,
RecursionLevel
)
AS (
SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel, 0
FROM
Production.BillOfMaterials b
INNER JOIN
Production.Product p
ON b.ProductAssemblyID = p.ProductID
WHERE
b.ComponentID = STARTPRODUCTID
AND CHECKDATE >= b.StartDate
AND CHECKDATE <= NVL(b.EndDate, CHECKDATE)
UNION ALL
SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel,
RecursionLevel + 1
FROM
BOM_cte cte
INNER JOIN
Production.BillOfMaterials b
ON cte.ProductAssemblyID = b.ComponentID
INNER JOIN
Production.Product p
ON b.ProductAssemblyID = p.ProductID
WHERE
CHECKDATE >= b.StartDate
AND CHECKDATE <= NVL(b.EndDate, CHECKDATE)
)
SELECT
b.ProductAssemblyID,
b.ComponentID,
b.ComponentDesc,
SUM(b.PerAssemblyQty) AS TotalQuantity,
b.StandardCost,
b.ListPrice,
b.BOMLevel,
b.RecursionLevel
FROM
BOM_cte b
GROUP BY
b.ComponentID,
b.ComponentDesc,
b.ProductAssemblyID,
b.BOMLevel,
b.RecursionLevel,
b.StandardCost,
b.ListPrice
ORDER BY b.BOMLevel, b.ProductAssemblyID, b.ComponentID;
	END;
$$;
CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeeHireInfo (BUSINESSENTITYID INT, JOBTITLE STRING, HIREDATE TIMESTAMP_NTZ, RATECHANGEDATE TIMESTAMP_NTZ, RATE NUMBER(38, 4), PAYFREQUENCY TINYINT, CURRENTFLAG VARIANT )
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

BEGIN
BEGIN TRANSACTION;
UPDATE HumanResources.Employee
SET
JobTitle = JOBTITLE
,
HireDate = HIREDATE
,
CurrentFlag = CURRENTFLAG
WHERE
BusinessEntityID = BUSINESSENTITYID;
INSERT INTO HumanResources.EmployeePayHistory (BusinessEntityID, RateChangeDate, Rate, PayFrequency)
VALUES (BUSINESSENTITYID, RATECHANGEDATE, RATE, PAYFREQUENCY);
COMMIT;
EXCEPTION
WHEN OTHER THEN
IF (TRANCOUNT > 0) THEN
BEGIN
  ROLLBACK;
END;
END IF;
CALL dbo.uspLogError();
END;
	END;
$$;
CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeeLogin (BUSINESSENTITYID INT, ORGANIZATIONNODE TEXT, LOGINID STRING, JOBTITLE STRING, HIREDATE TIMESTAMP_NTZ, CURRENTFLAG VARIANT )
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

BEGIN
UPDATE HumanResources.Employee
SET
OrganizationNode = ORGANIZATIONNODE
    ,
LoginID = LOGINID
    ,
JobTitle = JOBTITLE
    ,
HireDate = HIREDATE
    ,
CurrentFlag = CURRENTFLAG
WHERE
BusinessEntityID = BUSINESSENTITYID;
EXCEPTION
WHEN OTHER THEN
CALL dbo.uspLogError();
END;
	END;
$$;
CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeePersonalInfo (BUSINESSENTITYID INT, NATIONALIDNUMBER STRING, BIRTHDATE TIMESTAMP_NTZ, MARITALSTATUS STRING, GENDER STRING)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

BEGIN
UPDATE HumanResources.Employee
SET
NationalIDNumber = NATIONALIDNUMBER
    ,
BirthDate = BIRTHDATE
    ,
MaritalStatus = MARITALSTATUS
    ,
Gender = GENDER
WHERE
BusinessEntityID = BUSINESSENTITYID;
EXCEPTION
WHEN OTHER THEN
CALL dbo.uspLogError();
END;
	END;
$$;
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
$$;
SET NOCOUNT OFF;
CREATE OR REPLACE PROCEDURE dbo.uspPrintError ()
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

RETURN 'Error ' + CONVERT(varchar(50), ERROR_NUMBER()) +
', Severity ' + CONVERT(varchar(5), ERROR_SEVERITY()) +
', State ' + CONVERT(varchar(5), ERROR_STATE()) +
', Procedure ' + ISNULL(ERROR_PROCEDURE(), '-') +
', Line ' + CONVERT(varchar(5), ERROR_LINE());
RETURN ERROR_MESSAGE();
	END;
$$;
CREATE OR REPLACE PROCEDURE dbo.uspLogError (ERRORLOGID INT DEFAULT 0
)
RETURNS VARIANT
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN

ERRORLOGID := 0;
BEGIN
IF (
ERROR_NUMBER() IS NULL) THEN
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', 'ERRORLOGID', ERRORLOGID);
END IF;
IF (CURRENT_TRANSACTION()   = -1) THEN
BEGIN
RETURN 'Cannot log error since the current transaction is in an uncommittable state. '
    + 'Rollback the transaction before executing uspLogError in order to successfully log error information.';
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', 'ERRORLOGID', ERRORLOGID);
END;
END IF;
INSERT INTO dbo.ErrorLog (UserName, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
VALUES
(CAST(CURRENT_USER AS VARCHAR(128)),
ERROR_NUMBER(),
ERROR_SEVERITY(),
ERROR_STATE(),
ERROR_PROCEDURE(),
ERROR_LINE(), SQLERRM 
);
ERRORLOGID := IDENTITY;
EXCEPTION
WHEN OTHER THEN
RETURN 'An error occurred in stored procedure uspLogError: ';
CALL dbo.uspPrintError();
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', -1, 'ERRORLOGID', ERRORLOGID);
END;
	END;
$$;