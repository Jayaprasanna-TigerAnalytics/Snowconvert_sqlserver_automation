CREATE FUNCTION dbo.GetAvailableStock (@ProductID INT)
RETURNS INT
AS
BEGIN
    DECLARE @Stock INT;
    SELECT @Stock = SUM(Quantity) FROM Inventory WHERE ProductID = @ProductID;
    RETURN ISNULL(@Stock, 0);
END;