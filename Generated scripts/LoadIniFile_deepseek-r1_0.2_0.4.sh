#!/bin/bash
while IFS='=' read -r key_temp value_temp; do
    # Trim whitespace and quotes from key and value
    key=$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^"//' -e 's/"$//' <<< "$key_temp")
    value=$(sed -e 's/^[[:space:]]*//' -e 's/[[:space:]]*$//' -e 's/^"//' -e 's/"$//' <<< "$value_temp")
    # Skip empty keys and system-like variables
    if [[ -n "$key" && ! "$key" =~ ^[0-9] && "$key" != *=* ]]; then
        export "$key"="$value"
    fi
done < <(grep -vE '^[[:space:]]*([;#]|\[|$)' settings.ini)