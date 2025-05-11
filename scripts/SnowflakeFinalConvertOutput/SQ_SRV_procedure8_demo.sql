
CREATE OR REPLACE PROCEDURE sp_CreateShipment (ORDERID INT, CARRIER STRING, TRACKINGNUMBER STRING, ESTIMATEDDELIVERYDATE DATE)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    BEGIN
        INSERT INTO Shipments (OrderID, Carrier, TrackingNumber, ShipmentDate, EstimatedDeliveryDate, Status)
        VALUES (ORDERID, CARRIER, TRACKINGNUMBER, CURRENT_TIMESTAMP() :: TIMESTAMP, ESTIMATEDDELIVERYDATE, 'Shipped');
        UPDATE Orders
        SET
            Status = 'Shipped'
        WHERE
            OrderID = ORDERID;
    END;
$$;