--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "SalesOrders" **
CREATE OR REPLACE PROCEDURE CustomerSegmentation ()
RETURNS TABLE()
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        ProcedureResultSet RESULTSET;
    BEGIN
        !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
        SET NOCOUNT ON;
        -- Temporary table to store segmentation
        CREATE OR REPLACE TEMPORARY TABLE T_CustomerSegments (
            CustomerID INT,
            TotalSpent DECIMAL(18,2),
            PurchaseCount INT,
            Segment VARCHAR(20)
        );

        -- Calculate total spending and purchase count per customer
        INSERT INTO T_CustomerSegments (CustomerID, TotalSpent, PurchaseCount)
        SELECT
            CustomerID,
            SUM(TotalAmount) AS TotalSpent,
            COUNT(OrderID) AS PurchaseCount
        FROM
            SalesOrders
        GROUP BY
            CustomerID;

        -- Assign customer segments based on spending and purchase frequency
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

        -- Select final segmentation results
        SELECT
        *
        FROM
        T_CustomerSegments);

        -- Clean up
        DROP TABLE IF EXISTS T_CustomerSegments;
        RETURN TABLE(ProcedureResultSet);
    END;
$$;