#!/bin/bash

# Function to parse the ini file
parse_ini_file() {
    local ini_file="$1"
    local section=""
    while IFS= read -r line || [ -n "$line" ]; do
        # Remove leading/trailing whitespace
        line=$(echo "$line" | sed 's/^[ \t]*//;s/[ \t]*$//')
        
        # Skip comments and empty lines
        if [[ "$line" =~ ^\; || "$line" =~ ^# || -z "$line" ]]; then
            continue
        fi
        
        # Handle section headers
        if [[ "$line" =~ ^\[(.*)\]$ ]]; then
            section="${BASH_REMATCH[1]}"
            continue
        fi
        
        # Handle key-value pairs
        if [[ "$line" =~ ^([^=]+)=(.*)$ ]]; then
            key="${BASH_REMATCH[1]}"
            value="${BASH_REMATCH[2]}"
            # Export the variable with section prefix if section is not empty
            if [ -n "$section" ]; then
                export "${section}_${key}"="$value"
            else
                export "$key"="$value"
            fi
        fi
    done < "$ini_file"
}

# Usage
parse_ini_file "settings.ini"