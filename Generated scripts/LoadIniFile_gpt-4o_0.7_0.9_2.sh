#!/bin/bash

# Define the path to the ini file
INI_FILE="settings.ini"

# Read and export variables from the ini file
while IFS='=' read -r key value; do
    # Skip lines that are empty or start with a semicolon or a hash
    [[ -z "$key" || "$key" =~ ^[;\#] ]] && continue

    # Trim whitespace and export the variable
    key=$(echo "$key" | xargs)
    value=$(echo "$value" | xargs)
    export "$key"="$value"
done < "$INI_FILE"