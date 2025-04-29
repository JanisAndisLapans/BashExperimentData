#!/bin/bash

users=()

for file in *.json; do
    if [ -f "$file" ]; then
        values=$(jq -r 'to_entries[] | select(.key == "user") | .value' "$file")
        for value in $values; do
            users+=("$value")
        done
    fi
done

if [ ${#users[@]} -eq 0 ]; then
    echo "No users found"
else
    IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
    echo "Here are the users: ${sorted_users[*]}"
fi