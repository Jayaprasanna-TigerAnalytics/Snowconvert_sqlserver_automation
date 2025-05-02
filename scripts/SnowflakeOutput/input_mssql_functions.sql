CREATE OR REPLACE FUNCTION dbo.ufnGetAccountingStartDate ()
RETURNS TIMESTAMP_NTZ
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
	SELECT
CAST('20030701' AS TIMESTAMP_NTZ)
$$;;
CREATE OR REPLACE FUNCTION dbo.ufnGetAccountingEndDate ()
RETURNS TIMESTAMP_NTZ
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "transact",  "convertedOn": "05-02-2025",  "domain": "test" }}'
AS
$$
	SELECT
DATEADD(millisecond, -2, CAST('20040701' AS TIMESTAMP_NTZ))
$$;;
