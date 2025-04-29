#!/bin/bash

# Define the path to the settings.ini file
INI_FILE="settings.ini"

# Read the ini file and export variables
while IFS='=' read -r key value; do
    # Skip lines that are comments or empty
    [[ "$key" =~ ^\s*# ]] || [[ -z "$key" ]] && continue
    # Trim whitespace and export the variable
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    export "$key"="$value"
done < <(grep -v '^\[' "$INI_FILE")