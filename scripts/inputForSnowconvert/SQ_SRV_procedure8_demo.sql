--Procedure to Generate a Shipment for an Order
CREATE PROCEDURE sp_CreateShipment
    @OrderID INT,
    @Carrier NVARCHAR(100),
    @TrackingNumber NVARCHAR(50),
    @EstimatedDeliveryDate DATE
AS
BEGIN
    INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShipmentDate, EstimatedDeliveryDate, Status)
    VALUES (@OrderID, @Carrier, @TrackingNumber, GETDATE(), @EstimatedDeliveryDate, 'Shipped');

    UPDATE Orders
    SET Status = 'Shipped'
    WHERE OrderID = @OrderID;
END;