
CREATE OR REPLACE PROCEDURE sp_GetCustomerOrders (CUSTOMERID INT)
RETURNS TABLE()
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        ProcedureResultSet RESULTSET;
    BEGIN
        ProcedureResultSet := (
        SELECT
            OrderID,
            OrderDate,
            Status,
            TotalAmount
        FROM
            Orders
        WHERE
            CustomerID = CUSTOMERID
        ORDER BY OrderDate DESC);
        RETURN TABLE(ProcedureResultSet);
    END;
$$;