CREATE FUNCTION dbo.GetCustomerLifetimeValue (@CustomerID INT)
RETURNS DECIMAL(18,2)
AS
BEGIN
    DECLARE @TotalSpent DECIMAL(18,2);
    SELECT @TotalSpent = SUM(TotalAmount) FROM Orders WHERE CustomerID = @CustomerID;
    RETURN ISNULL(@TotalSpent, 0);
END;