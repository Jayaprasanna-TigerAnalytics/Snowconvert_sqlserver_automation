CREATE PROCEDURE sp_AddProduct
    @ProductName NVARCHAR(255),
    @Category NVARCHAR(100),
    @QuantityInStock INT,
    @ReorderLevel INT,
    @Price DECIMAL(18,2)
AS
BEGIN
    INSERT INTO Inventory (ProductName, Category, QuantityInStock, ReorderLevel, Price, LastUpdated)
    VALUES (@ProductName, @Category, @QuantityInStock, @ReorderLevel, @Price, GETDATE());
END;


CREATE PROCEDURE sp_UpdateInventory
    @ProductID INT,
    @NewQuantity INT
AS
BEGIN
    UPDATE Inventory
    SET QuantityInStock = @NewQuantity, LastUpdated = GETDATE()
    WHERE ProductID = @ProductID;
END;

CREATE PROCEDURE spGetEmployee
As
BEGIN
  SELECT Name,Gender, DOB FROM Employee
END;


ALTER PROCEDURE spGetEmployee
AS
BEGIN
  SELECT Name, Gender, DOB 
  FROM Employee 
  ORDER BY Name
END;

