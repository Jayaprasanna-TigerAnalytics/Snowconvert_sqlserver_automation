
CREATE TRIGGER trg_UpdateInventoryOnOrder
ON OrderDetails
AFTER INSERT
AS
BEGIN
    UPDATE i
    SET i.QuantityInStock = i.QuantityInStock - od.Quantity
    FROM Inventory i
    INNER JOIN inserted od ON i.ProductID = od.ProductID;
END;
GO


CREATE TRIGGER trg_PreventOutOfStockOrders
ON OrderDetails
AFTER INSERT
AS
BEGIN
    IF EXISTS (
        SELECT 1 FROM Inventory i
        INNER JOIN inserted od ON i.ProductID = od.ProductID
        WHERE i.QuantityInStock < od.Quantity
    )
    BEGIN
        RAISERROR ('Cannot place order. Product is out of stock.', 16, 1);
        ROLLBACK TRANSACTION;
    END;
END;
GO


CREATE TRIGGER trg_LogOrderStatusChange
ON Orders
AFTER UPDATE
AS
BEGIN
    INSERT INTO OrderStatusLog (OrderID, OldStatus, NewStatus, ChangeDate)
    SELECT i.OrderID, d.Status AS OldStatus, i.Status AS NewStatus, GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.OrderID = d.OrderID
    WHERE i.Status <> d.Status;
END;
GO


CREATE TRIGGER trg_CompleteOrderOnShipment
ON Shipments
AFTER INSERT
AS
BEGIN
    UPDATE o
    SET o.Status = 'Completed'
    FROM Orders o
    WHERE o.OrderID IN (SELECT OrderID FROM inserted);
END;
GO


CREATE TRIGGER trg_PreventSupplierDeactivation
ON Suppliers
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM PurchaseOrders WHERE SupplierID IN (SELECT SupplierID FROM deleted) AND Status NOT IN ('Completed', 'Canceled'))
    BEGIN
        RAISERROR ('Cannot deactivate supplier. Pending purchase orders exist.', 16, 1);
        RETURN;
    END;
    DELETE FROM Suppliers WHERE SupplierID IN (SELECT SupplierID FROM deleted);
END;
GO


CREATE TRIGGER trg_UpdateSupplierPerformance
ON SupplierDeliveries
AFTER INSERT
AS
BEGIN
    UPDATE Suppliers
    SET AvgDeliveryTime = (
        SELECT AVG(DATEDIFF(DAY, OrderDate, DeliveryDate))
        FROM PurchaseOrders
        WHERE SupplierID = inserted.SupplierID
    )
    FROM inserted;
END;
GO


CREATE TRIGGER trg_PreventShippedOrderCancellation
ON Orders
INSTEAD OF DELETE
AS
BEGIN
    IF EXISTS (SELECT 1 FROM Orders WHERE OrderID IN (SELECT OrderID FROM deleted) AND Status = 'Shipped')
    BEGIN
        RAISERROR ('Cannot cancel an order that has already been shipped.', 16, 1);
        RETURN;
    END;
    DELETE FROM Orders WHERE OrderID IN (SELECT OrderID FROM deleted);
END;
GO


CREATE TRIGGER trg_LogInventoryRestock
ON Inventory
AFTER UPDATE
AS
BEGIN
    INSERT INTO InventoryRestockLog (ProductID, OldQuantity, NewQuantity, RestockDate)
    SELECT d.ProductID, d.QuantityInStock AS OldQuantity, i.QuantityInStock AS NewQuantity, GETDATE()
    FROM inserted i
    INNER JOIN deleted d ON i.ProductID = d.ProductID
    WHERE i.QuantityInStock > d.QuantityInStock;
END;
GO


CREATE TRIGGER trg_AutoReorderStock
ON Inventory
AFTER UPDATE
AS
BEGIN
    INSERT INTO PurchaseOrders (SupplierID, ProductID, OrderDate, QuantityOrdered, Status)
    SELECT s.SupplierID, i.ProductID, GETDATE(), (i.ReorderLevel - i.QuantityInStock), 'Pending'
    FROM inserted i
    INNER JOIN Suppliers s ON i.ProductID = s.ProductID
    WHERE i.QuantityInStock < i.ReorderLevel;
END;
GO


CREATE TRIGGER trg_LogDelayedShipments
ON Shipments
AFTER UPDATE
AS
BEGIN
    INSERT INTO ShipmentDelayLog (ShipmentID, OrderID, ExpectedDate, ActualDate, DelayDays)
    SELECT i.ShipmentID, i.OrderID, i.EstimatedDeliveryDate, i.DeliveryDate, DATEDIFF(DAY, i.EstimatedDeliveryDate, i.DeliveryDate)
    FROM inserted i
    WHERE i.DeliveryDate > i.EstimatedDeliveryDate;
END;
GO