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