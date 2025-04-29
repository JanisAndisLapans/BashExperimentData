#!/bin/bash

users=()

for file in *.json; do
    if [ -f "$file" ]; then
        while IFS= read -r value; do
            users+=("$value")
        done < <(jq -r 'to_entries[] | select(.key == "user") | .value' "$file")
    fi
done

if [ ${#users[@]} -eq 0 ]; then
    echo "No users found"
else
    IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
    echo "Here are the users: ${sorted_users[*]}"
fi