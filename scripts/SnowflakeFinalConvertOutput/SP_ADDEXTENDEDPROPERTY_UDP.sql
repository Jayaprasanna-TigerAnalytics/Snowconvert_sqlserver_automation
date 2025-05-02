
CREATE OR REPLACE PROCEDURE SP_ADDEXTENDEDPROPERTY_UDP(
    name varchar, 
    value varchar, 
    level0type varchar DEFAULT '', 
    level0name varchar DEFAULT '',
    level1type varchar DEFAULT '', 
    level1name varchar DEFAULT '',
    level2type varchar DEFAULT '', 
    level2name varchar DEFAULT '')
RETURNS VARCHAR
LANGUAGE SQL
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 4,  "patch": "1.0" }, "attributes": {  "component": "udf",  "convertedOn": "05-02-2025",  "domain": "test" }}'
EXECUTE AS CALLER
AS 
   DECLARE  stmt VARCHAR;
            str_result VARCHAR;
BEGIN
    IF(lower(name) = 'ms_description') THEN
        IF (value IS NOT NULL) THEN
            IF(lower(level0type) = 'schema' and lower(level1type) = 'table' and lower(level2type) = 'column') THEN 
                stmt := 'COMMENT ON COLUMN ' || level0name || '.' || level1name || '.' || level2name || ' IS ''' || value || ''';';
            ELSEIF(lower(level0type) = 'schema' and lower(level1type) in ('table', 'view', 'procedure', 'function') and level2type IS NULL) THEN 
                stmt := 'COMMENT ON ' || upper(level1type) || ' ' || level0name || '.' || level1name || ' IS ''' || value || ''';';
            ELSEIF(lower(level0type) = 'schema' and level1type IS NULL) THEN 
                stmt := 'COMMENT ON ' || upper(level0type) || ' ' || level0name || ' IS ''' || value || ''';';
ELSE
                str_result := 'ERROR: COMMENT ON level0type: ' || level0type || ' | level1type: ' || nvl(level1type,'') || ' | level2type: ' || nvl(level2type,'') || ' is not supported yet.';
END IF;
            IF(stmt IS NOT NULL) THEN
                EXECUTE IMMEDIATE stmt;
                str_result := name || ' extended property was successfully created.';
END IF;
ELSE
            str_result := 'ERROR: NULL value for COMMENT ON is not supported.';
END IF;
ELSE
        str_result := 'ERROR: ' || name || ' extended property is not supported yet.';
END IF;
RETURN str_result;
END;