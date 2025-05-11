--Procedure to Update Order Status
CREATE OR REPLACE PROCEDURE sp_UpdateOrderStatus (ORDERID INT, NEWSTATUS STRING)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    BEGIN
        UPDATE Orders
        SET
            Status = :NEWSTATUS
        WHERE
            OrderID = :ORDERID;
    END;
$$;