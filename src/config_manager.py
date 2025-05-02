"""
Configuration Manager Module for SnowConvert Automation.
Handles loading and accessing error resolution patterns from JSON configuration.
"""
import re
import json
import os
import pandas as pd
from logs.logger import setup_logger

class config:
    def __init__(self):
        self.rows = []
        self.dict=dict()
        self.script_dir = os.path.dirname(os.path.abspath(__file__))
        self.json_path = os.path.join(self.script_dir, '..', 'config', 'error_resolution.json')
        self.logger = setup_logger()
    def load_config(self):
        with open(self.json_path, 'r') as f:
            try:
                self.logger.info("successfully read json data ...")
                return json.load(f)
            except FileNotFoundError:
                self.logger.error(FileNotFoundError(f"Configuration file not found: {self.json_path}"))
                return None
            except json.JSONDecodeError:
                self.logger.error(ValueError(f"Invalid JSON in configuration file: {self.json_path}"))
                return None
    def create_dict(self):
        try:
            data = self.load_config()
            for rule_id, rule_info in data['rules'].items():
                row = {
                        'Rule ID': rule_id,
                        'Name': rule_info.get('name'),
                        'Description': rule_info.get('description'),
                        'Category': rule_info.get('category'),
                        'Severity': rule_info.get('severity'),
                        'Priority': rule_info.get('priority'),
                        'Pattern(s)': rule_info.get('patterns'),
                        'Regex_explanation':rule_info.get("regex_explanation"),
                        'Handler Function': rule_info.get('rule_handler', {}).get('function'),
                        'Handler Type': rule_info.get('rule_handler', {}).get('type'),
                        'Validation Required': rule_info.get('rule_handler', {}).get('validation_required'),
                        'Test Matches': rule_info.get('test_cases', {}).get('matches'),
                    }
                self.rows.append(row)
            return self.rows        
        except Exception as e:
            self.logger.error(f"Error loading configuration: {e}")
            return None
    def create_dataframe(self):
        try:
            self.dict=self.create_dict()
            df=pd.DataFrame(self.dict)
            self.logger.info("Dataframe is created successfully ...")
            return df
        except Exception as e:
            self.logger.error(f"Error loading configuration: {e}")
            df=pd.DataFrame()
            return df

    

