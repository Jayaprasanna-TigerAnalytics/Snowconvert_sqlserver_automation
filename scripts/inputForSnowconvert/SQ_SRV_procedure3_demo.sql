--Procedure to Place a New Customer Order
CREATE PROCEDURE sp_PlaceOrder
    @CustomerID INT,
    @OrderDate DATE,
    @TotalAmount DECIMAL(18,2),
    @OrderStatus NVARCHAR(50)
AS
BEGIN
    INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status)
    VALUES (@CustomerID, @OrderDate, @TotalAmount, @OrderStatus);
END;