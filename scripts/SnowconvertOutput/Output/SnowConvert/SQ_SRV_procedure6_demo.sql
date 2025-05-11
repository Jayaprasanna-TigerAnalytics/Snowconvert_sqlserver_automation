--Procedure to Record a Supplier Delivery
--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "SupplierDeliveries" **
CREATE OR REPLACE PROCEDURE sp_RecordSupplierDelivery (SUPPLIERID INT, PRODUCTID INT, QUANTITYDELIVERED INT, DELIVERYDATE DATE)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    BEGIN
        INSERT INTO SupplierDeliveries (SupplierID, ProductID, QuantityDelivered, DeliveryDate)
        VALUES (:SUPPLIERID, :PRODUCTID, :QUANTITYDELIVERED, :DELIVERYDATE);

        UPDATE Inventory
        SET
            QuantityInStock = QuantityInStock + :QUANTITYDELIVERED,
            LastUpdated = CURRENT_TIMESTAMP() :: TIMESTAMP
        WHERE
            ProductID = :PRODUCTID;
    END;
$$;