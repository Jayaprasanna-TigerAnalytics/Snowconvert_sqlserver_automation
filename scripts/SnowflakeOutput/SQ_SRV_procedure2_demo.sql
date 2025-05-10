CREATE OR REPLACE PROCEDURE sp_UpdateInventory (PRODUCTID INT, NEWQUANTITY INT)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    BEGIN
        UPDATE Inventory
        SET
            QuantityInStock = NEWQUANTITY,
            LastUpdated = CURRENT_TIMESTAMP() :: TIMESTAMP
        WHERE
            ProductID = PRODUCTID;
    END;
$$;;
