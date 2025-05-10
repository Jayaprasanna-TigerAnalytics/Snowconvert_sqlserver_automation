CREATE VIEW vw_ActiveProducts AS
SELECT ProductID, ProductName, Category, QuantityInStock, LastUpdated
FROM Inventory
WHERE QuantityInStock > 0;

CREATE VIEW vw_RecentCustomerOrders AS
SELECT OrderID, CustomerID, OrderDate, Status, TotalAmount
FROM Orders
WHERE OrderDate >= DATEADD(DAY, -30, GETDATE());

CREATE VIEW vw_SupplierPerformance AS
SELECT SupplierID, SupplierName, COUNT(PurchaseOrderID) AS TotalOrders, 
       AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
FROM PurchaseOrders
GROUP BY SupplierID, SupplierName;

CREATE VIEW vw_ProductCatalog AS
SELECT 
    ProductID, 
    ProductName, 
    JSON_VALUE(ProductSpecs, '$.Processor') AS Processor,
    JSON_VALUE(ProductSpecs, '$.RAM') AS RAM
FROM ProductCatalog;
	
CREATE VIEW vw_LocationInfo AS
SELECT 
    LocationID, 
    LocationName, 
    GeoCoordinates.Lat AS Latitude, 
    GeoCoordinates.Long AS Longitude
FROM LocationInfo;