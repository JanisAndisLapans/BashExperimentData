#!/bin/bash

# Load settings from settings.ini into the current shell
while IFS= read -r line; do
  # Ignore lines that start with a semicolon or are empty
  if [[ $line =~ ^\; ]] || [[ -z ${line// /} ]]; then
    continue
  fi
  # Split the line into key and value
  key=$(echo "$line" | cut -d '=' -f 1 | tr -d '[:space:]')
  value=$(echo "$line" | cut -d '=' -f 2- | tr -d '[:space:]')
  # Export the key-value pair as an environment variable
  export "$key=$value"
done < settings.ini

# Print the loaded environment variables
for var in $(compgen -v); do
  if [[ $var != _* ]] && [[ $var != OPT* ]] && [[ $var != OSTYPE ]] && [[ $var != PATH ]] && [[ $var != PIPE* ]] && [[ $var != PPID ]] && [[ $var != PWD ]] && [[ $var != RANDOM ]] && [[ $var != SECONDS ]] && [[ $var != SHELL ]] && [[ $var != SHELLOPTS ]] && [[ $var != SHLVL ]] && [[ $var != SRANDOM ]] && [[ $var != SSH* ]] && [[ $var != TERM ]] && [[ $var != UID ]] && [[ $var != USER ]] && [[ $var != XDG* ]]; then
    echo "$var=${!var}"
  fi
done