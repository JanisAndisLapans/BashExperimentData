#!/bin/bash

# Load settings from settings.ini into the current shell
while IFS="=" read -r key value; do
  key=$(echo "$key" | tr -d '[:space:]')
  value=$(echo "$value" | tr -d '[:space:]')
  declare "$key=$value"
done < <(grep -v '^#' settings.ini | grep -v '^$' | sed 's/^[[:space:]]*//;s/[[:space:]]*$//')