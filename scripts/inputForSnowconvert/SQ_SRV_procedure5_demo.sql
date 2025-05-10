--Procedure to Get Orders for a Specific Customer
CREATE PROCEDURE sp_GetCustomerOrders
    @CustomerID INT
AS
BEGIN
    SELECT OrderID, OrderDate, Status, TotalAmount
    FROM Orders
    WHERE CustomerID = @CustomerID
    ORDER BY OrderDate DESC;
END;