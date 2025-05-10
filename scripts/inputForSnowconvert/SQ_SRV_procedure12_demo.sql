CREATE PROCEDURE ETL_Process
AS
BEGIN
    SET NOCOUNT ON;

    -- Step 1: Extract data from multiple sources
    DECLARE @CurrentDate DATE = GETDATE();

    -- Extract new records from source systems
    SELECT * INTO #StagingCustomers
    FROM SourceDB.dbo.Customers
    WHERE LastUpdated >= DATEADD(DAY, -1, @CurrentDate);

    SELECT * INTO #StagingOrders
    FROM SourceDB.dbo.Orders
    WHERE OrderDate >= DATEADD(DAY, -1, @CurrentDate);

    -- Step 2: Transform Data
    -- Example: Standardizing customer names
    UPDATE #StagingCustomers
    SET CustomerName = UPPER(CustomerName);

    -- Example: Converting order amounts to USD
    UPDATE #StagingOrders
    SET OrderAmountUSD = OrderAmount * ExchangeRate
    FROM #StagingOrders O
    JOIN CurrencyRates C ON O.CurrencyCode = C.CurrencyCode;

    -- Step 3: Load Data into the Data Warehouse
    MERGE INTO DataWarehouse.dbo.DimCustomers AS Target
    USING #StagingCustomers AS Source
    ON Target.CustomerID = Source.CustomerID
    WHEN MATCHED THEN 
        UPDATE SET Target.CustomerName = Source.CustomerName, Target.LastUpdated = Source.LastUpdated
    WHEN NOT MATCHED THEN 
        INSERT (CustomerID, CustomerName, LastUpdated) VALUES (Source.CustomerID, Source.CustomerName, Source.LastUpdated);

    MERGE INTO DataWarehouse.dbo.FactOrders AS Target
    USING #StagingOrders AS Source
    ON Target.OrderID = Source.OrderID
    WHEN MATCHED THEN 
        UPDATE SET Target.OrderAmountUSD = Source.OrderAmountUSD, Target.OrderDate = Source.OrderDate
    WHEN NOT MATCHED THEN 
        INSERT (OrderID, CustomerID, OrderAmountUSD, OrderDate) VALUES (Source.OrderID, Source.CustomerID, Source.OrderAmountUSD, Source.OrderDate);

    -- Clean up
    DROP TABLE #StagingCustomers;
    DROP TABLE #StagingOrders;
END;
