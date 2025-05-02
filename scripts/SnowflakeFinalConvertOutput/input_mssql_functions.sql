
CREATE OR REPLACE FUNCTION dbo.GetTotalOrdersForCustomer (CUSTOMERID INT)
RETURNS INT
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
	WITH CTE1 AS
	(
SELECT
COUNT(*) AS TOTALORDERS FROM
Orders
WHERE
CustomerID = CUSTOMERID
	)
	SELECT
TOTALORDERS
	FROM
CTE0
$$;
CREATE OR REPLACE FUNCTION dbo.ufnGetAccountingStartDate ()
RETURNS TIMESTAMP_NTZ
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
	SELECT
CAST('20030701' AS TIMESTAMP_NTZ)
$$;
CREATE OR REPLACE FUNCTION dbo.ufnGetAccountingEndDate ()
RETURNS TIMESTAMP_NTZ
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
	SELECT
DATEADD(millisecond, -2, CAST('20040701' AS TIMESTAMP_NTZ))
$$;
CREATE FUNCTION dbo.ufnGetContactInformation (PERSONID INT)
RETURNS RETCONTACTINFORMATION TABLE
(
	PersonID INT NOT NULL,
	FirstName VARCHAR(50) NULL,
	LastName VARCHAR(50) NULL,
	JobTitle VARCHAR(50) NULL,
	BusinessEntityType VARCHAR(50) NULL
)
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
BEGIN
	IF @PersonID IS NOT NULL
BEGIN
IF EXISTS(SELECT * FROM [HumanResources].[Employee] e
WHERE e.[BusinessEntityID] = @PersonID)
INSERT INTO @retContactInformation
SELECT @PersonID, p.FirstName, p.LastName, e.[JobTitle], 'Employee'
FROM [HumanResources].[Employee] AS e
INNER JOIN [Person].[Person] p
ON p.[BusinessEntityID] = e.[BusinessEntityID]
WHERE e.[BusinessEntityID] = @PersonID;
IF EXISTS(SELECT * FROM [Purchasing].[Vendor] AS v
INNER JOIN [Person].[BusinessEntityContact] bec
ON bec.[BusinessEntityID] = v.[BusinessEntityID]
WHERE bec.[PersonID] = @PersonID)
INSERT INTO @retContactInformation
SELECT @PersonID, p.FirstName, p.LastName, ct.[Name], 'Vendor Contact'
FROM [Purchasing].[Vendor] AS v
INNER JOIN [Person].[BusinessEntityContact] bec
ON bec.[BusinessEntityID] = v.[BusinessEntityID]
INNER JOIN [Person].ContactType ct
ON ct.[ContactTypeID] = bec.[ContactTypeID]
INNER JOIN [Person].[Person] p
ON p.[BusinessEntityID] = bec.[PersonID]
WHERE bec.[PersonID] = @PersonID;
IF EXISTS(SELECT * FROM [Sales].[Store] AS s
INNER JOIN [Person].[BusinessEntityContact] bec
ON bec.[BusinessEntityID] = s.[BusinessEntityID]
WHERE bec.[PersonID] = @PersonID)
INSERT INTO @retContactInformation
SELECT @PersonID, p.FirstName, p.LastName, ct.[Name], 'Store Contact'
FROM [Sales].[Store] AS s
INNER JOIN [Person].[BusinessEntityContact] bec
ON bec.[BusinessEntityID] = s.[BusinessEntityID]
INNER JOIN [Person].ContactType ct
ON ct.[ContactTypeID] = bec.[ContactTypeID]
INNER JOIN [Person].[Person] p
ON p.[BusinessEntityID] = bec.[PersonID]
WHERE bec.[PersonID] = @PersonID;
IF EXISTS(SELECT * FROM [Person].[Person] AS p
INNER JOIN [Sales].[Customer] AS c
ON c.[PersonID] = p.[BusinessEntityID]
WHERE p.[BusinessEntityID] = @PersonID AND c.[StoreID] IS NULL)
INSERT INTO @retContactInformation
SELECT @PersonID, p.FirstName, p.LastName, NULL, 'Consumer'
FROM [Person].[Person] AS p
INNER JOIN [Sales].[Customer] AS c
ON c.[PersonID] = p.[BusinessEntityID]
WHERE p.[BusinessEntityID] = @PersonID AND c.[StoreID] IS NULL;
END
	RETURN;
END;;
CREATE OR REPLACE FUNCTION dbo.ufnGetProductDealerPrice (PRODUCTID INT, ORDERDATE TIMESTAMP_NTZ)
RETURNS NUMBER(38, 4)
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
WITH CTE1 AS
(
SELECT
0.60
AS DEALERDISCOUNT
),
CTE2 AS
(
SELECT
plph.ListPrice * (
SELECT
DEALERDISCOUNT
FROM
CTE1
) AS DEALERPRICE
FROM
Production.Product p
INNER JOIN
Production.ProductListPriceHistory plph
ON p.ProductID = plph.ProductID
AND p.ProductID = PRODUCTID
AND ORDERDATE BETWEEN plph.StartDate AND COALESCE(plph.EndDate, CAST('99991231' AS TIMESTAMP_NTZ))
)
SELECT
DEALERPRICE
FROM
CTE0
$$;
CREATE OR REPLACE FUNCTION dbo.ufnGetProductListPrice (PRODUCTID INT, ORDERDATE TIMESTAMP_NTZ)
RETURNS NUMBER(38, 4)
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
WITH CTE1 AS
(
SELECT
plph.ListPrice AS LISTPRICE
FROM
Production.Product p
INNER JOIN
Production.ProductListPriceHistory plph
ON p.ProductID = plph.ProductID
AND p.ProductID = PRODUCTID
AND ORDERDATE BETWEEN plph.StartDate AND COALESCE(plph.EndDate, CAST('99991231' AS TIMESTAMP_NTZ))
)
SELECT
LISTPRICE
FROM
CTE0
$$;
CREATE OR REPLACE FUNCTION dbo.ufnGetProductStandardCost (PRODUCTID INT, ORDERDATE TIMESTAMP_NTZ)
RETURNS NUMBER(38, 4)
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
WITH CTE1 AS
(
SELECT
pch.StandardCost AS STANDARDCOST
FROM
Production.Product p
INNER JOIN
Production.ProductCostHistory pch
ON p.ProductID = pch.ProductID
AND p.ProductID = PRODUCTID
AND ORDERDATE BETWEEN pch.StartDate AND COALESCE(pch.EndDate, CAST('99991231' AS TIMESTAMP_NTZ))
)
SELECT
STANDARDCOST
FROM
CTE0
$$;
CREATE OR REPLACE FUNCTION dbo.ufnGetStock (PRODUCTID INT)
RETURNS INT
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
WITH CTE1 AS
(
SELECT
SUM(p.Quantity) AS RET
FROM
Production.ProductInventory p
WHERE
p.ProductID = PRODUCTID
AND p.LocationID = '6'
),
CTE2 AS
(
/*    IF (@ret IS NULL)
SET @ret = 0*/
SELECT
null
)
SELECT
RET
FROM
CTE0
$$;
CREATE OR REPLACE PROCEDURE dbo.ufnGetDocumentStatusText (STATUS TINYINT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
DECLARE
RET VARCHAR(16);
BEGIN
CASE (STATUS)
WHEN 1 THEN
RET := 'Pending approval';
WHEN 2 THEN
RET := 'Approved';
WHEN 3 THEN
RET := 'Obsolete';
ELSE
RET := '** Invalid **';
END;
RETURN RET;
END;
$$;
CREATE OR REPLACE PROCEDURE dbo.ufnGetPurchaseOrderStatusText (STATUS TINYINT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
DECLARE
RET VARCHAR(15);
BEGIN
CASE (STATUS)
WHEN 1 THEN
RET := 'Pending';
WHEN 2 THEN
RET := 'Approved';
WHEN 3 THEN
RET := 'Rejected';
WHEN 4 THEN
RET := 'Complete';
ELSE
RET := '** Invalid **';
END;
RETURN RET;
END;
$$;
CREATE OR REPLACE PROCEDURE dbo.ufnGetSalesOrderStatusText (STATUS TINYINT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
DECLARE
RET VARCHAR(15);
BEGIN
CASE (STATUS)
WHEN 1 THEN
RET := 'In process';
WHEN 2 THEN
RET := 'Approved';
WHEN 3 THEN
RET := 'Backordered';
WHEN 4 THEN
RET := 'Rejected';
WHEN 5 THEN
RET := 'Shipped';
WHEN 6 THEN
RET := 'Cancelled';
ELSE
RET := '** Invalid **';
END;
RETURN RET;
END;
$$;
CREATE OR REPLACE FUNCTION dbo.udfBuildISO8601Date (YEAR INT, MONTH INT, DAY INT)
RETURNS TIMESTAMP_NTZ
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
SELECT
TO_TIMESTAMP_NTZ(CAST(YEAR AS VARCHAR) || '-' || LPAD(MONTH, 2, '0') || '-' || LPAD(DAY, 2, '0') || 'T000000', 'MM-DD-YYYY')
$$;
CREATE OR REPLACE PROCEDURE dbo.udfMinimumDate (X TIMESTAMP_NTZ, Y TIMESTAMP_NTZ)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
DECLARE
Z TIMESTAMP_NTZ;
BEGIN
IF (X <= Y) THEN
Z := X;
ELSE
Z := Y;
END IF;
RETURN (Z);
END;
$$;
CREATE OR REPLACE PROCEDURE dbo.udfTwoDigitZeroFill (NUMBER INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
DECLARE
RESULT CHAR(2);
BEGIN
IF (NUMBER > 9) THEN
RESULT := CAST(LEFT(NUMBER, 2) AS CHAR(2));
ELSE
RESULT := CAST(LEFT('0' || CAST(NUMBER AS VARCHAR), 2) AS CHAR(2));
END IF;
RETURN RESULT;
END;
$$;