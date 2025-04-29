#!/bin/bash

# Read and parse INI file
while IFS='= ' read -r key value; do
    # Skip comments and empty lines
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    
    # Remove quotes if present
    value="${value%\"}"
    value="${value#\"}"
    
    # Export the variable
    declare -g "$key"="$value"
done < "settings.ini"

# Optional: list all loaded variables for verification
declare -p $(grep -oP '^[^=]+' settings.ini | tr '\n' ' ')
#!/bin/bash

# Read and parse INI file
while IFS='= ' read -r key value; do
    # Skip comments and empty lines
    [[ "$key" =~ ^[[:space:]]*# ]] && continue
    [[ -z "$key" ]] && continue
    
    # Remove quotes if present
    value="${value%\"}"
    value="${value#\"}"
    
    # Export the variable
    declare -g "$key"="$value"
done < "settings.ini"

# Optional: list all loaded variables for verification
mapfile -t vars < <(grep -oP '^[^=]+' settings.ini)
declare -p "${vars[@]}"