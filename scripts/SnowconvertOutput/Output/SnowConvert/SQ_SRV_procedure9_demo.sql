--Procedure to Get Low Stock Items
CREATE OR REPLACE PROCEDURE sp_GetLowStockItems ()
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
            ProductID,
            ProductName,
            QuantityInStock,
            ReorderLevel
        FROM
            Inventory
        WHERE
            QuantityInStock < ReorderLevel);
        RETURN TABLE(ProcedureResultSet);
    END;
$$;