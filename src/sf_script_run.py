import snowflake.connector
import re
import json
import yaml
import os
import json
from pathlib import Path
import sqlparse
from logs.logger import setup_logger
from snowflake.connector.errors import DatabaseError, OperationalError, ProgrammingError #PS0505
# from src.config_manager import config
# from src.rule_handlers import rule_handler

class read_sf:
    def __init__(self):
        self.script_dir = Path(__file__).resolve().parent
        self.config_path = self.script_dir.parent / 'config' / 'config.yaml'
        self.batch_config_path = self.script_dir.parent / 'config' / 'batch_config.json'
        # print(self.config_path)
        self.logger = setup_logger()
        # self.rule_handlers=rule_handler()
        self.conn = None #PS0505
        self.cursor = None #PS0505

    def read_batch_config(self):
        # Step 1: Load JSON from file
        try:
            with open(self.batch_config_path, "r") as f:
                config = json.load(f)
            # Step 2: Convert top-level string paths to Path objects
            paths = {k: Path(v) if isinstance(v, str) and ":" in v else v for k, v in config.items()}
            return paths
        except Exception as e:
            self.logger.error("Error in batch congig file",str(e))

        # Step 3: Example usage
        # input_dir = paths["input_dir"]
        # converted_dir = paths["converted_dir"]

        # # Use the paths (e.g., list files in input_dir)
        # print(f"Listing files in: {input_dir}")
        # for file in input_dir.glob("*.sql"):
        #     print(f" - {file.name}")



    def read_sf_config(self):
            """
            Read SF configuration file.
            
            Returns:
                connection details
            """
            try:
                with open(self.config_path, 'r') as f:
                    return yaml.safe_load(f)
            except FileNotFoundError:
                self.logger.error(FileNotFoundError(f"Configuration file not found: {self.config_path}"))
            except json.JSONDecodeError:
                self.logger.error(ValueError(f"Invalid JSON in configuration file: {self.config_path}"))  


    def sf_connect(self):
        if self.conn and self.cursor: #PS0505
            return self.cursor  # reuse #PS0505
        
        data=self.read_sf_config()
        try:#PS0505
            self.conn=snowflake.connector.connect( #PS0505
                user=data['user'],
                password=data['password'],
                account=data['account'],
                warehouse=data['warehouse'],
                database=data['database'],
                schema=data['schema'],
            )
        
            self.cursor=self.conn.cursor() #PS0505
            self.logger.info("Connected to Snowflake successfully.")
            return self.cursor #PS0505
        
        except Exception as e:
            self.logger.error("Failed to establish Snowflake connection ",str(e))
            if hasattr(self, 'logger'): #PS0505 ADDED below 3 lines to check if SF logs can be added to log file
                self.logger.error(f" Snowflake connection failed: {e}")
            # raise
        except (DatabaseError, OperationalError, ProgrammingError) as e: #PS0505
            # Extract Snowflake-specific error details
            err_code = getattr(e, 'errno', None)
            sql_state = getattr(e, 'sqlstate', None)
            msg = str(e)
            self.logger.error(f"Snowflake Error - Code: {err_code}, SQLState: {sql_state}, Message: {msg}")
        


    def parse_sql_statement(self,clean_stmt):
        pattern=re.compile(
              r'(?i)(CREATE\s+(OR\s+REPLACE\s+)?|ALTER\s+)'
              r'(TABLE|FUNCTION|PROCEDURE|VIEW)\s+'
              r'(?:("?[a-zA-Z0-9_]+"?)\.)?("?[a-z-A-Z0-9_]+"?)',
              re.IGNORECASE
         )
        results=[]
        try:
            match=pattern.search(clean_stmt)
            if match:
                object_type=match.group(3).upper()
                schema_name=match.group(4)
                object_name=match.group(5)
                schema_name=schema_name.replace('"','') if schema_name else None
                object_name=object_name.replace('"','') if object_name else None

                results.append({
                    'object_type':object_type,
                    "schema_name":schema_name,
                    "object_name":object_name,
                    "ddl":clean_stmt
                })
            return results
        except Exception as e:
            self.logger.error("match is failed,due to some issues",str(e))

    def close_connection(self):
        if self.cursor:
            self.cursor.close()
        if self.conn:
            self.conn.close()

    def write_sql_file(self,source_file_name):
        self.file_path=source_file_name
        res=[]
        self.cursor = self.sf_connect()
        self.sfoutput_path=self.read_batch_config()['snowflakeoutput_dir']
        self.sfoutputerror_path=self.read_batch_config()['snowflakeerror_dir']
        if not os.path.exists(self.sfoutput_path):
            os.makedirs(self.sfoutput_path)
        if not os.path.exists(self.sfoutputerror_path):
            os.makedirs(self.sfoutputerror_path)
        self.sfoutputerror_path=os.path.join(self.sfoutputerror_path, self.file_path.split("\\")[-1])
        self.sfoutput_path=os.path.join(self.sfoutput_path, self.file_path.split("\\")[-1])
        
        with open(self.sfoutputerror_path, 'w+', encoding='utf-8') as f:
            f.write(f"")
        with open(self.sfoutput_path, 'w+', encoding='utf-8') as f:
            f.write(f"")
           
        with open(Path(self.file_path), 'r', encoding='utf-8-sig') as f: #PS0505 replaced   utf8 with utf-8-sig to ignore error (SQL compilation error:\nsyntax error line 1 at position 0 unexpected '\ufeff\n'.",) special characters
            sql_script=f.read()
        statements=[stmt.strip() for stmt in sqlparse.split(sql_script) if stmt.strip()]
        for statement in statements:
            # print(statement)
            result=self.parse_sql_statement(statement)
            res.extend(result)
        try:     
            if res:
                # print(res)
                self.cursor.execute("SHOW SCHEMAS")  # Fetch schemas ONCE
                schemas = [row[1].upper() for row in self.cursor.fetchall()]
                for r in res:
                    schema=r['schema_name']
                    table=r['object_name']
                    ddl=r['ddl']
                    if schema==None:
                        try:
                            self.logger.info(f"Using default schema 'public' for Object: {table}")
                            self.cursor.execute(f"use schema public")#Added PS0505
                            self.cursor.execute(ddl)#Added PS0505
                            self.logger.info(f"✅ Executed DDL in public schema: {table}")
                            with open(self.sfoutput_path, 'a+', encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n") #Commented PS0505
                        except (DatabaseError, OperationalError, ProgrammingError) as e: #PS0505
                            # Extract Snowflake-specific error details
                            err_code = getattr(e, 'errno', None)
                            sql_state = getattr(e, 'sqlstate', None)
                            msg = str(e)
                            self.logger.error(f"Snowflake Error - Code: {err_code}, SQLState: {sql_state}, Message: {msg}")
                            with open(self.sfoutputerror_path, 'a+') as f: #commented PS0505
                                f.write(f"{ddl+';'}\n")
                        except Exception as e:
                            self.logger.error("Due to schema none issue:-",str(e))  
                            with open(self.sfoutputerror_path, 'a+') as f: #commented PS0505
                                f.write(f"{ddl+';'}\n")          

                    elif schema.upper() in schemas:
                        try:
                            # self.logger.info(f"Executing DDL for existing schema '{schema}': {ddl}")
                            self.cursor.execute(ddl)
                            # self.logger.info(f"✅ Executed DDL: {ddl}")
                            with open(self.sfoutput_path, 'a+',encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n") 
                        except (DatabaseError, OperationalError, ProgrammingError) as e: #PS0505
                            # Extract Snowflake-specific error details
                            err_code = getattr(e, 'errno', None)
                            sql_state = getattr(e, 'sqlstate', None)
                            msg = str(e)
                            self.logger.error(f"Snowflake Error - Code: {err_code}, SQLState: {sql_state}, Message: {msg}")
                            with open(self.sfoutputerror_path, 'a+',encoding='utf-8') as f: #commented PS0505
                                f.write(f"{ddl+';'}\n")    
                        except Exception as e:
                            # self.logger.error(f"❌ Error executing DDL for schema '{schema}': {ddl}", exc_info=True)
                            with open(self.sfoutputerror_path, 'a+',encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")  
                    else:
                        try:
                            # self.logger.info(f"Creating missing schema '{schema}' and executing DDL: {ddl}")
                            self.cursor.execute(f"create or replace schema {schema}")
                            self.cursor.execute(ddl)
                            # self.logger.info(f"✅ Created schema and executed DDL: {ddl}")
                            with open(self.sfoutput_path, 'a+',encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")
                        except (DatabaseError, OperationalError, ProgrammingError) as e: #PS0505
                            # Extract Snowflake-specific error details
                            err_code = getattr(e, 'errno', None)
                            sql_state = getattr(e, 'sqlstate', None)
                            msg = str(e)
                            self.logger.error(f"Snowflake Error - Code: {err_code}, SQLState: {sql_state}, Message: {msg}")
                            with open(self.sfoutputerror_path, 'a+',encoding='utf-8') as f: #commented PS0505
                                f.write(f"{ddl+';'}\n")
                        except Exception as e:
                            # self.logger.error(f"❌ Error creating schema or executing DDL for '{schema}': {ddl}", exc_info=True)
                            with open(self.sfoutputerror_path, 'a+',encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")
        except Exception as e:
            self.logger.error(e)
            



