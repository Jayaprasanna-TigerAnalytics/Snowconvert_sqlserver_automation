import json
import os
from pathlib import Path
import subprocess
from typing import List, Dict, Any, Optional
from datetime import datetime

class SnowConvertProcessor:
    def __init__(self):
        self.script_dir = Path(__file__).resolve().parent


    def load_config(self, config_path: Optional[str] = None) -> Dict[str, Any]:
        """
        Load configuration from file or return defaults.
        
        Args:
            config_path (Optional[str]): Path to configuration file
            
        Returns:
            Dict[str, Any]: Configuration dictionary
        """
        if config_path:
            with open(config_path, 'r') as f:
                return json.load(f)
        raise FileNotFoundError("The file you requested does not exist")

    def driver(self):
        # Load configuration
        snow_convert_config_path = self.script_dir.parent/'config'/'batch_config.json'
        config = self.load_config(snow_convert_config_path)

        # Step 2: SnowConvert Conversion    
        # print("Step 2: Running SnowConvert conversion...")
        conversion_results = self.run_conversion(
            config['preprocessed_dir'],
            config['converted_dir'],
            config['snowconvert_config']
        )
        
       


    def run_snowconvert(
            self,
            input_dir: str,
            converted_dir: str,
            snowconvert_path: str = "snowconvert",
            config: Optional[Dict[str, Any]] = None
            ) -> Dict[str, Any]:
        """
        Run SnowConvert CLI tool on preprocessed files.
        
        Args:
            input_dir (str): Directory containing preprocessed SQL files
            converted_dir (str): Directory to write converted files
            snowconvert_path (str): Path to SnowConvert executable
            config (Optional[Dict[str, Any]]): Additional SnowConvert configurations
            
        Returns:
            Dict[str, Any]: Conversion results and status
        """
        # Create output directory if it doesn't exist
        output_path = Path(converted_dir)
        output_path.mkdir(parents=True, exist_ok=True)

        # Build SnowConvert command
        cmd = [
            # "C:\\Users\\jayaprasanna.gan\\Downloads\\SnowConvert-CLI-windows\\orchestrator\\snowct.exe",
            'snowct',
            f"{config['source']}",
            "--input", f"{str(Path(input_dir).absolute())}",
            "--output", f"{str(output_path.absolute())}"
        ]
        
        
        # Add any additional configurations
        # if config:
        #     print("Debug: Additional configurations:", config)
        #     for key, value in config.items():
        #         cmd.extend([f"--{key}", str(value)])
        
        try:
            # Run SnowConvert
            result = subprocess.run(
                cmd,
                capture_output=True,
                text=True,
                check=True
            )
            
            return {
                'status': 'success',
                'output': result.stdout,
                'command': ' '.join(cmd)
            }
            
        except subprocess.CalledProcessError as e:
            return {
                'status': 'error',
                'error': str(e),
                'output': e.stdout,
                'stderr': e.stderr,
                'command': ' '.join(cmd)
            }
        except Exception as e:
            return {
                'status': 'error',
                'error': str(e),
                'command': ' '.join(cmd)
            }
        

    def run_conversion(self, preprocessed_dir: str, converted_dir: str, snowconvert_config: Dict[str, Any] = None) -> List[Dict[str, Any]]:
        """
        Run SnowConvert on preprocessed files.
        
        Args:
            preprocessed_dir (str): Directory containing preprocessed files
            converted_dir (str): Directory to write converted files
            snowconvert_config (Dict[str, Any]): Additional SnowConvert configurations
            
        Returns:
            List[Dict[str, Any]]: Conversion results
        """
        # Run SnowConvert
        conversion_result = self.run_snowconvert(
            preprocessed_dir,
            converted_dir,
            config=snowconvert_config
        )
      
        
        # Process results
        return self.process_conversion_results(conversion_result, converted_dir)
    

    def process_conversion_results(self, results: Dict[str, Any], converted_dir: str) -> List[Dict[str, Any]]:
        """
        Process and validate SnowConvert conversion results.
        
        Args:
            results (Dict[str, Any]): Results from SnowConvert run
            converted_dir (str): Directory containing converted files
            
        Returns:
            List[Dict[str, Any]]: List of processed files and their status
        """
        processed_files = []
        output_path = Path(converted_dir)
        
        # If conversion failed, return error for all files
        if results['status'] == 'error':
            return [{
                'status': 'error',
                'error': results['error'],
                'phase': 'conversion'
            }]
        
        # Process each converted file
        for sql_file in output_path.glob('**/*.sql'):
            print(sql_file)
            processed_files.append({
                'file': str(sql_file.relative_to(output_path)),
                'status': 'converted',
                'phase': 'conversion'
            })
        
        return processed_files