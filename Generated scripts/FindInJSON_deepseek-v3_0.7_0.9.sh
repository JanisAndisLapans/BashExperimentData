#!/bin/bash

# Extract all "user" values from JSON files in the current directory
users=$(grep -hoP '"user"\s*:\s*"\K[^"]+' *.json | sort | uniq)

# Check if any users were found
if [[ -z "$users" ]]; then
    echo "No users found"
else
    # Format the users into a comma-separated list
    user_list=$(echo "$users" | tr '\n' ',' | sed 's/,$//')
    echo "Here are the users: $user_list"
fi