#!/bin/bash

# Load settings from settings.ini file
while IFS="=" read -r key value; do
  # Ignore lines that start with a semicolon or are empty
  if [ -z "$key" ] || [[ $key =~ ^\; ]] || [[ $key =~ ^# ]]; then
    continue
  fi

  # Remove leading and trailing whitespace from key and value
  key=$(echo "$key" | tr -d '[:space:]')
  value=$(echo "$value" | tr -d '[:space:]')

  # Export key-value pair as environment variable
  export "$key=$value"
done < settings.ini

# Print loaded settings
for key in $(compgen -v); do
  echo "$key=${!key}"
done