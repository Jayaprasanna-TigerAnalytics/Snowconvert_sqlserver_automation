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
$$;;
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
$$;;
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
$$;;
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
$$;;
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
$$;;
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
$$;;
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
$$;;
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
$$;;
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
$$;;
