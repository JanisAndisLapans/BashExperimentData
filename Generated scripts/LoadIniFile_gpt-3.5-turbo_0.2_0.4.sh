#!/bin/bash

# Define the path to the settings.ini file
SETTINGS_FILE="settings.ini"

# Read the settings.ini file and set the variables in the current shell
while IFS='=' read -r key value; do
    if [[ $key && $value ]]; then
        export "$key"="$value"
    fi
done < "$SETTINGS_FILE"