CREATE FUNCTION dbo.GetOrderTotal (@OrderID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2);
    SELECT @Total = SUM(Quantity * UnitPrice) FROM OrderDetails WHERE OrderID = @OrderID;
    RETURN ISNULL(@Total, 0);
END;