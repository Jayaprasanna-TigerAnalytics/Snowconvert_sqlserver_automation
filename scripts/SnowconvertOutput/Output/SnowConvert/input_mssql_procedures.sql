
--Procedure to Add a New Product to Inventory
--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "SupplierDeliveries", "PurchaseOrders", "Employee" **
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
			VALUES (:PRODUCTNAME, :CATEGORY, :QUANTITYINSTOCK, :REORDERLEVEL, :PRICE, CURRENT_TIMESTAMP() :: TIMESTAMP);
		END;


		--Procedure to Update Inventory Levels
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CREATE PROCEDURE' NODE ***/!!!
		CREATE PROCEDURE sp_UpdateInventory
    @ProductID INT,
    @NewQuantity INT
AS
BEGIN
    UPDATE Inventory
    SET QuantityInStock = @NewQuantity, LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
END;


--Procedure to Place a New Customer Order

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


--Procedure to Update Order Status

CREATE PROCEDURE sp_UpdateOrderStatus
    @OrderID INT,
    @NewStatus NVARCHAR(50)
AS
BEGIN
    UPDATE Orders
    SET Status = @NewStatus
    WHERE OrderID = @OrderID;
END;


--Procedure to Get Orders for a Specific Customer

CREATE PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT OrderID, OrderDate, Status, TotalAmount
    FROM Orders
    WHERE CustomerID = @CustomerID
    ORDER BY OrderDate DESC;
END;


--Procedure to Record a Supplier Delivery

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


--Procedure to Calculate Supplier Performance

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


--Procedure to Generate a Shipment for an Order

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


--Procedure to Get Low Stock Items

CREATE PROCEDURE sp_GetLowStockItems
AS
BEGIN
    SELECT ProductID, ProductName, QuantityInStock, ReorderLevel
    FROM Inventory
    WHERE QuantityInStock < ReorderLevel;
END;


--Procedure to Get High-Value Customers

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

-- How to change the body of a stored procedure
-- User Alter procedure to change the body
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB
  FROM Employee
  ORDER BY Name
END

-- To change the procedure name from spGetEmployee to spGetEmployee1
-- Use sp_rename system defined stored procedure
EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'


-- Create a Procedure
ALTER PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  PRINT 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
	END;
$$;

DECLARE

	-- OR calling the procedure by declaring two variables as shown below
	NO1 INT;
	NO2 INT;
	BlockResultSet1 VARCHAR;
BEGIN

	-- Calling the procedure:
	CALL spAddTwoNumbers(10, 20);
-- OR 
	CALL spAddTwoNumbers();
	NO1 := 10;
	NO2 := 20;
	CALL spAddTwoNumbers(:NO1, :NO2);
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
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
			CREATE OR REPLACE TEMPORARY TABLE IDENTIFIER(:BlockResultSet1) AS
    SELECT
    Name,
    Gender,
    DOB,
    DeptID
    FROM
    Employee
    WHERE
    Gender = :GENDER
    AND DeptID = :DEPTID;
			return_arr := array_append(return_arr, :BlockResultSet1);
			RETURN TABLE(ProcedureResultSet);
		END;
	$$;
END;

-- Create a Procedure
--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
CREATE OR REPLACE PROCEDURE spUpdateEmployeeByID (ID INT, NAME STRING, GENDER STRING, DOB TIMESTAMP_NTZ(3), DEPTID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		UPDATE Employee
			SET
    Name = :NAME,
    Gender = :GENDER,
    DOB = :DOB,
    DeptID = :DEPTID
		WHERE
    ID = :ID;
	END;
$$;

DECLARE
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
BEGIN
	-- Executing the Procedure
	-- If you are not specifying the Parameter Names then the order is important
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "spUpdateEmployeeByID" **
	CALL spUpdateEmployeeByID(3, 'Palak', 'Female', '1994-06-17 10:53:27.060', 3);
-- If you are specifying the Parameter Names then order is not mandatory
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "spUpdateEmployeeByID" **
	CALL spUpdateEmployeeByID(3, 'Female', '1994-06-17 10:53:27.060', 3, 'Palak');
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
	CREATE OR REPLACE PROCEDURE spGetResult (NO1 INT, NO2 INT, RESULT INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
		DECLARE

			-- To Execute Procedure
			RESULT INT;
			call_results VARIANT;
		BEGIN
			BEGIN
    RESULT := :NO1 + :NO2;
			END;
			 
			call_results := (
    CALL spGetResult( 10, 20, :RESULT)
			);
			RESULT := :call_results:Result;
			!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
			PRINT @Result;
			!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CREATE PROCEDURE' NODE ***/!!!

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
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
	PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
	PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	IF ((:EMPLOYEETOTAL IS NULL)) THEN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT '@EmployeeTotal IS NULL'
	ELSE
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT '@EmployeeTotal IS NOT NULL';
	END IF;
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
	CREATE OR REPLACE PROCEDURE spAddNumber
	!!!RESOLVE EWI!!! /*** SSC-EWI-0002 - DEFAULT PARAMETERS MAY NEED TO BE REORDERED. SNOWFLAKE ONLY SUPPORTS DEFAULT PARAMETERS AT THE END OF THE PARAMETERS DECLARATIONS ***/!!!
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
     
    RESULT := :NO1 + :NO2;
    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
    PRINT 'The SUM of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
			END;

			-- Executing the above procedure:
-- 1. EXEC spAddNumber 3200, 25
-- 2. EXEC spAddNumber @No1=200, @No2=25
-- 3. EXEC spAddNumber @No1=DEFAULT, @No2=25
-- 4. EXEC spAddNumber @No2=25;
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CREATE PROCEDURE' NODE ***/!!!
CREATE PROCEDURE spGetEmployee
As
BEGIN
  SELECT Name,Gender, DOB FROM Employee
END

-- How to change the body of a stored procedure
-- User Alter procedure to change the body
ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB
  FROM Employee
  ORDER BY Name
END

-- To change the procedure name from spGetEmployee to spGetEmployee1
-- Use sp_rename system defined stored procedure
EXEC sp_rename 'spGetEmployee', 'spGetEmployee1'


-- Create a Procedure
ALTER PROCEDURE spAddTwoNumbers(@no1 INT, @no2 INT)
AS
BEGIN
  DECLARE @Result INT
  SET @Result = @no1 + @no2
  PRINT 'RESULT IS: '+ CAST(@Result AS VARCHAR)
END
		END;
	$$;
END;

DECLARE

	-- OR calling the procedure by declaring two variables as shown below
	NO1 INT;
	NO2 INT;
	BlockResultSet1 VARCHAR;
BEGIN

	-- Calling the procedure:
	CALL spAddTwoNumbers(10, 20);
-- OR 
	CALL spAddTwoNumbers();
	NO1 := 10;
	NO2 := 20;
	CALL spAddTwoNumbers(:NO1, :NO2);
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
	--** SSC-FDM-0019 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR spGetEmployeesByGenderAndDepartment. CHECK IF THE NAME IS INVALID OR DUPLICATED. **
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
CREATE OR REPLACE TEMPORARY TABLE IDENTIFIER(:BlockResultSet1) AS
SELECT
Name,
Gender,
DOB,
DeptID
FROM
Employee
WHERE
Gender = :GENDER
AND DeptID = :DEPTID;
return_arr := array_append(return_arr, :BlockResultSet1);
RETURN TABLE(ProcedureResultSet);
		END;
	$$;
END;

-- Create a Procedure
--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
--** SSC-FDM-0019 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR spUpdateEmployeeByID. CHECK IF THE NAME IS INVALID OR DUPLICATED. **
CREATE OR REPLACE PROCEDURE spUpdateEmployeeByID (ID INT, NAME STRING, GENDER STRING, DOB TIMESTAMP_NTZ(3), DEPTID INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		UPDATE Employee
SET
Name = :NAME,
Gender = :GENDER,
DOB = :DOB,
DeptID = :DEPTID
		WHERE
ID = :ID;
	END;
$$;

DECLARE
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
	EMPLOYEETOTAL INT;
BEGIN
	-- Executing the Procedure
	-- If you are not specifying the Parameter Names then the order is important
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "spUpdateEmployeeByID" **
	CALL spUpdateEmployeeByID(3, 'Palak', 'Female', '1994-06-17 10:53:27.060', 3);
-- If you are specifying the Parameter Names then order is not mandatory
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "spUpdateEmployeeByID" **
	CALL spUpdateEmployeeByID(3, 'Female', '1994-06-17 10:53:27.060', 3, 'Palak');
	--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
	--** SSC-FDM-0019 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR spGetResult. CHECK IF THE NAME IS INVALID OR DUPLICATED. **
	CREATE OR REPLACE PROCEDURE spGetResult (NO1 INT, NO2 INT, RESULT INT)
	RETURNS VARCHAR
	LANGUAGE SQL
	COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
	EXECUTE AS CALLER
	AS
	$$
		DECLARE

-- To Execute Procedure
RESULT INT;
call_results VARIANT;
		BEGIN
BEGIN
RESULT := :NO1 + :NO2;
END;
 
call_results := (
CALL spGetResult( 10, 20, :RESULT)
);
RESULT := :call_results:Result;
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT @Result;
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CREATE PROCEDURE' NODE ***/!!!

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
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
	PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'Print' NODE ***/!!!
	PRINT @EmployeeTotal;
	CALL spGetEmployeeCountByGender('Male', :EMPLOYEETOTAL);
	IF ((:EMPLOYEETOTAL IS NULL)) THEN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT '@EmployeeTotal IS NULL'
	ELSE
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT '@EmployeeTotal IS NOT NULL';
	END IF;
	--** SSC-FDM-0019 - SEMANTIC INFORMATION COULD NOT BE LOADED FOR spAddNumber. CHECK IF THE NAME IS INVALID OR DUPLICATED. **
	CREATE OR REPLACE PROCEDURE spAddNumber
	!!!RESOLVE EWI!!! /*** SSC-EWI-0002 - DEFAULT PARAMETERS MAY NEED TO BE REORDERED. SNOWFLAKE ONLY SUPPORTS DEFAULT PARAMETERS AT THE END OF THE PARAMETERS DECLARATIONS ***/!!!
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
 
RESULT := :NO1 + :NO2;
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT 'The SUM of the 2 Numbers is: '+ CAST(@Result AS VARCHAR)
END;

-- Executing the above procedure:
-- 1. EXEC spAddNumber 3200, 25
-- 2. EXEC spAddNumber @No1=200, @No2=25
-- 3. EXEC spAddNumber @No1=DEFAULT, @No2=25
-- 4. EXEC spAddNumber @No2=25;


-- ******************************************************
-- Create stored procedures
-- ******************************************************
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT '';
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT '*** Creating Stored Procedures';
		END;
	$$;
END;

CREATE OR REPLACE PROCEDURE dbo.uspGetBillOfMaterials (STARTPRODUCTID INT, CHECKDATE TIMESTAMP_NTZ(3))
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;

		-- Use recursive query to generate a multi-level Bill of Material (i.e. all level 1 
		-- components of a level 0 assembly, all level 2 components of a level 1 assembly)
		-- The CheckDate eliminates any components that are no longer used in the product on this date.
		--** SSC-PRF-TS0001 - PERFORMANCE WARNING - RECURSION FOR CTE NOT CHECKED. MIGHT REQUIRE RECURSIVE KEYWORD **
		WITH BOM_cte (
ProductAssemblyID,
ComponentID,
ComponentDesc,
PerAssemblyQty,
StandardCost,
ListPrice,
BOMLevel,
RecursionLevel
		) -- CTE name and columns
		AS (
		    SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel, 0 -- Get the initial list of components for the bike assembly
		    FROM
Production.BillOfMaterials b
		        INNER JOIN
Production.Product p
		        ON b.ComponentID = p.ProductID
		    WHERE
b.ProductAssemblyID = :STARTPRODUCTID
		        AND :CHECKDATE >= b.StartDate
		        AND :CHECKDATE <= NVL(b.EndDate, :CHECKDATE)
		    UNION ALL
		    SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel,
RecursionLevel + 1 -- Join recursive member to anchor
		    FROM
BOM_cte cte
		        INNER JOIN
Production.BillOfMaterials b
		        ON b.ProductAssemblyID = cte.ComponentID
		        INNER JOIN
Production.Product p
		        ON b.ComponentID = p.ProductID
		    WHERE
:CHECKDATE >= b.StartDate
		        AND :CHECKDATE <= NVL(b.EndDate, :CHECKDATE)
		    )
		-- Outer select from the CTE
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
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;

		-- Use recursive query to list out all Employees required for a particular Manager
		--** SSC-PRF-TS0001 - PERFORMANCE WARNING - RECURSION FOR CTE NOT CHECKED. MIGHT REQUIRE RECURSIVE KEYWORD **
		WITH EMP_cte (
BusinessEntityID,
OrganizationNode,
FirstName,
LastName,
JobTitle,
RecursionLevel
		) -- CTE name and columns
		AS (
		    SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
e.JobTitle, 0 -- Get the initial Employee
		    FROM
HumanResources.Employee e
	INNER JOIN
Person.Person as p
	ON p.BusinessEntityID = e.BusinessEntityID
		    WHERE
e.BusinessEntityID = :BUSINESSENTITYID
		    UNION ALL
		    SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
e.JobTitle,
RecursionLevel + 1 -- Join recursive member to anchor
		    FROM
HumanResources.Employee e
		        INNER JOIN
EMP_cte
		        ON e.OrganizationNode =
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetAncestor' NODE ***/!!!
EMP_cte.OrganizationNode.GetAncestor(1)
		        INNER JOIN
Person.Person p
		        ON p.BusinessEntityID = e.BusinessEntityID
		)
		-- Join back to Employee to return the manager name 
		SELECT
EMP_cte.RecursionLevel,
EMP_cte.BusinessEntityID,
EMP_cte.FirstName,
EMP_cte.LastName,
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ToString' NODE ***/!!!
EMP_cte.OrganizationNode.ToString() AS OrganizationNode,
p.FirstName AS "ManagerFirstName",
p.LastName AS "ManagerLastName" -- Outer select from the CTE
		FROM
EMP_cte
		    INNER JOIN
HumanResources.Employee e
		    ON
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetAncestor' NODE ***/!!!
EMP_cte.OrganizationNode.GetAncestor(1) = e.OrganizationNode
		    INNER JOIN
Person.Person p
		    ON p.BusinessEntityID = e.BusinessEntityID
		ORDER BY RecursionLevel,
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ToString' NODE ***/!!!
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
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;

		-- Use recursive query to list out all Employees required for a particular Manager
		--** SSC-PRF-TS0001 - PERFORMANCE WARNING - RECURSION FOR CTE NOT CHECKED. MIGHT REQUIRE RECURSIVE KEYWORD **
		WITH EMP_cte (
BusinessEntityID,
OrganizationNode,
FirstName,
LastName,
RecursionLevel
		) -- CTE name and columns
		AS (
		    SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName, 0 -- Get the initial list of Employees for Manager n
		    FROM
HumanResources.Employee e
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
		    WHERE
e.BusinessEntityID = :BUSINESSENTITYID
		    UNION ALL
		    SELECT
e.BusinessEntityID,
e.OrganizationNode,
p.FirstName,
p.LastName,
RecursionLevel + 1 -- Join recursive member to anchor
		    FROM
HumanResources.Employee e
		        INNER JOIN
EMP_cte
		        ON
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetAncestor' NODE ***/!!!
e.OrganizationNode.GetAncestor(1) = EMP_cte.OrganizationNode
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
		    )
		-- Join back to Employee to return the manager name 
		SELECT
EMP_cte.RecursionLevel,
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ToString' NODE ***/!!!
EMP_cte.OrganizationNode.ToString() as OrganizationNode,
p.FirstName AS "ManagerFirstName",
p.LastName AS "ManagerLastName",
EMP_cte.BusinessEntityID,
EMP_cte.FirstName,
EMP_cte.LastName -- Outer select from the CTE
		FROM
EMP_cte
		    INNER JOIN
HumanResources.Employee e
		    ON
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'GetAncestor' NODE ***/!!!
EMP_cte.OrganizationNode.GetAncestor(1) = e.OrganizationNode
	INNER JOIN
Person.Person p
	ON p.BusinessEntityID = e.BusinessEntityID
		ORDER BY RecursionLevel,
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ToString' NODE ***/!!!
		EMP_cte.OrganizationNode.ToString();
	END;
$$;

CREATE OR REPLACE PROCEDURE dbo.uspGetWhereUsedProductID (STARTPRODUCTID INT, CHECKDATE TIMESTAMP_NTZ(3))
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;

		--Use recursive query to generate a multi-level Bill of Material (i.e. all level 1 components of a level 0 assembly, all level 2 components of a level 1 assembly)
		--** SSC-PRF-TS0001 - PERFORMANCE WARNING - RECURSION FOR CTE NOT CHECKED. MIGHT REQUIRE RECURSIVE KEYWORD **
		WITH BOM_cte (
ProductAssemblyID,
ComponentID,
ComponentDesc,
PerAssemblyQty,
StandardCost,
ListPrice,
BOMLevel,
RecursionLevel
		) -- CTE name and columns
		AS (
		    SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel, 0 -- Get the initial list of components for the bike assembly
		    FROM
Production.BillOfMaterials b
		        INNER JOIN
Production.Product p
		        ON b.ProductAssemblyID = p.ProductID
		    WHERE
b.ComponentID = :STARTPRODUCTID
		        AND :CHECKDATE >= b.StartDate
		        AND :CHECKDATE <= NVL(b.EndDate, :CHECKDATE)
		    UNION ALL
		    SELECT
b.ProductAssemblyID,
b.ComponentID,
p.Name,
b.PerAssemblyQty,
p.StandardCost,
p.ListPrice,
b.BOMLevel,
RecursionLevel + 1 -- Join recursive member to anchor
		    FROM
BOM_cte cte
		        INNER JOIN
Production.BillOfMaterials b
		        ON cte.ProductAssemblyID = b.ComponentID
		        INNER JOIN
Production.Product p
		        ON b.ProductAssemblyID = p.ProductID
		    WHERE
:CHECKDATE >= b.StartDate
		        AND :CHECKDATE <= NVL(b.EndDate, :CHECKDATE)
		    )
		-- Outer select from the CTE
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

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[dbo].[Flag]" **
CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeeHireInfo (BUSINESSENTITYID INT, JOBTITLE STRING, HIREDATE TIMESTAMP_NTZ(3), RATECHANGEDATE TIMESTAMP_NTZ(3), RATE NUMBER(38, 4), PAYFREQUENCY TINYINT, CURRENTFLAG VARIANT /*** SSC-FDM-TS0015 - DATA TYPE DBO.FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;
		BEGIN
BEGIN TRANSACTION;
		    UPDATE HumanResources.Employee
		    SET
JobTitle = :JOBTITLE
		        ,
HireDate = :HIREDATE
		        ,
CurrentFlag = :CURRENTFLAG
		    WHERE
BusinessEntityID = :BUSINESSENTITYID;
		    INSERT INTO HumanResources.EmployeePayHistory (BusinessEntityID, RateChangeDate, Rate, PayFrequency)
		    VALUES (:BUSINESSENTITYID, :RATECHANGEDATE, :RATE, :PAYFREQUENCY);
COMMIT;
		EXCEPTION
WHEN OTHER THEN
-- Rollback any active or uncommittable transactions before
-- inserting information in the ErrorLog
IF (:TRANCOUNT > 0) THEN
BEGIN
  !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ROLLBACK TRANSACTION' NODE ***/!!!
  ROLLBACK TRANSACTION;
END;
END IF;
CALL dbo.uspLogError();
		END;
	END;
$$;

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[dbo].[Flag]" **
CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeeLogin (BUSINESSENTITYID INT, ORGANIZATIONNODE TEXT, LOGINID STRING, JOBTITLE STRING, HIREDATE TIMESTAMP_NTZ(3), CURRENTFLAG VARIANT /*** SSC-FDM-TS0015 - DATA TYPE DBO.FLAG IS NOT SUPPORTED IN SNOWFLAKE ***/)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;
		BEGIN
UPDATE HumanResources.Employee
SET
OrganizationNode = :ORGANIZATIONNODE
    ,
LoginID = :LOGINID
    ,
JobTitle = :JOBTITLE
    ,
HireDate = :HIREDATE
    ,
CurrentFlag = :CURRENTFLAG
WHERE
BusinessEntityID = :BUSINESSENTITYID;
		EXCEPTION
WHEN OTHER THEN
CALL dbo.uspLogError();
		END;
	END;
$$;

CREATE OR REPLACE PROCEDURE HumanResources.uspUpdateEmployeePersonalInfo (BUSINESSENTITYID INT, NATIONALIDNUMBER STRING, BIRTHDATE TIMESTAMP_NTZ(3), MARITALSTATUS STRING, GENDER STRING)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;
		BEGIN
UPDATE HumanResources.Employee
SET
NationalIDNumber = :NATIONALIDNUMBER
    ,
BirthDate = :BIRTHDATE
    ,
MaritalStatus = :MARITALSTATUS
    ,
Gender = :GENDER
WHERE
BusinessEntityID = :BUSINESSENTITYID;
		EXCEPTION
WHEN OTHER THEN
CALL dbo.uspLogError();
		END;
	END;
$$;

--A stored procedure which demonstrates integrated full text search
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
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;
		 
		--setting the lcid to the default instance LCID if needed
		IF (:LANGUAGE = NULL OR :LANGUAGE = 0) THEN
BEGIN
SELECT
CAST(
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'serverproperty' NODE ***/!!!
serverproperty('lcid') AS INT)
INTO
:LANGUAGE;
END;
		END IF;

		--FREETEXTTABLE case as inflectional and Thesaurus were required
		IF (:USETHESAURUS = 1 AND :USEINFLECTIONAL = 1) THEN
BEGIN
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN FREETEXTTABLE([HumanResources].[JobCandidate],*, @searchString,LANGUAGE @language) AS KEY_TBL !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'TableValuedFunctionCall' NODE ***/!!!
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
		ELSEIF (:USETHESAURUS = 1) THEN
BEGIN
SELECT
'FORMSOF(THESAURUS,"' || :SEARCHSTRING || '"' || ')'
INTO
:STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*, @string,LANGUAGE @language) AS KEY_TBL !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'TableValuedFunctionCall' NODE ***/!!!
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
		ELSEIF (:USEINFLECTIONAL = 1) THEN
BEGIN
SELECT
'FORMSOF(INFLECTIONAL,"' || :SEARCHSTRING || '"' || ')'
INTO
:STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*, @string,LANGUAGE @language) AS KEY_TBL !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'TableValuedFunctionCall' NODE ***/!!!
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
		--base case, plain CONTAINSTABLE
		ELSE
BEGIN
SELECT
'"' || :SEARCHSTRING || '"'
INTO
:STRING;
SELECT
FT_TBL.JobCandidateID,
KEY_TBL.RANK
FROM
HumanResources.JobCandidate AS FT_TBL
      INNER JOIN CONTAINSTABLE([HumanResources].[JobCandidate],*,@string,LANGUAGE @language) AS KEY_TBL !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'TableValuedFunctionCall' NODE ***/!!!
 ON FT_TBL.JobCandidateID = KEY_TBL.KEY;
END;
		END IF;
	END;
$$;

!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!

SET NOCOUNT OFF;

-- uspPrintError prints error information about the error that caused 
-- execution to jump to the CATCH block of a TRY...CATCH construct. 
-- Should be executed from within the scope of a CATCH block otherwise 
-- it will return without printing any error information.
CREATE OR REPLACE PROCEDURE dbo.uspPrintError ()
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;

		-- Print error information. 
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT 'Error ' + CONVERT(varchar(50), ERROR_NUMBER()) +
		      ', Severity ' + CONVERT(varchar(5), ERROR_SEVERITY()) +
		      ', State ' + CONVERT(varchar(5), ERROR_STATE()) +
		      ', Procedure ' + ISNULL(ERROR_PROCEDURE(), '-') +
		      ', Line ' + CONVERT(varchar(5), ERROR_LINE());
		!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
		PRINT ERROR_MESSAGE();
	END;
$$;

-- uspLogError logs error information in the ErrorLog table about the 
-- error that caused execution to jump to the CATCH block of a 
-- TRY...CATCH construct. This should be executed from within the scope 
-- of a CATCH block otherwise it will return without inserting error 
-- information. 
--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "[dbo].[ErrorLog]" **
CREATE OR REPLACE PROCEDURE dbo.uspLogError (ERRORLOGID INT DEFAULT 0 -- contains the ErrorLogID of the row inserted
)
RETURNS VARIANT
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
-- by uspLogError in the ErrorLog table
AS
$$
	-- contains the ErrorLogID of the row inserted
	BEGIN
		!!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
		SET NOCOUNT ON;
		-- Output parameter value of 0 indicates that error 
		-- information was not logged
		ERRORLOGID := 0;
		BEGIN
-- Return if there is no error information to log
IF (
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_NUMBER' NODE ***/!!!
ERROR_NUMBER() IS NULL) THEN
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', 'ERRORLOGID', :ERRORLOGID);
END IF;
-- Return if inside an uncommittable transaction.
-- Data insertion/modification is not allowed when 
-- a transaction is in an uncommittable state.
IF (CURRENT_TRANSACTION() !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'XACT_STATE' NODE ***/!!! = -1) THEN
BEGIN
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT 'Cannot log error since the current transaction is in an uncommittable state. '
    + 'Rollback the transaction before executing uspLogError in order to successfully log error information.';
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', 'ERRORLOGID', :ERRORLOGID);
END;
END IF;

		    INSERT INTO dbo.ErrorLog (UserName, ErrorNumber, ErrorSeverity, ErrorState, ErrorProcedure, ErrorLine, ErrorMessage)
		    VALUES
		        (CAST(CURRENT_USER AS VARCHAR(128)),
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_NUMBER' NODE ***/!!!
ERROR_NUMBER(),
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_SEVERITY' NODE ***/!!!
ERROR_SEVERITY(),
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_STATE' NODE ***/!!!
ERROR_STATE(),
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_PROCEDURE' NODE ***/!!!
ERROR_PROCEDURE(),
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ERROR_LINE' NODE ***/!!!
ERROR_LINE(), SQLERRM /*** SSC-FDM-TS0023 - ERROR MESSAGE COULD BE DIFFERENT IN SNOWFLAKE ***/
		        );
-- Pass back the ErrorLogID of the row inserted
ERRORLOGID := :IDENTITY;
		EXCEPTION
WHEN OTHER THEN
!!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
PRINT 'An error occurred in stored procedure uspLogError: ';
CALL dbo.uspPrintError();
RETURN OBJECT_CONSTRUCT('SC_RET_VALUE', -1, 'ERRORLOGID', :ERRORLOGID);
		END;
	END;
$$;