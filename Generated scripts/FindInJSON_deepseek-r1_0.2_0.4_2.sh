#!/bin/bash

# Extract and sort user values from all files using C locale for consistent sorting
users=$(find . -maxdepth 1 -type f -exec jq -r '.user // empty' {} \; 2>/dev/null | LC_ALL=C sort -u)

if [[ -z "$users" ]]; then
    echo "No users found"
else
    # Format users into comma-separated list
    user_list=$(echo "$users" | paste -sd, -)
    echo "Here are the users: ${user_list}"
fi