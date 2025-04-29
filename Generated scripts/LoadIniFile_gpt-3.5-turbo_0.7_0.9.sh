#!/bin/bash

# Read the settings.ini file and assign variable values to current shell
while IFS='=' read -r key value; do
    # Skip lines starting with ; or empty lines
    if [[ $key == ";"* || -z $key ]]; then
        continue
    fi

    # Remove any leading/trailing whitespaces
    key=$(echo $key | sed 's/^[ \t]*//;s/[ \t]*$//')
    value=$(echo $value | sed 's/^[ \t]*//;s/[ \t]*$//')

    # Assign variable and value to current shell
    export $key="$value"
done < settings.ini