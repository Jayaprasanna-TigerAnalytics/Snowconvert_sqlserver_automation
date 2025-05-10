--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Inventory_Staging" **
MERGE INTO Inventory AS target
USING Inventory_Staging AS source
ON target.ProductID = source.ProductID
WHEN MATCHED THEN
       UPDATE SET
           target.Quantity = source.Quantity,
           target.LastUpdated = CURRENT_TIMESTAMP() :: TIMESTAMP
WHEN NOT MATCHED THEN
       INSERT (ProductID, Quantity, LastUpdated)
       VALUES (source.ProductID, source.Quantity, CURRENT_TIMESTAMP() :: TIMESTAMP);

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "Supplier", "Supplier_Staging" **
MERGE INTO Supplier AS target
USING Supplier_Staging AS source
ON target.SupplierID = source.SupplierID
WHEN MATCHED THEN
          UPDATE SET
           target.SupplierName = source.SupplierName,
           target.ContactInfo = source.ContactInfo
WHEN NOT MATCHED THEN
          INSERT (SupplierID, SupplierName, ContactInfo)
          VALUES (source.SupplierID, source.SupplierName, source.ContactInfo);

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "PurchaseOrder", "PurchaseOrder_Staging" **
MERGE INTO PurchaseOrder AS target
USING PurchaseOrder_Staging AS source
ON target.OrderID = source.OrderID
WHEN MATCHED THEN
          UPDATE SET
           target.Status = source.Status,
           target.LastUpdated = CURRENT_TIMESTAMP() :: TIMESTAMP
WHEN NOT MATCHED THEN
          INSERT (OrderID, SupplierID, OrderDate, Status, LastUpdated)
          VALUES (source.OrderID, source.SupplierID, source.OrderDate, source.Status, CURRENT_TIMESTAMP() :: TIMESTAMP);

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "ShipmentTracking", "ShipmentTracking_Staging" **
MERGE INTO ShipmentTracking AS target
USING ShipmentTracking_Staging AS source
ON target.TrackingID = source.TrackingID
WHEN MATCHED THEN
          UPDATE SET
           target.Status = source.Status,
           target.ETA = source.ETA
WHEN NOT MATCHED THEN
          INSERT (TrackingID, Carrier, Status, ETA)
          VALUES (source.TrackingID, source.Carrier, source.Status, source.ETA);

--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "WarehouseStock", "WarehouseStock_Staging" **
MERGE INTO WarehouseStock AS target
USING WarehouseStock_Staging AS source
ON target.WarehouseID = source.WarehouseID
AND target.ProductID = source.ProductID
WHEN MATCHED THEN
          UPDATE SET
           target.StockQuantity = source.StockQuantity
WHEN NOT MATCHED THEN
          INSERT (WarehouseID, ProductID, StockQuantity)
          VALUES (source.WarehouseID, source.ProductID, source.StockQuantity);