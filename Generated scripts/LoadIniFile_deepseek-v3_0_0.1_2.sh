#!/bin/bash

# Read settings.ini and export variables to the current shell
while IFS='=' read -r key value; do
    # Remove leading/trailing whitespace and quotes from key and value
    key=$(echo "$key" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^"//' -e 's/"$//')
    value=$(echo "$value" | sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^"//' -e 's/"$//')
    
    # Skip empty lines and comments (lines starting with ; or #)
    if [[ -z "$key" ]] || [[ "$key" =~ ^[;#] ]]; then
        continue
    fi
    
    # Export the variable
    declare -g "$key"="$value"
    export "$key"
done < "settings.ini"