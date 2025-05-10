--Returns the total number of orders placed by a specific customer.
CREATE FUNCTION dbo.GetTotalOrdersForCustomer (@CustomerID INT)
RETURNS INT
AS
BEGIN
    DECLARE @TotalOrders INT;
    SELECT @TotalOrders = COUNT(*) FROM Orders WHERE CustomerID = @CustomerID;
    RETURN @TotalOrders;
END;