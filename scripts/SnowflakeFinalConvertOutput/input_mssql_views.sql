
---PRINT '';
---PRINT '*** Creating Table Views';
    CREATE OR REPLACE VIEW dbo.vDMPrep
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	pc.EnglishProductCategoryName
    ,
	COALESCE(p.ModelName, p.EnglishProductName) AS Model
    ,
	c.CustomerKey
    ,
	s.SalesTerritoryGroup AS Region
    ,CASE
        WHEN Month(CURRENT_TIMESTAMP() :: TIMESTAMP) < Month(c.BirthDate :: TIMESTAMP)
            THEN DateDiff(year, c.BirthDate, CURRENT_TIMESTAMP() :: TIMESTAMP) - 1
        WHEN Month(CURRENT_TIMESTAMP() :: TIMESTAMP) = Month(c.BirthDate :: TIMESTAMP)
        AND Day(CURRENT_TIMESTAMP() :: TIMESTAMP) < Day(c.BirthDate :: TIMESTAMP)
            THEN DateDiff(year, c.BirthDate, CURRENT_TIMESTAMP() :: TIMESTAMP) - 1
        ELSE DateDiff(year, c.BirthDate, CURRENT_TIMESTAMP() :: TIMESTAMP)
    END AS Age
    ,CASE
        WHEN c.YearlyIncome < 40000 THEN 'Low'
        WHEN c.YearlyIncome > 60000 THEN 'High'
        ELSE 'Moderate'
    END AS IncomeGroup
    ,
	d.CalendarYear
    ,
	d.FiscalYear
    ,
	d.MonthNumberOfYear AS Month
    ,
	f.SalesOrderNumber AS OrderNumber
    ,
	f.SalesOrderLineNumber AS LineNumber
    ,
	f.OrderQuantity AS Quantity
    ,
	f.ExtendedAmount AS Amount
FROM
	dbo.FactInternetSales f
INNER JOIN
        dbo.DimDate d
    ON f.OrderDateKey = d.DateKey
INNER JOIN
        dbo.DimProduct p
    ON f.ProductKey = p.ProductKey
INNER JOIN
        dbo.DimProductSubcategory psc
    ON p.ProductSubcategoryKey = psc.ProductSubcategoryKey
INNER JOIN
        dbo.DimProductCategory pc
    ON psc.ProductCategoryKey = pc.ProductCategoryKey
INNER JOIN
        dbo.DimCustomer c
    ON f.CustomerKey = c.CustomerKey
INNER JOIN
        dbo.DimGeography g
    ON c.GeographyKey = g.GeographyKey
INNER JOIN
        dbo.DimSalesTerritory s
    ON g.SalesTerritoryKey = s.SalesTerritoryKey
;
-- SET QUOTED_IDENTIFIER ON;
CREATE OR REPLACE VIEW dbo.vTimeSeries
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
    CASE
        Model
        WHEN 'Mountain-100' THEN 'M200'
        WHEN 'Road-150' THEN 'R250'
        WHEN 'Road-650' THEN 'R750'
        WHEN 'Touring-1000' THEN 'T1000'
        ELSE LEFT(Model, 1) + RIGHT(Model, 3)
    END || ' ' || Region AS ModelRegion
    ,(CAST(CalendarYear AS INTEGER) * 100) + CAST(Month AS INTEGER) AS TimeIndex
    ,
	SUM(Quantity) AS Quantity
    ,
	SUM(Amount) AS Amount
,
	CalendarYear
,
	Month
,
	dbo.udfBuildISO8601Date(CalendarYear, Month, 25) as ReportingDate
FROM
	dbo.vDMPrep
WHERE
	Model IN ('Mountain-100', 'Mountain-200', 'Road-150', 'Road-250',
        'Road-650', 'Road-750', 'Touring-1000')
GROUP BY
    CASE
        Model
        WHEN 'Mountain-100' THEN 'M200'
        WHEN 'Road-150' THEN 'R250'
        WHEN 'Road-650' THEN 'R750'
        WHEN 'Touring-1000' THEN 'T1000'
        ELSE LEFT(Model,1) + RIGHT(Model,3)
    END || ' ' || Region
    ,(CAST(CalendarYear AS INTEGER) * 100) + CAST(Month AS INTEGER)
,
	CalendarYear
,
	Month
,
	dbo.udfBuildISO8601Date(CalendarYear, Month, 25);
-- SET QUOTED_IDENTIFIER ON;
CREATE OR REPLACE VIEW dbo.vTargetMail
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	c.CustomerKey,
	c.GeographyKey,
	c.CustomerAlternateKey,
	c.Title,
	c.FirstName,
	c.MiddleName,
	c.LastName,
	c.NameStyle,
	c.BirthDate,
	c.MaritalStatus,
	c.Suffix,
	c.Gender,
	c.EmailAddress,
	c.YearlyIncome,
	c.TotalChildren,
	c.NumberChildrenAtHome,
	c.EnglishEducation,
	c.SpanishEducation,
	c.FrenchEducation,
	c.EnglishOccupation,
	c.SpanishOccupation,
	c.FrenchOccupation,
	c.HouseOwnerFlag,
	c.NumberCarsOwned,
	c.AddressLine1,
	c.AddressLine2,
	c.Phone,
	c.DateFirstPurchase,
	c.CommuteDistance,
	x.Region,
	x.Age,
    CASE
        x.Bikes
        WHEN 0 THEN 0
        ELSE 1
    END AS BikeBuyer
FROM
	dbo.DimCustomer c
	INNER JOIN (
        SELECT
CustomerKey
            ,
Region
            ,
Age
            ,
SUM(
                CASE
EnglishProductCategoryName
                    WHEN 'Bikes' THEN 1
                    ELSE 0
                END) AS Bikes
        FROM
dbo.vDMPrep
            GROUP BY
CustomerKey
            ,
Region
            ,
Age
        ) AS x
    ON c.CustomerKey = x.CustomerKey
;
---PRINT '';
---PRINT '*** Creating Table Views';
CREATE OR REPLACE VIEW Person.vAdditionalContactInfo
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	BusinessEntityID
,
	FirstName
,
	MiddleName
,
	LastName
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acttelephoneNumber)[1]/actnumber', 'nvarchar(50)') AS TelephoneNumber
,
	LTRIM(RTRIM(
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acttelephoneNumber/actSpecialInstructions/text())[1]', 'nvarchar(max)'))) AS TelephoneSpecialInstructions
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes";
        (acthomePostalAddress/actStreet)[1]', 'nvarchar(50)') AS Street
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acthomePostalAddress/actCity)[1]', 'nvarchar(50)') AS City
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acthomePostalAddress/actStateProvince)[1]', 'nvarchar(50)') AS StateProvince
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acthomePostalAddress/actPostalCode)[1]', 'nvarchar(50)') AS PostalCode
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acthomePostalAddress/actCountryRegion)[1]', 'nvarchar(50)') AS CountryRegion
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acthomePostalAddress/actSpecialInstructions/text())[1]', 'nvarchar(max)') AS HomeAddressSpecialInstructions
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acteMail/acteMailAddress)[1]', 'nvarchar(128)') AS EMailAddress
,
	LTRIM(RTRIM(
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acteMail/actSpecialInstructions/text())[1]', 'nvarchar(max)'))) AS EMailSpecialInstructions
,
	ContactInfo.ref.value('declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
        declare namespace act="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactTypes"; 
        (acteMail/actSpecialInstructions/acttelephoneNumber/actnumber)[1]', 'nvarchar(50)') AS EMailTelephoneNumber
,
	rowguid
,
	ModifiedDate
FROM
	Person.Person
OUTER APPLY [AdditionalContactInfo].nodes(
'declare namespace ci="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ContactInfo"; 
    /ciAdditionalContactInfo') AS ContactInfo(ref)  RESOLVE EWIWHERE
	AdditionalContactInfo IS NOT NULL;
CREATE OR REPLACE VIEW HumanResources.vEmployee
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	e.BusinessEntityID
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	e.JobTitle
,
	pp.PhoneNumber
,
	pnt.Name AS PhoneNumberType
,
	ea.EmailAddress
,
	p.EmailPromotion
,
	a.AddressLine1
,
	a.AddressLine2
,
	a.City
,
	sp.Name AS StateProvinceName
,
	a.PostalCode
,
	cr.Name AS CountryRegionName
,
	p.AdditionalContactInfo
FROM
	HumanResources.Employee e
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN
        Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = e.BusinessEntityID
INNER JOIN
        Person.Address a
ON a.AddressID = bea.AddressID
INNER JOIN
        Person.StateProvince sp
ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN
        Person.CountryRegion cr
ON cr.CountryRegionCode = sp.CountryRegionCode
LEFT OUTER JOIN
        Person.PersonPhone pp
ON pp.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PhoneNumberType pnt
ON pp.PhoneNumberTypeID = pnt.PhoneNumberTypeID
LEFT OUTER JOIN
        Person.EmailAddress ea
ON p.BusinessEntityID = ea.BusinessEntityID;
CREATE OR REPLACE VIEW HumanResources.vEmployeeDepartment
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	e.BusinessEntityID
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	e.JobTitle
,
	d.Name AS Department
,
	d.GroupName
,
	edh.StartDate
FROM
	HumanResources.Employee e
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN
        HumanResources.EmployeeDepartmentHistory edh
ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN
        HumanResources.Department d
ON edh.DepartmentID = d.DepartmentID
WHERE
	edh.EndDate IS NULL;
CREATE OR REPLACE VIEW HumanResources.vEmployeeDepartmentHistory
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	e.BusinessEntityID
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	s.Name AS Shift
,
	d.Name AS Department
,
	d.GroupName
,
	edh.StartDate
,
	edh.EndDate
FROM
	HumanResources.Employee e
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = e.BusinessEntityID
INNER JOIN
        HumanResources.EmployeeDepartmentHistory edh
ON e.BusinessEntityID = edh.BusinessEntityID
INNER JOIN
        HumanResources.Department d
ON edh.DepartmentID = d.DepartmentID
INNER JOIN
        HumanResources.Shift s
ON s.ShiftID = edh.ShiftID;
CREATE OR REPLACE VIEW Sales.vIndividualCustomer
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	p.BusinessEntityID
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	pp.PhoneNumber
,
	pnt.Name AS PhoneNumberType
,
	ea.EmailAddress
,
	p.EmailPromotion
,
	at.Name AS AddressType
,
	a.AddressLine1
,
	a.AddressLine2
,
	a.City
,
	sp.Name AS StateProvinceName
,
	a.PostalCode
,
	cr.Name AS CountryRegionName
,
	p.Demographics
FROM
	Person.Person p
INNER JOIN
        Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = p.BusinessEntityID
INNER JOIN
        Person.Address a
ON a.AddressID = bea.AddressID
INNER JOIN
        Person.StateProvince sp
ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN
        Person.CountryRegion cr
ON cr.CountryRegionCode = sp.CountryRegionCode
INNER JOIN
        Person.AddressType at
ON at.AddressTypeID = bea.AddressTypeID
INNER JOIN
        Sales.Customer c
ON c.PersonID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.EmailAddress ea
ON ea.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PersonPhone pp
ON pp.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PhoneNumberType pnt
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID
WHERE
	c.StoreID IS NULL;
CREATE OR REPLACE VIEW Sales.vPersonDemographics
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	p.BusinessEntityID
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalPurchaseYTD[1]', 'money') AS TotalPurchaseYTD
,
	CAST(REPLACE(
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        DateFirstPurchase[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS DateFirstPurchase
,
	CAST(REPLACE(
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        BirthDate[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS BirthDate
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        MaritalStatus[1]', 'nvarchar(1)') AS MaritalStatus
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        YearlyIncome[1]', 'nvarchar(30)') AS YearlyIncome
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Gender[1]', 'nvarchar(1)') AS Gender
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        TotalChildren[1]', 'integer') AS TotalChildren
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberChildrenAtHome[1]', 'integer') AS NumberChildrenAtHome
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Education[1]', 'nvarchar(30)') AS Education
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        Occupation[1]', 'nvarchar(30)') AS Occupation
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        HomeOwnerFlag[1]', 'bit') AS HomeOwnerFlag
,
	IndividualSurvey.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
        NumberCarsOwned[1]', 'integer') AS NumberCarsOwned
FROM
	Person.Person p
	LEFT OUTER JOIN
        p.[Demographics].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/IndividualSurvey"; 
    /IndividualSurvey') AS [IndividualSurvey](ref)  
WHERE
	Demographics IS NOT NULL;
CREATE OR REPLACE VIEW HumanResources.vJobCandidate
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	jc.JobCandidateID
,
	jc.BusinessEntityID
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Prefix)[1]', 'nvarchar(30)') AS "Name.Prefix"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume";
        (/Resume/Name/Name.First)[1]', 'nvarchar(30)') AS "Name.First"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Middle)[1]', 'nvarchar(30)') AS "Name.Middle"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Last)[1]', 'nvarchar(30)') AS "Name.Last"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Name/Name.Suffix)[1]', 'nvarchar(30)') AS "Name.Suffix"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/Skills)[1]', 'nvarchar(max)') AS Skills
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Type)[1]', 'nvarchar(30)') AS "Addr.Type"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(100)') AS "Addr.Loc.CountryRegion"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.State)[1]', 'nvarchar(100)') AS "Addr.Loc.State"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.Location/Location/Loc.City)[1]', 'nvarchar(100)') AS "Addr.Loc.City"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Address/Addr.PostalCode)[1]', 'nvarchar(20)') AS "Addr.PostalCode"
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/EMail)[1]', 'nvarchar(max)') AS EMail
,
	Resume.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (/Resume/WebSite)[1]', 'nvarchar(max)') AS WebSite
,
	jc.ModifiedDate
FROM
	HumanResources.JobCandidate jc
	LEFT OUTER JOIN
        jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume') AS Resume(ref)  ;
CREATE OR REPLACE VIEW HumanResources.vJobCandidateEmployment
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	jc.JobCandidateID
,
	CAST(REPLACE(
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.StartDate)[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS "Emp.StartDate"
,
	CAST(REPLACE(
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.EndDate)[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS "Emp.EndDate"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.OrgName)[1]', 'nvarchar(100)') AS "Emp.OrgName"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.JobTitle)[1]', 'nvarchar(100)') AS "Emp.JobTitle"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Responsibility)[1]', 'nvarchar(max)') AS "Emp.Responsibility"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.FunctionCategory)[1]', 'nvarchar(max)') AS "Emp.FunctionCategory"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.IndustryCategory)[1]', 'nvarchar(max)') AS "Emp.IndustryCategory"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(max)') AS "Emp.Loc.CountryRegion"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.State)[1]', 'nvarchar(max)') AS "Emp.Loc.State"
,
	Employment.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Emp.Location/Location/Loc.City)[1]', 'nvarchar(max)') AS "Emp.Loc.City"
FROM
	HumanResources.JobCandidate jc
	LEFT OUTER JOIN
        jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Employment') AS Employment(ref)  ;
CREATE OR REPLACE VIEW HumanResources.vJobCandidateEducation
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	jc.JobCandidateID
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Level)[1]', 'nvarchar(max)') AS "Edu.Level"
,
	CAST(REPLACE(
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.StartDate)[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS "Edu.StartDate"
,
	CAST(REPLACE(
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.EndDate)[1]', 'nvarchar(20)') ,'Z', '') AS TIMESTAMP_NTZ) AS "Edu.EndDate"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Degree)[1]', 'nvarchar(50)') AS "Edu.Degree"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Major)[1]', 'nvarchar(50)') AS "Edu.Major"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Minor)[1]', 'nvarchar(50)') AS "Edu.Minor"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPA)[1]', 'nvarchar(5)') AS "Edu.GPA"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.GPAScale)[1]', 'nvarchar(5)') AS "Edu.GPAScale"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.School)[1]', 'nvarchar(100)') AS "Edu.School"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.CountryRegion)[1]', 'nvarchar(100)') AS "Edu.Loc.CountryRegion"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.State)[1]', 'nvarchar(100)') AS "Edu.Loc.State"
,
	Education.ref.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
        (Edu.Location/Location/Loc.City)[1]', 'nvarchar(100)') AS "Edu.Loc.City"
FROM
	HumanResources.JobCandidate jc
	LEFT OUTER JOIN
        jc.[Resume].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/Resume"; 
    /Resume/Education') AS [Education](ref)  ;
CREATE OR REPLACE VIEW Production.vProductAndDescription
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	p.ProductID
,
	p.Name
,
	pm.Name AS ProductModel
,
	pmx.CultureID
,
	pd.Description
FROM
	Production.Product p
INNER JOIN
        Production.ProductModel pm
ON p.ProductModelID = pm.ProductModelID
INNER JOIN
        Production.ProductModelProductDescriptionCulture pmx
ON pm.ProductModelID = pmx.ProductModelID
INNER JOIN
        Production.ProductDescription pd
ON pmx.ProductDescriptionID = pd.ProductDescriptionID;
CREATE OR REPLACE VIEW Production.vProductModelCatalogDescription
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductModelID
,
	Name
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace html="http://www.w3.org/1999/xhtml"; 
        (/p1ProductDescription/p1Summary/htmlp)[1]', 'nvarchar(max)') AS Summary
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Manufacturer/p1Name)[1]', 'nvarchar(max)') AS Manufacturer
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Manufacturer/p1Copyright)[1]', 'nvarchar(30)') AS Copyright
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Manufacturer/p1ProductURL)[1]', 'nvarchar(256)') AS ProductURL
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1ProductDescription/p1Features/wmWarranty/wmWarrantyPeriod)[1]', 'nvarchar(256)') AS WarrantyPeriod
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1ProductDescription/p1Features/wmWarranty/wmDescription)[1]', 'nvarchar(256)') AS WarrantyDescription
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1ProductDescription/p1Features/wmMaintenance/wmNoOfYears)[1]', 'nvarchar(256)') AS NoOfYears
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wm="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelWarrAndMain"; 
        (/p1ProductDescription/p1Features/wmMaintenance/wmDescription)[1]', 'nvarchar(256)') AS MaintenanceDescription
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1ProductDescription/p1Features/wfwheel)[1]', 'nvarchar(256)') AS Wheel
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1ProductDescription/p1Features/wfsaddle)[1]', 'nvarchar(256)') AS Saddle
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1ProductDescription/p1Features/wfpedal)[1]', 'nvarchar(256)') AS Pedal
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1ProductDescription/p1Features/wfBikeFrame)[1]', 'nvarchar(max)') AS BikeFrame
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        declare namespace wf="http://www.adventure-works.com/schemas/OtherFeatures"; 
        (/p1ProductDescription/p1Features/wfcrankset)[1]', 'nvarchar(256)') AS Crankset
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Picture/p1Angle)[1]', 'nvarchar(256)') AS PictureAngle
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Picture/p1Size)[1]', 'nvarchar(256)') AS PictureSize
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Picture/p1ProductPhotoID)[1]', 'nvarchar(256)') AS ProductPhotoID
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Specifications/Material)[1]', 'nvarchar(256)') AS Material
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Specifications/Color)[1]', 'nvarchar(256)') AS Color
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Specifications/ProductLine)[1]', 'nvarchar(256)') AS ProductLine
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Specifications/Style)[1]', 'nvarchar(256)') AS Style
,
	CatalogDescription.value('declare namespace p1="http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelDescription"; 
        (/p1ProductDescription/p1Specifications/RiderExperience)[1]', 'nvarchar(1024)') AS RiderExperience
,
	rowguid
,
	ModifiedDate
FROM
	Production.ProductModel
WHERE
	CatalogDescription IS NOT NULL;
CREATE OR REPLACE VIEW Production.vProductModelInstructions
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductModelID
,
	Name
,
	Instructions.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
        (/root/text())[1]', 'nvarchar(max)') AS Instructions
,
	XMLGET(ref, '$') :: INT AS LocationID
,
	XMLGET(ref, '$') :: DECIMAL(9, 4) AS SetupHours
,
	XMLGET(ref, '$') :: DECIMAL(9, 4) AS MachineHours
,
	XMLGET(ref, '$') :: DECIMAL(9, 4) AS LaborHours
,
	XMLGET(ref, '$') :: INT AS LotSize
,
	XMLGET(ref, '$') :: VARCHAR(1024) AS Step
,
	rowguid
,
	ModifiedDate
FROM
	Production.ProductModel
	LEFT OUTER JOIN
        [Instructions].nodes(N'declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    /root/Location') MfgInstructions(ref)  
	LEFT OUTER JOIN
        [MfgInstructions].ref.nodes('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/ProductModelManuInstructions"; 
    step') Steps(ref)  ;
CREATE OR REPLACE VIEW Sales.vSalesPerson
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	s.BusinessEntityID
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	e.JobTitle
,
	pp.PhoneNumber
,
	pnt.Name AS PhoneNumberType
,
	ea.EmailAddress
,
	p.EmailPromotion
,
	a.AddressLine1
,
	a.AddressLine2
,
	a.City
,
	sp.Name AS StateProvinceName
,
	a.PostalCode
,
	cr.Name AS CountryRegionName
,
	st.Name AS TerritoryName
,
	st."Group" AS TerritoryGroup
,
	s.SalesQuota
,
	s.SalesYTD
,
	s.SalesLastYear
FROM
	Sales.SalesPerson s
INNER JOIN
        HumanResources.Employee e
ON e.BusinessEntityID = s.BusinessEntityID
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = s.BusinessEntityID
INNER JOIN
        Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = s.BusinessEntityID
INNER JOIN
        Person.Address a
ON a.AddressID = bea.AddressID
INNER JOIN
        Person.StateProvince sp
ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN
        Person.CountryRegion cr
ON cr.CountryRegionCode = sp.CountryRegionCode
LEFT OUTER JOIN
        Sales.SalesTerritory st
ON st.TerritoryID = s.TerritoryID
LEFT OUTER JOIN
        Person.EmailAddress ea
ON ea.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PersonPhone pp
ON pp.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PhoneNumberType pnt
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID;
CREATE OR REPLACE VIEW Sales.vSalesPersonSalesByFiscalYears
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	pvt.SalesPersonID
,
	pvt.FullName
,
	pvt.JobTitle
,
	pvt.SalesTerritory
,
	pvt."'2002'"
,
	pvt."'2003'"
,
	pvt."'2004'"
FROM (SELECT
            soh.SalesPersonID
    ,
            p.FirstName + ' ' + COALESCE(p.MiddleName, '') + ' ' + p.LastName AS FullName
    ,
            e.JobTitle
    ,
            st.Name AS SalesTerritory
    ,
            soh.SubTotal
    ,
            YEAR(DATEADD(month, 6, soh.OrderDate) :: TIMESTAMP) AS FiscalYear
FROM
            Sales.SalesPerson sp
    INNER JOIN
Sales.SalesOrderHeader soh
    ON sp.BusinessEntityID = soh.SalesPersonID
    INNER JOIN
Sales.SalesTerritory st
    ON sp.TerritoryID = st.TerritoryID
    INNER JOIN
HumanResources.Employee e
    ON soh.SalesPersonID = e.BusinessEntityID
INNER JOIN
Person.Person p
ON p.BusinessEntityID = sp.BusinessEntityID
) AS soh
PIVOT
(SUM(SubTotal)
FOR FiscalYear
IN ('2002', '2003', '2004')
) AS pvt;
CREATE OR REPLACE VIEW Person.vStateProvinceCountryRegion
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	sp.StateProvinceID
,
	sp.StateProvinceCode
,
	sp.IsOnlyStateProvinceFlag
,
	sp.Name AS StateProvinceName
,
	sp.TerritoryID
,
	cr.CountryRegionCode
,
	cr.Name AS CountryRegionName
FROM
	Person.StateProvince sp
INNER JOIN
        Person.CountryRegion cr
ON sp.CountryRegionCode = cr.CountryRegionCode;
CREATE OR REPLACE VIEW Sales.vStoreWithDemographics
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	s.BusinessEntityID
,
	s.Name
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualSales)[1]', 'money') AS AnnualSales
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/AnnualRevenue)[1]', 'money') AS AnnualRevenue
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BankName)[1]', 'nvarchar(50)') AS BankName
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/BusinessType)[1]', 'nvarchar(5)') AS BusinessType
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/YearOpened)[1]', 'integer') AS YearOpened
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Specialty)[1]', 'nvarchar(50)') AS Specialty
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/SquareFeet)[1]', 'integer') AS SquareFeet
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Brands)[1]', 'nvarchar(30)') AS Brands
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/Internet)[1]', 'nvarchar(30)') AS Internet
,
	s.Demographics.value('declare default element namespace "http://schemas.microsoft.com/sqlserver/2004/07/adventure-works/StoreSurvey"; 
        (/StoreSurvey/NumberEmployees)[1]', 'integer') AS NumberEmployees
FROM
	Sales.Store s;
CREATE OR REPLACE VIEW Sales.vStoreWithContacts
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	s.BusinessEntityID
,
	s.Name
,
	ct.Name AS ContactType
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	pp.PhoneNumber
,
	pnt.Name AS PhoneNumberType
,
	ea.EmailAddress
,
	p.EmailPromotion
FROM
	Sales.Store s
INNER JOIN
        Person.BusinessEntityContact bec
ON bec.BusinessEntityID = s.BusinessEntityID
INNER JOIN
        Person.ContactType ct
ON ct.ContactTypeID = bec.ContactTypeID
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = bec.PersonID
LEFT OUTER JOIN
        Person.EmailAddress ea
ON ea.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PersonPhone pp
ON pp.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PhoneNumberType pnt
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID;
CREATE OR REPLACE VIEW Sales.vStoreWithAddresses
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	s.BusinessEntityID
,
	s.Name
,
	at.Name AS AddressType
,
	a.AddressLine1
,
	a.AddressLine2
,
	a.City
,
	sp.Name AS StateProvinceName
,
	a.PostalCode
,
	cr.Name AS CountryRegionName
FROM
	Sales.Store s
INNER JOIN
        Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = s.BusinessEntityID
INNER JOIN
        Person.Address a
ON a.AddressID = bea.AddressID
INNER JOIN
        Person.StateProvince sp
ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN
        Person.CountryRegion cr
ON cr.CountryRegionCode = sp.CountryRegionCode
INNER JOIN
        Person.AddressType at
ON at.AddressTypeID = bea.AddressTypeID;
CREATE OR REPLACE VIEW Purchasing.vVendorWithContacts
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	v.BusinessEntityID
,
	v.Name
,
	ct.Name AS ContactType
,
	p.Title
,
	p.FirstName
,
	p.MiddleName
,
	p.LastName
,
	p.Suffix
,
	pp.PhoneNumber
,
	pnt.Name AS PhoneNumberType
,
	ea.EmailAddress
,
	p.EmailPromotion
FROM
	Purchasing.Vendor v
INNER JOIN
        Person.BusinessEntityContact bec
ON bec.BusinessEntityID = v.BusinessEntityID
INNER JOIN
        Person.ContactType ct
ON ct.ContactTypeID = bec.ContactTypeID
INNER JOIN
        Person.Person p
ON p.BusinessEntityID = bec.PersonID
LEFT OUTER JOIN
        Person.EmailAddress ea
ON ea.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PersonPhone pp
ON pp.BusinessEntityID = p.BusinessEntityID
LEFT OUTER JOIN
        Person.PhoneNumberType pnt
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID;
CREATE OR REPLACE VIEW Purchasing.vVendorWithAddresses
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	v.BusinessEntityID
,
	v.Name
,
	at.Name AS AddressType
,
	a.AddressLine1
,
	a.AddressLine2
,
	a.City
,
	sp.Name AS StateProvinceName
,
	a.PostalCode
,
	cr.Name AS CountryRegionName
FROM
	Purchasing.Vendor v
INNER JOIN
        Person.BusinessEntityAddress bea
ON bea.BusinessEntityID = v.BusinessEntityID
INNER JOIN
        Person.Address a
ON a.AddressID = bea.AddressID
INNER JOIN
        Person.StateProvince sp
ON sp.StateProvinceID = a.StateProvinceID
INNER JOIN
        Person.CountryRegion cr
ON cr.CountryRegionCode = sp.CountryRegionCode
INNER JOIN
        Person.AddressType at
ON at.AddressTypeID = bea.AddressTypeID;
CREATE OR REPLACE VIEW vw_ActiveInventory
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	ProductName,
	Category,
	QuantityInStock,
	LastUpdated
FROM
	dbo.Inventory
WHERE
	QuantityInStock > 0;
CREATE OR REPLACE VIEW vw_RecentCustomerOrders
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	OrderID,
	CustomerID,
	OrderDate,
	Status,
	TotalAmount
FROM
	dbo.Orders
WHERE
	OrderDate >= DATEADD(DAY, -30, CURRENT_TIMESTAMP() :: TIMESTAMP);
CREATE OR REPLACE VIEW vw_SupplierPerformance
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	SupplierID,
	COUNT(PurchaseOrderID) AS TotalOrders,
	AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
FROM
	dbo.PurchaseOrders
GROUP BY
	SupplierID;
CREATE OR REPLACE VIEW vw_LowStockItems
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	ProductName,
	QuantityInStock,
	ReorderLevel
FROM
	dbo.Inventory
WHERE
	QuantityInStock < ReorderLevel;
CREATE OR REPLACE VIEW vw_OrderFulfillmentRate
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	CustomerID,
	COUNT(OrderID) AS TotalOrders,
	SUM(CASE WHEN Status = 'Delivered' THEN 1 ELSE 0 END) AS FulfilledOrders
FROM
	dbo.Orders
GROUP BY
	CustomerID;
CREATE OR REPLACE VIEW vw_MonthlySalesSummary
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	YEAR(OrderDate :: TIMESTAMP) AS Year,
	MONTH(OrderDate :: TIMESTAMP) AS Month,
	SUM(TotalAmount) AS TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM
	dbo.Orders
GROUP BY
	YEAR(OrderDate :: TIMESTAMP),
	MONTH(OrderDate :: TIMESTAMP);
CREATE OR REPLACE VIEW vw_ShipmentTracking
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ShipmentID,
	OrderID,
	Carrier,
	TrackingNumber,
	ShipmentDate,
	EstimatedDeliveryDate,
	Status
FROM
	dbo.Shipments;
CREATE OR REPLACE VIEW vw_ProductDemand
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	COUNT(OrderID) AS OrdersCount,
	SUM(Quantity) AS TotalQuantityOrdered
FROM
	dbo.OrderDetails
GROUP BY
	ProductID;
CREATE OR REPLACE VIEW vw_HighValueCustomers
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	CustomerID,
	SUM(TotalAmount) AS TotalSpent
FROM
	dbo.Orders
GROUP BY
	CustomerID
HAVING
	SUM(TotalAmount) > 10000;
CREATE OR REPLACE VIEW vw_UnshippedOrders
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	OrderID,
	CustomerID,
	OrderDate,
	Status
FROM
	dbo.Orders
WHERE
	Status NOT IN ('Shipped', 'Delivered');
CREATE OR REPLACE VIEW vw_ActiveProducts
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	ProductName,
	Category,
	QuantityInStock,
	LastUpdated
FROM
	Inventory
WHERE
	QuantityInStock > 0;
CREATE OR REPLACE VIEW vw_RecentCustomerOrders
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	OrderID,
	CustomerID,
	OrderDate,
	Status,
	TotalAmount
FROM
	Orders
WHERE
	OrderDate >= DATEADD(DAY, -30, CURRENT_TIMESTAMP() :: TIMESTAMP);
CREATE OR REPLACE VIEW vw_SupplierPerformance
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	SupplierID,
	SupplierName,
	COUNT(PurchaseOrderID) AS TotalOrders,
	AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
FROM
	PurchaseOrders
GROUP BY
	SupplierID,
	SupplierName;
CREATE OR REPLACE VIEW vw_LowStockItems
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	ProductName,
	QuantityInStock,
	ReorderLevel
FROM
	Inventory
WHERE
	QuantityInStock < ReorderLevel;
CREATE OR REPLACE VIEW vw_OrderFulfillmentRate
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	CustomerID,
	COUNT(OrderID) AS TotalOrders,
	SUM(CASE WHEN Status = 'Delivered' THEN 1 ELSE 0 END) AS FulfilledOrders,
   (SUM(CASE WHEN Status = 'Delivered' THEN 1 ELSE 0 END) * 100.0 / COUNT(OrderID)) AS FulfillmentRate
FROM
	Orders
GROUP BY
	CustomerID;
CREATE OR REPLACE VIEW vw_MonthlySalesSummary
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	TO_CHAR(OrderDate, 'yyyy-MM')   AS Month,
	SUM(TotalAmount) AS TotalSales,
	COUNT(OrderID) AS TotalOrders
FROM
	Orders
GROUP BY
	TO_CHAR(OrderDate, 'yyyy-MM')  ;
CREATE OR REPLACE VIEW vw_ShipmentTracking
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ShipmentID,
	OrderID,
	Carrier,
	TrackingNumber,
	ShipmentDate,
	EstimatedDeliveryDate,
	Status
FROM
	Shipments;
CREATE OR REPLACE VIEW vw_ProductDemand
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	ProductID,
	ProductName,
	COUNT(OrderID) AS OrdersCount,
	SUM(Quantity) AS TotalQuantityOrdered
FROM
	OrderDetails
GROUP BY
	ProductID,
	ProductName;
CREATE OR REPLACE VIEW vw_HighValueCustomers
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	CustomerID,
	CustomerName,
	SUM(TotalAmount) AS TotalSpent
FROM
	Orders
GROUP BY
	CustomerID,
	CustomerName
HAVING
	SUM(TotalAmount) > 10000;
CREATE OR REPLACE VIEW vw_UnshippedOrders
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
SELECT
	OrderID,
	CustomerID,
	OrderDate,
	Status
FROM
	Orders
WHERE
	Status NOT IN ('Shipped', 'Delivered');