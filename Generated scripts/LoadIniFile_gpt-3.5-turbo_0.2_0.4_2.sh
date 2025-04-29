#!/bin/bash

# Define the path to the settings.ini file
SETTINGS_FILE="settings.ini"

# Read the settings.ini file and set the variables in the current shell
while IFS='=' read -r key value; do
    key=$(echo "$key" | tr -d '[:space:]')  # Remove leading/trailing spaces from key
    value=$(echo "$value" | tr -d '[:space:]')  # Remove leading/trailing spaces from value
    if [[ $key && $value ]]; then
        export "$key"="$value"
    fi
done < "$SETTINGS_FILE"