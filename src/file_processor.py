"""
File Processing Module for SnowConvert Automation.
Handles SQL file reading, pattern matching, and transformations.
"""
import os
import re
from pathlib import Path
from typing import List, Dict, Any, Optional, Tuple, Callable
import json

from src.config_manager import config
from src.rule_handlers import rule_handler
from logs.logger import setup_logger

# from src.rule_handlers import preprocess_format_in_ddl, postprocess_interval_to_varchar, call_func_by_name

class read_files:
    def __init__(self):
        # self.script_dir = Path(__file__).resolve().parent
        # self.config_path = self.script_dir.parent / 'config' / 'batch_config.json'
        self.config_manager = config()
        self.df=self.config_manager.create_dataframe()
        self.logger = setup_logger()
        # self.rule_handlers=rule_handler()

    # def read_json_batch_config(self):
    #     """
    #     Read JSON configuration file.
        
    #     Returns:
    #         dict: Configuration data
    #     """
    #     try:
    #         with open(self.config_path, 'r') as f:
    #             return json.load(f)
    #     except FileNotFoundError:
    #         logger.error(FileNotFoundError(f"Configuration file not found: {self.config_path}"))
    #     except json.JSONDecodeError:
    #         logger.error(ValueError(f"Invalid JSON in configuration file: {self.config_path}"))  

    # def read_sql_file(self):
    #     """
    #     Read SQL file content.
        
    #     Args:
    #         file_path (str): Path to SQL file
            
    #     Returns:
    #         str: SQL content
    #     """
    #     # preprocess_sqls_file_path= self.read_json_batch_config()
    #     # file_path=Path(preprocess_sqls_file_path.get('preprocessed_dir'))
    #     # exact_file_path = Path(file_path).resolve()
    #     # self.script_dir = Path(__file__).resolve().parent
    #     exact_file_path = self.script_dir.parent / 'scripts' / 'inputScripts'
    #     for file in exact_file_path.glob('*.sql'):
    #         with open(file, 'r', encoding='utf-8') as f:
    #             sql_content = f.read()
    #     return sql_content


    # def clean_sql_content(self) :
    #     """
    #     Clean SQL content by removing comments and standardizing whitespace.
        
    #     Args:
    #         sql_content (str): SQL content to clean
            
    #     Returns:
    #         str: Cleaned SQL content
    #     """
    #     # Remove single-line comments
    #     sql_content =self.read_sql_file()
    #     return sql_content
    

    def preprocess_format_in_ddl(self,sql_content, pattern):
        """
        Remove FORMAT clauses from DDL statements.
        
        Args:
            SQL content to process
            
        Returns:
            Processed SQL and transformation details
        """
        transformations = []
        
        def replace_format(match):
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'remove_format',
                'original': match.group(0),
                'replacement': ''
            })
            return ''
        
        processed_sql = re.sub(pattern, replace_format, sql_content)
        return processed_sql, transformations
    def timestamp_ntz(self,sql_content, pattern):
        """
        Remove FORMAT clauses from DDL statements.
        
        Args:
            SQL content to process
            
        Returns:
            Processed SQL and transformation details
        """
        transformations = []
        
        def replace_format(match):
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'remove_format',
                'original': match.group(0),
                'replacement': ''
            })
            return 'TIMESTAMP_NTZ'
        
        processed_sql = re.sub(pattern, replace_format, sql_content)
        return processed_sql, transformations  

    def remove_in_in_check(self,sql_content, pattern):
        transformations = []

        def replacer(match):
            original = match.group(0)
            before_in = match.group(1)  # everything before 'IN'
            after_in = match.group(2)   # everything after 'IN'
            replacement = before_in + after_in  # Concatenate without 'IN'
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'remove_in_from_check',
                'original': original,
                'replacement': replacement
            })
            return replacement

        processed_sql = re.sub(pattern, replacer, sql_content)
        return processed_sql,transformations

    def preprocess_boolean_default(self,sql_content, pattern):
        """
        Remove DEFAULT(0) or DEFAULT(1) from BOOLEAN declarations in SQL DDL.

        Args:
            sql_content (str): SQL content to process
            pattern (str): Regex pattern to identify BOOLEAN with DEFAULT(0|1)
            type (str): Action to take ('remove' or 'replace')

        Returns:
            Tuple: Processed SQL string and list of transformation logs
        """
        transformations = []

        def replacer(match):
            original = match.group(0)
            replacement = re.sub(pattern, r"\1", original)
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'remove_boolean_default',
                'original': original,
                'replacement': replacement
            })
            return replacement

        processed_sql = re.sub(pattern, replacer, sql_content)
        return processed_sql, transformations
    
    def clean_variant_definitions(self,sql_content,pattern):
        transformations = []

        def replacer(match):
            original = match.group(0)
            retained = match.group(1).strip()
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'normalize_variant',
                'original': original,
                'replacement': retained
            })
            return retained

        # Matches:
        # - VARIANT
        # - VARIANT NOT NULL
        # followed by DEFAULT (...) or AS NVL(...)
        pattern = re.compile(
            pattern,
            re.IGNORECASE
        )

        processed_sql = pattern.sub(replacer, sql_content)
        return processed_sql, transformations

    def preprocess_time_precision(self,sql_content, pattern):
        """
        Remove precision from TIME data type (e.g., TIME(7) becomes TIME).
        
        Args:
            sql_content (str): SQL content to process
            pattern (str): Regex pattern to find the TIME(precision) usage
        
        Returns:
            str: Processed SQL content
            list: Transformation details
        """
        transformations = []

        def replace_time(match):
            original = match.group(0)
            replacement = "TIME"  # Remove precision part, keep "TIME"
            
            # Log the transformation details
            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'remove_time_precision',
                'original': original,
                'replacement': replacement
            })
            
            return replacement

        # Pattern to match TIME(precision) and replace with TIME
        processed_sql = re.sub(pattern, replace_time, sql_content)
        return processed_sql, transformations

    def convert_insert_statement(self,sql_content):
        transformations = []
        
        # Updated regex to match multiple CAST(SERVERPROPERTY(...)) parts across lines
        pattern = re.compile(
            r"CAST\s*\(\s*SERVERPROPERTY\s*\(\s*'([^']+)'\s*\)\s*AS\s*[^)]+\)", 
            re.IGNORECASE | re.DOTALL
        )

        def replacer(match):
            param = match.group(1)
            replacements = {
                "ProductVersion": "CURRENT_VERSION()",
                "ResourceLastUpdateDateTime": "CURRENT_TIMESTAMP()"
            }
            if param in replacements:
                replacement = replacements[param]
                transformations.append({
                    'line_number': sql_content[:match.start()].count('\n') + 1,
                    'action': 'replace_serverproperty_cast',
                    'original': match.group(0),
                    'replacement': replacement
                })
                return replacement
            return match.group(0)

        transformed_sql = pattern.sub(replacer, sql_content)
        return transformed_sql, transformations

    def convert_boolean_defaults(self,sql):
        # Replace BOOLEAN DEFAULT (0) → BOOLEAN DEFAULT FALSE
        sql = re.sub(
            r"\b(BOOLEAN(?:\s+NOT\s+NULL)?)\s+DEFAULT\s*\(\s*0\s*\)",
            r"\1 DEFAULT FALSE",
            sql,
            flags=re.IGNORECASE
        )

        # Replace BOOLEAN DEFAULT (1) → BOOLEAN DEFAULT TRUE
        sql = re.sub(
            r"\b(BOOLEAN(?:\s+NOT\s+NULL)?)\s+DEFAULT\s*\(\s*1\s*\)",
            r"\1 DEFAULT TRUE",
            sql,
            flags=re.IGNORECASE
        )

        return sql


   
    def json_parse(self, sql_content, pattern):
        """
        Transform JSON_VALUE syntax to Snowflake-compatible PARSE_JSON format.
        For example: JSON_VALUE(ProductSpecs, '$.Processor') → PARSE_JSON(ProductSpecs):Processor::STRING

        Args:
            sql_content (str): SQL content to process.
            pattern (re.Pattern): Compiled regex pattern to match JSON_VALUE syntax.

        Returns:
            str: Transformed SQL content.
            list: List of transformations applied.
        """
        transformations = []

        def replacer(match):
            original = match.group(0)
            column = match.group(1).strip()
            key_path = match.group(2).strip().strip("$.")  # Remove $. prefix
            replacement = f"PARSE_JSON({column}):{key_path}::STRING"

            transformations.append({
                'line_number': sql_content[:match.start()].count('\n') + 1,
                'action': 'convert_json_value',
                'original': original,
                'replacement': replacement
            })
            return replacement

        # Updated pattern to match JSON_VALUE functions (e.g., JSON_VALUE(o.OrderData, '$.customer.name'))
        # updated_pattern = re.compile(r"JSON_VALUE\((\w+)\s*,\s*'(\$.+?)'\)", re.IGNORECASE)
        
        # Apply the transformation using the updated pattern
        transformed_sql = re.sub(pattern, replacer, sql_content)

        return transformed_sql, transformations




    def replace_custom_zero_fill(self,sql_content):
        """
        Replace zero-fill UDFs (with or without schema) with LPAD equivalents.

        Args:
            sql_content (str): SQL content to process.

        Returns:
            str: Transformed SQL content.
            list: List of transformations made.
        """
        transformations = []

        def replacer(match):
            original = match.group(0)
            func = match.group(1)
            col = match.group(2)

            # Map functions to LPAD lengths
            pad_map = {
                "udfOneDigitZeroFill": 1,
                "udfTwoDigitZeroFill": 2,
                "udfThreeDigitZeroFill": 3,
                "udfFourDigitZeroFill": 4,
            }

            if func in pad_map:
                replacement = f"LPAD({col}, {pad_map[func]}, '0')"
            else:
                replacement = original  # If unmatched, keep as-is

            transformations.append({
                'original': original,
                'replacement': replacement
            })

            return replacement

        pattern = re.compile(r"(?:\w+\.)?(udfOneDigitZeroFill|udfTwoDigitZeroFill|udfThreeDigitZeroFill|udfFourDigitZeroFill)\((\w+)\)", re.IGNORECASE)
        transformed_sql = pattern.sub(replacer, sql_content)

        return transformed_sql

    def replace_print_with_return(self,sql_content):
        """
        Replace 'PRINT' with 'RETURN' only inside CREATE PROCEDURE or FUNCTION blocks (between CREATE ... $$;).
        
        Args:
            sql_content (str): SQL string that may contain multiple DDLs.
        
        Returns:
            str: Modified SQL content.
            list: List of transformations applied.
        """
        transformations = []

        # Match CREATE ... PROCEDURE or FUNCTION ... $$ ... $$; blocks
        block_pattern = re.compile(r"(CREATE\s+(?:OR\s+REPLACE\s+)?(?:FUNCTION|PROCEDURE)[\s\S]+?\$\$)([\s\S]*?)(\$\$;)", re.IGNORECASE)

        def block_replacer(match):
            full_block = match.group(0)
            header = match.group(1)
            body = match.group(2)
            footer = match.group(3)

            # Replace only standalone PRINT statements (not part of string literals or function names)
            new_body = re.sub(r"\bPRINT\b", "RETURN", body, flags=re.IGNORECASE)

            if new_body != body:
                transformations.append({
                    'original': full_block,
                    'replacement': header + new_body + footer
                })

            return header + new_body + footer

        transformed_sql = block_pattern.sub(block_replacer, sql_content)
        return transformed_sql
    def replace_variant_as_expression(self, sql_content):
        """
        Replaces 'VARIANT AS ...' where the expression contains arithmetic operators 
        with 'NUMERIC' instead of 'VARIANT'.

        Args:
            sql_content (str): The SQL string.

        Returns:
            str: Transformed SQL string.
            list: List of transformations made.
        """
        transformations = []

        # Regex to find lines like 'VARIANT AS some_expr * some_other_expr'
        pattern = re.compile(r'\bVARIANT\b\s+AS\s+[^,\n;]+?[\*\+\-/][^,\n;]*', re.IGNORECASE)

        def replacer(match):
            original = match.group(0)
            replacement = re.sub(r'\bVARIANT\b', 'NUMERIC(18,2)', original, flags=re.IGNORECASE)
            transformations.append({
                'original': original,
                'replacement': replacement
            })
            return replacement

        transformed_sql = pattern.sub(replacer, sql_content)
        return transformed_sql
    def remove_unquoted_colons(self,sql):
        transformations = []

        # Matches :Word when not inside double quotes
        pattern = re.compile(r'(?<!"):(\b\w+\b)(?!")')

        def replacer(match):
            original = match.group(0)
            replacement = match.group(1)
            transformations.append({
                'original': original,
                'replacement': replacement
            })
            return replacement

        result = pattern.sub(replacer, sql)
        return result   



    def call_func_by_name(self,func_name, *args, **kwargs):
        """
        Call a function by name if it's available in the current module.

        Args:
            func_name (str): Name of the function as a string.
            *args: Positional arguments to pass to the function.
            **kwargs: Keyword arguments to pass to the function.

        Returns:
            Any: Return value of the called function.

        Raises:
            AttributeError: If the function is not found in the current module.
        """
        func = getattr(self, func_name, None)
        if not func:
            self.logger.error( AttributeError(f"Function '{func_name}' not found in current module."))
        return func(*args, **kwargs)
    
    def read_each_ddl(self,ddls):
        # ddls = self.read_sql_file()
        for index, row in self.df.iterrows():
            pattern = row['Pattern(s)']
            if isinstance(pattern, list):
                pattern = pattern[0]
            if not isinstance(pattern, str) or not pattern.strip():
                # print(f"Skipping row {index}: invalid pattern → {pattern}")
                continue
            handler_function = row['Handler Function']
            ddls, transformations = self.call_func_by_name(handler_function, ddls, pattern)
        # print(ddls)    
            # ddls = processed_sql  # update for next loop
        # sql_content =self.read_sql_file()
        try:
            ddls = re.sub(r"--\*\*.*?\*\*\n?", "", ddls)  # Remove line comments with --**
        except Exception as e:
            self.logger.error("--\*\*.*?\*\*\n?"+"---->",str(e))
        try:        
            ddls = re.sub(r"/\*\*.*?\*/", "", ddls, flags=re.DOTALL)  # Remove block comments /*** ***/
        except Exception  as e:
            self.logger.error("/\*\*.*?\*/"+"---->",str(e))
        try:       
            ddls = re.sub(r"!!!.*?!!!\n?", "", ddls)
        except  Exception  as e:
            self.logger.error("!!!.*?!!!\n?"+"---->",str(e)) 
        try:       
            ddls = re.sub(r"!!!", "", ddls)
        except  Exception as e:
            self.logger.error("!!!"+"---->",str(e))
        try:        
            ddls = re.sub(r"\n\s*\n", "\n", ddls).strip()
        except  Exception as e:
            self.logger.error("\n\s*\n"+"---->",str(e))
        try:        
            ddls = re.sub(r"^\t{2,}\s*", "", ddls, flags=re.MULTILINE) 
        except  Exception as e:
            self.logger.error("^\t{2,}\s*"+"---->",str(e)) 
        try:        
            ddls = re.sub(r"\s+DEFAULT", " DEFAULT", ddls)
        except  Exception as e:
            self.logger.error("\s+DEFAULT"+"---->",str(e)) 
        try:        
            ddls = re.sub(r"\s*--.*", "", ddls)
        except  Exception as e:
            self.logger.error("\s*--.*"+"---->",str(e)) 
        try:        
            ddls = re.sub(r",+\s*(?=\))", "", ddls , flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error(",+\s*(?=\))"+"---->",str(e))
        try:          
            ddls,trans=self.convert_insert_statement(ddls)
        except  Exception as e:
            self.logger.error("convert_insert_statement function"+"---->",str(e)) 
        try:        
            ddls=re.sub(r"\b(VARIANT(?:\s+NOT\s+NULL)?)\s+DEFAULT\s*\(\s*[^()]*\s*\)",r"\1",ddls,flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error("\b(VARIANT(?:\s+NOT\s+NULL)?)\s+DEFAULT\s*\(\s*[^()]*\s*\)"+"---->",str(e))  
        try:        
            ddls=self.convert_boolean_defaults(ddls)
        except  Exception as e:
            self.logger.error("convert_boolean_defaults function"+"---->",str(e))
        try:
            ddls = re.sub(r"\(\s*(CURRENT_VERSION\(\)|CURRENT_TIMESTAMP\(\))\s*\)", r"(\1", ddls)
        except  Exception as e:
            self.logger.error("\(\s*(CURRENT_VERSION\(\)|CURRENT_TIMESTAMP\(\))\s*\)"+"---->",str(e))  
        try:
            ddls =re.sub(r',+', ',', ddls) 
        except  Exception as e:
            self.logger.error(",+"+"---->",str(e))
        # try:
        #     ddls = re.sub(r'\bPRINT\b', 'RETURN', ddls, flags=re.IGNORECASE)
        # except  Exception as e:
        #     self.logger.error("PRINT"+"---->",str(e))
        try:
            ddls = re.sub(r"\bSET\s+NOCOUNT\s+ON\b\s*;?", '', ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error("\bSET\s+NOCOUNT\s+ON\b\s*;?"+"---->",str(e))
        try:
            ddls = re.sub(r'\bROLLBACK\s+TRANSACTION\b', 'ROLLBACK', ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error("\bROLLBACK\s+TRANSACTION\b"+"---->",str(e))  
        try:
            ddls = re.sub(r"\+\s*@ErrorMessage\b", r"|| ErrorMessage", ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error("\+\s*@ErrorMessage\b"+"---->",str(e))            
        
        try:
            ddls = re.sub(r";\s*,", r";", ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error(";\s*,"+"---->",str(e))   
        try:
            ddls = re.sub(r",\s*(?=CREATE\b)", "", ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error(",\s*(?=\s*CREATE\b)"+"---->",str(e))   
        try:
            ddls = re.sub(r",[\s\r\n]*(?=CREATE\b)", "", ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error(",[\s\r\n]*(?=CREATE\b)"+"---->",str(e)) 
        try:
            ddls=self.replace_custom_zero_fill(ddls)
        except Exception as e:
            self.logger.error("zero fill error --->",str(e)) 
        try:
            ddls=self.replace_print_with_return(ddls)
        except Exception as e:
            self.logger.error("replace print with return  --->",str(e))               
        try:
            ddls = re.sub(r'\bPRINT\b', '---PRINT', ddls, flags=re.IGNORECASE)
        except  Exception as e:
            self.logger.error("PRINT"+"---->",str(e))

        try:
            ddls=self.replace_variant_as_expression(ddls)
        except  Exception as e:
            self.logger.error("VARIANT WITH (*/-/+/) REPLACED BY NUMARIC "+"---->",str(e))        
        
        try:
            ddls=self.remove_unquoted_colons(ddls)
        except  Exception as e:
            self.logger.error("remove : from parameters "+"---->",str(e)) 

        try:
            ddls = re.sub(r"(^\s*)(SET\s+QUOTED_IDENTIFIER\s+(ON|OFF);?)", r'\1-- \2', ddls, flags=re.IGNORECASE | re.MULTILINE)
        except  Exception as e:
            self.logger.error("remove : from parameters "+"---->",str(e))     

        return ddls
        # Remove multi-line comments
        # self.script_dir = Path(__file__).resolve().parent
        # self.output_path = self.script_dir.parent / 'scripts/outputScripts'
        # # # directory_path = "./scripts/outputScripts"
        # if not os.path.exists(self.output_path):
        #     os.makedirs(self.output_path)
        # file_path = os.path.join(self.output_path, "sample_output.sql")   
        # with open(file_path, 'w+', encoding='utf-8') as f:
        #     f.write(ddls)
            
    # def read_sql_file(self):
    #     sql=self.read_each_ddl()
        
