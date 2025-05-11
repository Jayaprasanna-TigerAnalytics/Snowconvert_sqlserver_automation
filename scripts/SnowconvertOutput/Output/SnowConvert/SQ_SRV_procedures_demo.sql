--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employee" **
CREATE OR REPLACE PROCEDURE sp_AddProduct (PRODUCTNAME STRING, CATEGORY STRING, QUANTITYINSTOCK INT, REORDERLEVEL INT, PRICE DECIMAL(18,2))
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
  BEGIN
    BEGIN
      INSERT INTO Inventory (ProductName, Category, QuantityInStock, ReorderLevel, Price, LastUpdated)
      VALUES (:PRODUCTNAME, :CATEGORY, :QUANTITYINSTOCK, :REORDERLEVEL, :PRICE, CURRENT_TIMESTAMP() :: TIMESTAMP);
    END;
    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'CREATE PROCEDURE' NODE ***/!!!
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
  END;
$$;