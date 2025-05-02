"""
Rule Handlers Module for SnowConvert Automation.
Contains functions for processing different SQL transformation rules.
"""
import re
import sys
class rule_handler:
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
        func = getattr(sys.modules[__name__], func_name, None)
        if not func:
            self.logger.error( AttributeError(f"Function '{func_name}' not found in current module."))
        return func(*args, **kwargs)

