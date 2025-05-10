CREATE OR REPLACE FUNCTION dbo.GetTotalOrdersForCustomer (CUSTOMERID INT)
RETURNS INT
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
AS
$$
    WITH CTE1 AS
    (
        SELECT
            COUNT(*) AS TOTALORDERS FROM
            Orders
        WHERE
            CustomerID = CUSTOMERID
    )
    SELECT
        TOTALORDERS
    FROM
        CTE0
$$;;
