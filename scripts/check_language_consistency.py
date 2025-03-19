#!/usr/bin/env python3
import os
import json
import glob
import re

"""
This script checks for language code consistency across the project.
It verifies that:
1. JSON files have the @@locale property (but doesn't enforce what the value should be)
2. Language codes in UI components match the expected format
"""

def check_json_files():
    localization_files = glob.glob('assets/l10n/app_*.json')
    issues = []
    info_items = []
    
    for file_path in localization_files:
        # Extract filename-based language code
        filename = os.path.basename(file_path)
        expected_code = filename.replace('app_', '').replace('.json', '')
        
        try:
            with open(file_path, 'r', encoding='utf-8') as f:
                data = json.load(f)
                
                # Check if @@locale exists
                if "@@locale" not in data:
                    issues.append(f"Missing @@locale in {file_path}")
                    continue
                    
                # Just report differences as info, not issues (per our rules)
                actual_code = data["@@locale"]
                if actual_code != expected_code:
                    info_items.append(f"Note: In {file_path}: filename suggests '{expected_code}', but uses '{actual_code}'")
                    
        except Exception as e:
            issues.append(f"Error processing {file_path}: {e}")
    
    return issues, info_items

def check_dart_files():
    # Patterns to look for in Dart files
    code_patterns = [
        r"'code': 'zh', 'countryCode':",  # Should be using direct codes (zhhk, zhcn, zhtw)
        r"'code': 'pa', 'countryCode': 'PK'"  # Should be using pa_pk
    ]
    
    issues = []
    
    # Find all Dart files in lib directory
    dart_files = glob.glob('lib/**/*.dart', recursive=True)
    
    for file_path in dart_files:
        with open(file_path, 'r', encoding='utf-8') as f:
            content = f.read()
            
            for pattern in code_patterns:
                if re.search(pattern, content):
                    issues.append(f"Problematic language code pattern '{pattern}' found in {file_path}")
    
    return issues

def main():
    print("Checking language code consistency...")
    print("\nChecking JSON files:")
    json_issues, json_info = check_json_files()
    for issue in json_issues:
        print(f"- {issue}")
    
    if json_info:
        print("\nInformational notes (not problems, per our rules):")
        for info in json_info:
            print(f"- {info}")
    
    print("\nChecking Dart files:")
    dart_issues = check_dart_files()
    for issue in dart_issues:
        print(f"- {issue}")
    
    if json_issues or dart_issues:
        print(f"\nFound {len(json_issues) + len(dart_issues)} issues with language handling")
    else:
        print("\nNo language handling issues found! 🎉")
        if json_info:
            print(f"(There are {len(json_info)} informational notes about language codes, but these are acceptable per our rules)")

if __name__ == "__main__":
    main() 