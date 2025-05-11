CREATE OR REPLACE FUNCTION dbo.GetCustomerLifetimeValue (CUSTOMERID INT)
RETURNS DECIMAL(18,2)
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
AS
$$
    WITH CTE1 AS
    (
        SELECT
            SUM(TotalAmount) AS TOTALSPENT FROM
            Orders
        WHERE
            CustomerID = CUSTOMERID
    )
    SELECT
        NVL(TOTALSPENT, 0)
    FROM
        CTE0
$$;