CREATE OR REPLACE VIEW vw_RecentCustomerOrders
    COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
    AS
    SELECT
    OrderID,
    CustomerID,
    OrderDate,
    Status,
    TotalAmount
    FROM
    Orders
    WHERE
    OrderDate >= DATEADD(DAY, -30, CURRENT_TIMESTAMP() :: TIMESTAMP);;
