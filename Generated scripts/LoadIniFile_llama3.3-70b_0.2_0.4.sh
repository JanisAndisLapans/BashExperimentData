#!/bin/bash

# Load settings from settings.ini into the current shell
while IFS="=" read -r key value; do
  # Ignore lines that start with a semicolon or are empty
  if [[ $key =~ ^[a-zA-Z] ]] && [[ $value =~ ^[a-zA-Z0-9] ]]; then
    # Remove leading and trailing whitespace from key and value
    key=$(echo "$key" | tr -d '[:space:]')
    value=$(echo "$value" | tr -d '[:space:]')
    # Export the key-value pair as an environment variable
    export "$key=$value"
  fi
done < settings.ini

# Print the loaded environment variables
for var in $(compgen -v); do
  echo "$var=${!var}"
done