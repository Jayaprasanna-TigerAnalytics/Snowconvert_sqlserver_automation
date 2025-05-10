--** SSC-FDM-0007 - MISSING DEPENDENT OBJECTS "SourceDB.dbo.Customers", "SourceDB.dbo.Orders", "CurrencyRates", "DataWarehouse.dbo.DimCustomers", "DataWarehouse.dbo.FactOrders" **
CREATE OR REPLACE PROCEDURE ETL_Process ()
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE

        -- Step 1: Extract data from multiple sources
        CURRENTDATE DATE := CURRENT_TIMESTAMP() :: TIMESTAMP;
    BEGIN
        !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
        SET NOCOUNT ON;
         

        -- Extract new records from source systems
        CREATE OR REPLACE TEMPORARY TABLE T_StagingCustomers AS
            SELECT
                *
        FROM
                SourceDB.dbo.Customers
        WHERE
                LastUpdated >= DATEADD(DAY, -1, :CURRENTDATE);
        CREATE OR REPLACE TEMPORARY TABLE T_StagingOrders AS
            SELECT
                *
        FROM
                SourceDB.dbo.Orders
        WHERE
                OrderDate >= DATEADD(DAY, -1, :CURRENTDATE);

        -- Step 2: Transform Data
        -- Example: Standardizing customer names
        UPDATE T_StagingCustomers
        SET
                CustomerName = UPPER(CustomerName);

        -- Example: Converting order amounts to USD
        UPDATE T_StagingOrders
        SET
                OrderAmountUSD = OrderAmount * ExchangeRate
        FROM
                T_StagingOrders O,
                CurrencyRates C
        WHERE
                O.CurrencyCode = C.CurrencyCode;
        -- Step 3: Load Data into the Data Warehouse
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
        -- Clean up
        DROP TABLE IF EXISTS T_StagingCustomers;
        DROP TABLE IF EXISTS T_StagingOrders;
    END;
$$;