--Procedure to Get Low Stock Items
CREATE PROCEDURE sp_GetLowStockItems
AS
BEGIN
    SELECT ProductID, ProductName, QuantityInStock, ReorderLevel
    FROM Inventory
    WHERE QuantityInStock < ReorderLevel;
END;