CREATE OR REPLACE PROCEDURE ETL_Process ()
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        CURRENTDATE DATE := CURRENT_TIMESTAMP() :: TIMESTAMP;
    BEGIN
        
        CREATE OR REPLACE TEMPORARY TABLE T_StagingCustomers AS
            SELECT
                *
        FROM
                SourceDB.dbo.Customers
        WHERE
                LastUpdated >= DATEADD(DAY, -1, CURRENTDATE);
        CREATE OR REPLACE TEMPORARY TABLE T_StagingOrders AS
            SELECT
                *
        FROM
                SourceDB.dbo.Orders
        WHERE
                OrderDate >= DATEADD(DAY, -1, CURRENTDATE);
        UPDATE T_StagingCustomers
        SET
                CustomerName = UPPER(CustomerName);
        UPDATE T_StagingOrders
        SET
                OrderAmountUSD = OrderAmount * ExchangeRate
        FROM
                T_StagingOrders O,
                CurrencyRates C
        WHERE
                O.CurrencyCode = C.CurrencyCode;
        MERGE INTO DataWarehouse.dbo.DimCustomers AS Target
        USING T_StagingCustomers AS Source
        ON Target.CustomerID = Source.CustomerID
        WHEN MATCHED THEN
            UPDATE SET
                Target.CustomerName = Source.CustomerName,
                Target.LastUpdated = Source.LastUpdated
        WHEN NOT MATCHED THEN
            INSERT (CustomerID, CustomerName, LastUpdated) VALUES (Source.CustomerID, Source.CustomerName, Source.LastUpdated);
        MERGE INTO DataWarehouse.dbo.FactOrders AS Target
        USING T_StagingOrders AS Source
        ON Target.OrderID = Source.OrderID
        WHEN MATCHED THEN
        UPDATE SET
                Target.OrderAmountUSD = Source.OrderAmountUSD,
                Target.OrderDate = Source.OrderDate
        WHEN NOT MATCHED THEN
        INSERT (OrderID, CustomerID, OrderAmountUSD, OrderDate) VALUES (Source.OrderID, Source.CustomerID, Source.OrderAmountUSD, Source.OrderDate);
        DROP TABLE IF EXISTS T_StagingCustomers;
        DROP TABLE IF EXISTS T_StagingOrders;
    END;
$$;