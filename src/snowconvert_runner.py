"""
SnowConvert Runner Module for SnowConvert Automation.
Handles integration with SnowConvert CLI tool.
"""
import subprocess
from pathlib import Path
from typing import Dict, Any, List, Optional

def run_snowconvert(
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
        "C:\\Users\\suvam.ghosh\\Downloads\\SnowConvert-CLI-windows\\orchestrator\\snowct.exe",
        #'snowct',
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

def process_conversion_results(
    results: Dict[str, Any],
    converted_dir: str
) -> List[Dict[str, Any]]:
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
        processed_files.append({
            'file': str(sql_file.relative_to(output_path)),
            'status': 'converted',
            'phase': 'conversion'
        })
    
    return processed_files 