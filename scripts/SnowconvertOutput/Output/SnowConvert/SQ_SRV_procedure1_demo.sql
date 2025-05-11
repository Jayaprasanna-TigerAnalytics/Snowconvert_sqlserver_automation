--** SSC-FDM-0007 - MISSING DEPENDENT OBJECT "Employees" **
CREATE OR REPLACE PROCEDURE ManageEmployeeData (ACTION STRING,  -- Action: 'Add', 'Update', 'Get'
EMPLOYEEID INT DEFAULT NULL,  -- Employee ID (used for update or get)
FIRSTNAME STRING DEFAULT NULL,  -- First Name (used for add)
LASTNAME STRING DEFAULT NULL,  -- Last Name (used for add)
DEPARTMENTID INT DEFAULT NULL,  -- Department ID (used for add or update)
SALARY DECIMAL(18, 2) DEFAULT NULL  -- Salary (used for add or update)
)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-11-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
  -- Salary (used for add or update)
    DECLARE
        ERRORMESSAGE VARCHAR(4000);
    BEGIN
        !!!RESOLVE EWI!!! /*** SSC-EWI-0040 - THE STATEMENT IS NOT SUPPORTED IN SNOWFLAKE ***/!!!
        SET NOCOUNT ON;
         
        BEGIN
            -- Begin Transaction for atomicity
            BEGIN TRANSACTION;
            IF (:ACTION = 'Add') THEN
                BEGIN
                    -- Insert new employee
                    INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary)
                    VALUES (:FIRSTNAME, :LASTNAME, :DEPARTMENTID, :SALARY);
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!

                    PRINT 'Employee added successfully.';
                END;
            ELSEIF (:ACTION = 'Update') THEN
                BEGIN
                    -- Update employee's department and salary based on EmployeeID
                    IF (:EMPLOYEEID IS NULL) THEN
                        BEGIN
                            --** SSC-FDM-TS0019 - RAISERROR ERROR MESSAGE MAY DIFFER BECAUSE OF THE SQL SERVER STRING FORMAT **
                            SELECT
                                RAISERROR_UDF('EmployeeID is required for update action.', 16, 1, array_construct());
                            RETURN NULL;
                        END;
                    END IF;

                UPDATE Employees
                SET
                            DepartmentID = :DEPARTMENTID,
                            Salary = :SALARY
                WHERE
                            EmployeeID = :EMPLOYEEID;
                    !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
                PRINT 'Employee updated successfully.';
                END;
            ELSEIF (:ACTION = 'Get') THEN
                BEGIN
                    -- Retrieve employees by department
                    IF (:DEPARTMENTID IS NULL) THEN
                        BEGIN
                            --** SSC-FDM-TS0019 - RAISERROR ERROR MESSAGE MAY DIFFER BECAUSE OF THE SQL SERVER STRING FORMAT **
                            SELECT
                                RAISERROR_UDF('DepartmentID is required for get action.', 16, 1, array_construct());
                            RETURN NULL;
                        END;
                    END IF;

                SELECT
                        EmployeeID,
                        FirstName,
                        LastName,
                        DepartmentID,
                        Salary
                FROM
                        Employees
                WHERE
                        DepartmentID = :DEPARTMENTID;
                END;
            END IF;

            -- Commit Transaction
            COMMIT;
        EXCEPTION
            WHEN OTHER THEN
                -- Rollback Transaction in case of error
                !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'ROLLBACK TRANSACTION' NODE ***/!!!
                ROLLBACK TRANSACTION;
                -- Get error message
                ERRORMESSAGE := SQLERRM /*** SSC-FDM-TS0023 - ERROR MESSAGE COULD BE DIFFERENT IN SNOWFLAKE ***/;
                !!!RESOLVE EWI!!! /*** SSC-EWI-0073 - PENDING FUNCTIONAL EQUIVALENCE REVIEW FOR 'PRINT' NODE ***/!!!
                PRINT 'Error: ' + @ErrorMessage;
                LET DECLARED_EXCEPTION EXCEPTION;
                RAISE DECLARED_EXCEPTION;
        END;
    END;
$$;