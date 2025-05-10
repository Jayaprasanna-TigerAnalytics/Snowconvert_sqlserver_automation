--Procedure to Get High-Value Customers
CREATE PROCEDURE sp_GetHighValueCustomers
    @MinSpent DECIMAL(18,2)
AS
BEGIN
    SELECT CustomerID, CustomerName, SUM(TotalAmount) AS TotalSpent
    FROM Orders
    GROUP BY CustomerID, CustomerName
    HAVING SUM(TotalAmount) > @MinSpent;
END;