CREATE OR REPLACE VIEW vw_ActiveProducts
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
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
    COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
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
    COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
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
    CREATE OR REPLACE VIEW vw_ProductCatalog
    COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
    AS
    SELECT
    ProductID,
    ProductName,
    PARSE_JSON(ProductSpecs)Processor:STRING AS Processor,
    PARSE_JSON(ProductSpecs)RAM:STRING AS RAM
    FROM
    ProductCatalog;
    CREATE OR REPLACE VIEW vw_LocationInfo
    COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
    AS
    SELECT
    LocationID,
    LocationName,
    GeoCoordinates.Lat AS Latitude,
    GeoCoordinates.Long AS Longitude
    FROM
    LocationInfo;