#!/bin/bash

users=()

for file in *.json; do
    if [ -f "$file" ]; then
        values=$(jq -r '.user // empty' "$file")
        while IFS= read -r value; do
            users+=("$value")
        done <<< "$values"
    fi
done

if [ ${#users[@]} -eq 0 ]; then
    echo "No users found"
else
    IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
    echo "Here are the users: ${sorted_users[*]}"
fi