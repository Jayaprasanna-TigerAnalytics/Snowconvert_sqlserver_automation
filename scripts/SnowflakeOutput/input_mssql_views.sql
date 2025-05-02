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
	c.StoreID IS NULL;;
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
ON pmx.ProductDescriptionID = pd.ProductDescriptionID;;
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
ON sp.CountryRegionCode = cr.CountryRegionCode;;
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
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID;;
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
ON at.AddressTypeID = bea.AddressTypeID;;
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
ON pnt.PhoneNumberTypeID = pp.PhoneNumberTypeID;;
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
ON at.AddressTypeID = bea.AddressTypeID;;
