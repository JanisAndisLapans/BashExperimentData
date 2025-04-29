#!/bin/bash

# Path to the settings.ini file
INI_FILE="settings.ini"

# Check if the file exists
if [[ ! -f "$INI_FILE" ]]; then
    echo "File $INI_FILE not found."
    exit 1
fi

# Read the ini file and export variables
while IFS='= ' read -r key value
do
    # Remove leading/trailing whitespace
    key=$(echo "$key" | sed 's/^[ \t]*//;s/[ \t]*$//')
    value=$(echo "$value" | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Skip empty lines and comments
    if [[ -z "$key" || "$key" =~ ^\; || "$key" =~ ^\# || "$key" =~ ^\[.*\] ]]; then
        continue
    fi

    # Export the variable
    export "$key"="$value"
done < "$INI_FILE"