--Procedure to Place a New Customer Order
CREATE OR REPLACE PROCEDURE sp_PlaceOrder (CUSTOMERID INT, ORDERDATE DATE, TOTALAMOUNT DECIMAL(18,2), ORDERSTATUS STRING)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    BEGIN
        INSERT INTO Orders (CustomerID, OrderDate, TotalAmount, Status)
        VALUES (:CUSTOMERID, :ORDERDATE, :TOTALAMOUNT, :ORDERSTATUS);
    END;
$$;