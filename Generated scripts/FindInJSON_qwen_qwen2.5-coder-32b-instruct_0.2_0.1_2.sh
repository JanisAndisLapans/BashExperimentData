#!/bin/bash

# Find all JSON files in the current directory
json_files=$(find . -maxdepth 1 -type f -name "*.json")

# Initialize an array to hold user names
users=()

# Loop through each JSON file
for file in $json_files; do
    # Extract user values and add them to the users array
    while IFS= read -r user; do
        users+=("$user")
    done < <(jq -r '.user' "$file" 2>/dev/null)
done

# Check if we found any users
if [ ${#users[@]} -eq 0 ]; then
    echo "No users found"
else
    # Sort the users array and format the output
    sorted_users=$(printf "%s\n" "${users[@]}" | sort | tr '\n' ', ')
    # Remove the trailing comma and space
    sorted_users=${sorted_users%, }
    echo "Here are the users: $sorted_users"
fi