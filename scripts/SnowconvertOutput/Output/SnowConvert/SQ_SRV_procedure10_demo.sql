--Procedure to Get High-Value Customers
CREATE OR REPLACE PROCEDURE sp_GetHighValueCustomers (MINSPENT DECIMAL(18,2))
RETURNS TABLE()
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        ProcedureResultSet RESULTSET;
    BEGIN
        ProcedureResultSet := (
        SELECT
            CustomerID,
            CustomerName,
            SUM(TotalAmount) AS TotalSpent
        FROM
            Orders
        GROUP BY
            CustomerID,
            CustomerName
        HAVING
            SUM(TotalAmount) > :MINSPENT);
        RETURN TABLE(ProcedureResultSet);
    END;
$$;