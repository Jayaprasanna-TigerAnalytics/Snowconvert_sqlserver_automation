
CREATE OR REPLACE PROCEDURE sp_CalculateSupplierPerformance (SUPPLIERID INT)
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
            SupplierID,
            COUNT(PurchaseOrderID) AS TotalOrders,
            AVG(DATEDIFF(DAY, OrderDate, DeliveryDate)) AS AvgDeliveryTime
        FROM
            PurchaseOrders
        WHERE
            SupplierID = SUPPLIERID
        GROUP BY
            SupplierID);
        RETURN TABLE(ProcedureResultSet);
    END;
$$;