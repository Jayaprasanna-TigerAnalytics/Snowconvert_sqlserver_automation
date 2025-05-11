CREATE OR REPLACE FUNCTION dbo.GetOrderTotal (ORDERID INT)
RETURNS DECIMAL(18,2)
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
AS
$$
    WITH CTE1 AS
    (
        SELECT
            SUM(Quantity * UnitPrice) AS TOTAL FROM
            OrderDetails
        WHERE
            OrderID = ORDERID
    )
    SELECT
        NVL(TOTAL, 0)
    FROM
        CTE0
$$;