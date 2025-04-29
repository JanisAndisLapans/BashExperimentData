#!/bin/bash

# Extract and sort user values from all files
users=$(find . -maxdepth 1 -type f -exec jq -r '.user // empty' {} \; 2>/dev/null | sort)

if [[ -z "$users" ]]; then
    echo "No users found"
else
    # Format users into comma-separated list
    user_list=$(echo "$users" | paste -sd, -)
    echo "Here are the users: ${user_list}"
fi