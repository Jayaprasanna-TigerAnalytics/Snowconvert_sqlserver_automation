CREATE PROCEDURE CustomerSegmentation
AS
BEGIN
    SET NOCOUNT ON;

    -- Temporary table to store segmentation
    CREATE TABLE #CustomerSegments (
        CustomerID INT,
        TotalSpent DECIMAL(18,2),
        PurchaseCount INT,
        Segment VARCHAR(20)
    );

    -- Calculate total spending and purchase count per customer
    INSERT INTO #CustomerSegments (CustomerID, TotalSpent, PurchaseCount)
    SELECT 
        CustomerID, 
        SUM(TotalAmount) AS TotalSpent, 
        COUNT(OrderID) AS PurchaseCount
    FROM SalesOrders
    GROUP BY CustomerID;

    -- Assign customer segments based on spending and purchase frequency
    UPDATE #CustomerSegments
    SET Segment = 
        CASE 
            WHEN TotalSpent > 10000 AND PurchaseCount > 50 THEN 'VIP'
            WHEN TotalSpent BETWEEN 5000 AND 10000 THEN 'Loyal'
            WHEN TotalSpent BETWEEN 1000 AND 5000 THEN 'Regular'
            ELSE 'Occasional'
        END;

    -- Select final segmentation results
    SELECT * FROM #CustomerSegments;

    -- Clean up
    DROP TABLE #CustomerSegments;
END;
