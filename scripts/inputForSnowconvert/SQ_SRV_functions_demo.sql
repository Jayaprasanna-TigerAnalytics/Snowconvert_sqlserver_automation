CREATE FUNCTION dbo.GetTotalOrdersForCustomer (@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalOrders INT;
    SELECT @TotalOrders = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
    RETURN @TotalOrders;
END;


CREATE FUNCTION dbo.GetAvailableStock (@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Stock INT;
    SELECT @Stock = SUM(Quantity) FROM Inventory WHERE ProductID = @ProductID;
    RETURN ISNULL(@Stock, 0);
END;


CREATE FUNCTION dbo.GetOrderTotal (@OrderID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @Total DECIMAL(18,2);
    SELECT @Total = SUM(Quantity * UnitPrice) FROM OrderDetails WHERE OrderID = @OrderID;
    RETURN ISNULL(@Total, 0);
END;


CREATE FUNCTION dbo.GetCustomerLifetimeValue (@CustomerID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalSpent DECIMAL(18,2);
    SELECT @TotalSpent = SUM(TotalAmount) FROM Orders WHERE CustomerID = @CustomerID;
    RETURN ISNULL(@TotalSpent, 0);
END;