CREATE PROCEDURE ManageEmployeeData
    @Action VARCHAR(10),  -- Action: 'Add', 'Update', 'Get'
    @EmployeeID INT = NULL,  -- Employee ID (used for update or get)
    @FirstName VARCHAR(50) = NULL,  -- First Name (used for add)
    @LastName VARCHAR(50) = NULL,  -- Last Name (used for add)
    @DepartmentID INT = NULL,  -- Department ID (used for add or update)
    @Salary DECIMAL(18, 2) = NULL  -- Salary (used for add or update)
AS
BEGIN
    SET NOCOUNT ON;
    
    DECLARE @ErrorMessage NVARCHAR(4000);
    BEGIN TRY
        -- Begin Transaction for atomicity
        BEGIN TRANSACTION;

        IF @Action = 'Add'
        BEGIN
            -- Insert new employee
            INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary)
            VALUES (@FirstName, @LastName, @DepartmentID, @Salary);

            PRINT 'Employee added successfully.';
        END

        ELSE IF @Action = 'Update'
        BEGIN
            -- Update employee's department and salary based on EmployeeID
            IF @EmployeeID IS NULL
            BEGIN
                RAISERROR('EmployeeID is required for update action.', 16, 1);
                RETURN;
            END

            UPDATE Employees
            SET DepartmentID = @DepartmentID, Salary = @Salary
            WHERE EmployeeID = @EmployeeID;

            PRINT 'Employee updated successfully.';
        END

        ELSE IF @Action = 'Get'
        BEGIN
            -- Retrieve employees by department
            IF @DepartmentID IS NULL
            BEGIN
                RAISERROR('DepartmentID is required for get action.', 16, 1);
                RETURN;
            END

            SELECT EmployeeID, FirstName, LastName, DepartmentID, Salary
            FROM Employees
            WHERE DepartmentID = @DepartmentID;
        END

        -- Commit Transaction
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        -- Rollback Transaction in case of error
        ROLLBACK TRANSACTION;

        -- Get error message
        SET @ErrorMessage = ERROR_MESSAGE();
        PRINT 'Error: ' + @ErrorMessage;
        THROW;
    END CATCH
END;