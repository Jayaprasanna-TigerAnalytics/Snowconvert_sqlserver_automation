-- <copyright file="RAISERROR_UDF.sql" company="Snowflake Inc">
--        Copyright (c) 2019-2025 Snowflake Inc. All rights reserved.
-- </copyright>

-- =======================================================================================================
-- Description: The RAISERROR_UDF throws an exception with an specific message
-- =======================================================================================================

CREATE OR REPLACE FUNCTION RAISERROR_UDF(MSG_TEXT VARCHAR, SEVERITY DOUBLE, STATE DOUBLE, PARAMS ARRAY)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
IMMUTABLE
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "udf",  "convertedOn": "05-10-2025",  "domain": "test" }}'
AS
$$
    /**Regex for:
     * % [[flag] [width] [. precision] [{h | l}]] type
     * - flag: -, +, 0, #, ' ' 
     * - width: number
     * - precision: number
     * - {h | l} type : d, i, o, s, u, x, X
    */
    const regex = /%(\-|\+|0|#|'')*(\*|[0-9])*(.(\*|[0-9]))*(d|i|o|s|u|x|X)/g;
    const found = MSG_TEXT.match(regex);
    let paramIndex = 0
    for(let i=0; i < found.length; i++)
    {
        //Validate possible *.* expression
        if(found[i].match(/\*/g) != null)
        {
            const asterisks = found[i].match(/\*/g).length;
            const arguments = PARAMS.slice(paramIndex, paramIndex + asterisks);
            paramIndex = paramIndex + asterisks;
        }
    
        MSG_TEXT = MSG_TEXT.replace(found[i], PARAMS[paramIndex]);
        paramIndex++;
    }
    var MSG = `MESSAGE: ${MSG_TEXT}, LEVEL: ${SEVERITY}, STATE: ${STATE}`;
    if(SEVERITY <= 10) {
        return MSG;
    } else {
        throw MSG;
    }
$$;

CREATE OR REPLACE FUNCTION RAISERROR_UDF(MSG_ID DOUBLE, SEVERITY DOUBLE, STATE DOUBLE, PARAMS ARRAY)
RETURNS VARCHAR
LANGUAGE JAVASCRIPT
IMMUTABLE
COMMENT = '{ "origin": "sf_sc", "name": "snowconvert", "version": {  "major": 1,  "minor": 3,  "patch": "0.0" }, "attributes": {  "component": "udf",  "convertedOn": "05-10-2025",  "domain": "test" }}'
AS
$$
    var MSG = `MESSAGE: ${MSG_ID}, LEVEL: ${SEVERITY}, STATE: ${STATE}`;
    if(SEVERITY <= 10) {
        return MSG;
    } else {
        throw MSG;
    }
$$;