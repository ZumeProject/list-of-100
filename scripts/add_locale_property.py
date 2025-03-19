#!/usr/bin/env python3
import os
import json
import glob

"""
This script adds the @@locale property to all localization JSON files
in the assets/l10n directory if it's missing, using the filename as a guide.
It does NOT change existing @@locale values.
"""

def main():
    # Find all localization files
    localization_files = glob.glob('assets/l10n/app_*.json')
    
    updated_count = 0
    
    for file_path in localization_files:
        # Extract the language code from the filename
        filename = os.path.basename(file_path)
        lang_code = filename.replace('app_', '').replace('.json', '')
        
        # Read the JSON file
        with open(file_path, 'r', encoding='utf-8') as f:
            try:
                data = json.load(f)
            except json.JSONDecodeError as e:
                print(f"Error parsing {file_path}: {e}")
                continue
        
        # Check if @@locale property already exists - preserve it if it does
        if "@@locale" in data:
            print(f"Skipping {file_path}, @@locale already exists: {data['@@locale']}")
            continue
        
        # Add the @@locale property at the beginning of the data using the filename
        # Do not standardize or normalize the code - use exactly what's in the filename
        new_data = {"@@locale": lang_code}
        for key, value in data.items():
            new_data[key] = value
        
        # Write the updated JSON back to the file
        with open(file_path, 'w', encoding='utf-8') as f:
            json.dump(new_data, f, ensure_ascii=False, indent=2)
        
        print(f"Added @@locale: {lang_code} to {file_path}")
        updated_count += 1
    
    print(f"\nSummary: Added @@locale property to {updated_count} files out of {len(localization_files)} total files")

if __name__ == "__main__":
    main() 