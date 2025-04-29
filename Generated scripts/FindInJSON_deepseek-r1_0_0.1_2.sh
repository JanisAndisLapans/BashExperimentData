#!/bin/bash

# Extract unique user values from JSON files, sorted alphabetically with C locale for deterministic order
users=$(find . -maxdepth 1 -type f -exec \
          jq -r '.. | .user? // empty | select(type == "string")' {} \; 2>/dev/null | 
          LC_ALL=C sort -u)

if [[ -z "$users" ]]; then
    echo "No users found"
else
    # Format into comma-separated list
    user_list=$(echo "$users" | paste -sd,)
    echo "Here are the users: ${user_list}"
fi