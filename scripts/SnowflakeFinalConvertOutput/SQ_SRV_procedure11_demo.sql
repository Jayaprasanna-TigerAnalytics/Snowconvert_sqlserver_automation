CREATE OR REPLACE PROCEDURE CustomerSegmentation ()
RETURNS TABLE()
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        ProcedureResultSet RESULTSET;
    BEGIN
        
        CREATE OR REPLACE TEMPORARY TABLE T_CustomerSegments (
            CustomerID INT,
            TotalSpent DECIMAL(18,2),
            PurchaseCount INT,
            Segment VARCHAR(20)
        );
        INSERT INTO T_CustomerSegments (CustomerID, TotalSpent, PurchaseCount)
        SELECT
            CustomerID,
            SUM(TotalAmount) AS TotalSpent,
            COUNT(OrderID) AS PurchaseCount
        FROM
            SalesOrders
        GROUP BY
            CustomerID;
        UPDATE T_CustomerSegments
        SET
                Segment =
            CASE
                WHEN TotalSpent > 10000 AND PurchaseCount > 50 THEN 'VIP'
                WHEN TotalSpent BETWEEN 5000 AND 10000 THEN 'Loyal'
                WHEN TotalSpent BETWEEN 1000 AND 5000 THEN 'Regular'
                ELSE 'Occasional'
            END;
        ProcedureResultSet := (
        SELECT
        *
        FROM
        T_CustomerSegments);
        DROP TABLE IF EXISTS T_CustomerSegments;
        RETURN TABLE(ProcedureResultSet);
    END;
$$;