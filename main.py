import json
from src.batch_processor import SnowConvertProcessor
from src.file_processor import read_files
from src.config_manager import config
from src.sf_script_run import read_sf
from pathlib import Path
import os
from logs.logger import setup_logger

class Main:
    def __init__(self):
        self.logger = setup_logger()
        self.read_files=read_files()
        self.sf_script_run=read_sf()
        self.close_sf_connect=read_sf()
        self.script_dir = Path(__file__).resolve().parent
        self.batch_config_path = self.script_dir.parent /'snowconvert_automation' /'config' / 'batch_config.json'
        self.config_manager = config()
        self.df=self.config_manager.create_dataframe()
        self.SnowConvertProcessor=SnowConvertProcessor()

    def read_batch_config(self):
        # Step 1: Load JSON from file
        with open(self.batch_config_path, "r") as f:
            config = json.load(f)
        # Step 2: Convert top-level string paths to Path objects
        paths = {k: Path(v) if isinstance(v, str) and ":" in v else v for k, v in config.items()}
        return paths   

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
    #         self.logger.error(FileNotFoundError(f"Configuration file not found: {self.config_path}"))
    #     except json.JSONDecodeError:
    #         self.logger.error(ValueError(f"Invalid JSON in configuration file: {self.config_path}"))
    #     except Exception as e:
    #         self.logger.error(e)  


    def write_sql_file(self,ddls):
        self.output_path=self.read_batch_config()['snowflakefinalconvertoutput_dir']
        # print( "write",self.script_dir.parent)
        # self.output_path = self.script_dir.parent /'sqlserver_to_snowflake'/'scripts'/'SnowflakeOutput'
        # # directory_path = "./scripts/outputScripts"
        if not os.path.exists(self.output_path):
            os.makedirs(self.output_path)
        file_path = os.path.join(self.output_path, self.file_name)
        with open(file_path, 'w+', encoding='utf-8') as f:
            f.write(ddls)
            self.logger.info(f"{self.file_name} File is created successfully ...")



    def read_sql_file(self):
        """
        Read SQL file content.
        
        Args:
            file_path (str): Path to SQL file
            
        Returns:
            str: SQL content
        """
        # preprocess_sqls_file_path= self.read_json_batch_config()
        # file_path=Path(preprocess_sqls_file_path.get('preprocessed_dir'))
        # exact_file_path = Path(file_path).resolve()
        # self.scripts_dir = Path(__file__).resolve().parent
        # print("read",preprocess_sqls_file_path)
        exact_file_path = self.output_path=self.read_batch_config()["converted_dir"]
        # print(exact_file_path)
        for file in exact_file_path.glob('**/*.sql'):
            self.file_name = Path(file).name
            with open(file, 'r', encoding='utf-8') as f:
                ddls = f.read()
                final_ddls=self.read_files.read_each_ddl(ddls)
                self.write_sql_file(final_ddls)
    def execute_sf_script(self):
        source_path=self.read_batch_config()["snowflakefinalconvertoutput_dir"]
        for filename in os.listdir(source_path):
            if filename.endswith('.sql'):
                file_path = os.path.join(source_path, filename)
                self.sf_script_run.write_sql_file(file_path)
                self.logger.info(f"{file_path} File is created successfully ...")   
                  
    def main(self):
        self.SnowConvertProcessor.driver()
        self.read_sql_file()
        self.execute_sf_script()
        self.close_sf_connect.close_connection()
        

if __name__ == '__main__':
    obj=Main()
    obj.main()
