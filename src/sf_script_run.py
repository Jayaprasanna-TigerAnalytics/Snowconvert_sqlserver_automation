import snowflake.connector
import re
import json
import yaml
import os
import json
from pathlib import Path
import sqlparse
from logs.logger import setup_logger
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

        data=self.read_sf_config()
        conn=snowflake.connector.connect(
              user=data['user'],
              password=data['password'],
              account=data['account'],
              warehouse=data['warehouse'],
              database=data['database'],
              schema=data['schema'],
         )
        try:
            cusor=conn.cursor()
            return cusor
        except Exception as e:
            self.logger.error("connection is failed ",str(e))
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
           
        with open(Path(self.file_path), 'r', encoding='utf-8') as f:
            sql_script=f.read()
            
        statements=[stmt.strip() for stmt in sqlparse.split(sql_script) if stmt.strip()]
        # print(statements)
        for statement in statements:
             result=self.parse_sql_statement(statement) 
             res.extend(result)
        try:     
            if res:
                self.cursor.execute("SHOW SCHEMAS")  # Fetch schemas ONCE
                schemas = [row[1].upper() for row in self.cursor.fetchall()]
                for r in res:
                    schema=r['schema_name']
                    table=r['object_name']
                    ddl=r['ddl']
                    if schema==None:
                        try:
                            with open(self.sfoutputerror_path, 'a+', encoding='utf-8') as f:
                                    f.write(f"{ddl+';'}\n") 
                        except Exception as e:
                            self.logger.error("Due to schema none issue:-",str(e))            

                    elif schema.upper() in schemas:
                        try:
                            self.cursor.execute(ddl)
                            with open(self.sfoutput_path, 'a+', encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n") 
                            
                        except Exception as e:
                            with open(self.sfoutputerror_path, 'a+', encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")  
                    else:
                        try:
                            self.cursor.execute(f"create or replace schema {schema}")
                            self.cursor.execute(ddl)
                            with open(self.sfoutput_path, 'a+', encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")

                        except Exception as e:
                            with open(self.sfoutputerror_path, 'a+', encoding='utf-8') as f:
                                f.write(f"{ddl+';'}\n")
        except Exception as e:
            self.logger.error(e)



