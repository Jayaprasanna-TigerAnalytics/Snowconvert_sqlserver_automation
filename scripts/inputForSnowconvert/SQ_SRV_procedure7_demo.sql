--Procedure to Calculate Supplier Performance
CREATE PROCEDURE sp_CalculateSupplierPerformance
    @SupplierID INT
AS
BEGIN
    SELECT SupplierID, COUNT(PurchaseOrderID) AS TotalOrders,
           AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
    FROM PurchaseOrders
    WHERE SupplierID = @SupplierID
    GROUP BY SupplierID;
END;