CREATE OR REPLACE PROCEDURE ManageEmployeeData (ACTION STRING,
EMPLOYEEID INT DEFAULT NULL,
FIRSTNAME STRING DEFAULT NULL,
LASTNAME STRING DEFAULT NULL,
DEPARTMENTID INT DEFAULT NULL,
SALARY DECIMAL(18, 2) DEFAULT NULL
)
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-10-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS
$$
    DECLARE
        ERRORMESSAGE VARCHAR(4000);
    BEGIN
        
        BEGIN
            BEGIN TRANSACTION;
            IF (ACTION = 'Add') THEN
                BEGIN
                    INSERT INTO Employees (FirstName, LastName, DepartmentID, Salary)
                    VALUES (FIRSTNAME, LASTNAME, DEPARTMENTID, SALARY);
                    RETURN 'Employee added successfully.';
                END;
            ELSEIF (ACTION = 'Update') THEN
                BEGIN
                    IF (EMPLOYEEID IS NULL) THEN
                        BEGIN
                                                        SELECT
                                RAISERROR_UDF('EmployeeID is required for update action.', 16, 1, array_construct());
                            RETURN NULL;
                        END;
                    END IF;
                UPDATE Employees
                SET
                            DepartmentID = DEPARTMENTID,
                            Salary = SALARY
                WHERE
                            EmployeeID = EMPLOYEEID;
                RETURN 'Employee updated successfully.';
                END;
            ELSEIF (ACTION = 'Get') THEN
                BEGIN
                    IF (DEPARTMENTID IS NULL) THEN
                        BEGIN
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
                        DepartmentID = DEPARTMENTID;
                END;
            END IF;
            COMMIT;
        EXCEPTION
            WHEN OTHER THEN
                ROLLBACK;
                ERRORMESSAGE := SQLERRM ;
                RETURN 'Error: ' || ErrorMessage;
                LET DECLARED_EXCEPTION EXCEPTION;
                RAISE DECLARED_EXCEPTION;
        END;
    END;
$$;;
