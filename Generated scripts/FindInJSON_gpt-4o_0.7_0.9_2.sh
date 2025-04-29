#!/bin/bash

users=()

for file in *; do
    if [[ -f $file ]]; then
        values=$(jq -r 'to_entries[] | select(.key == "user") | .value' "$file" 2>/dev/null)
        if [[ -n "$values" ]]; then
            mapfile -t file_users <<< "$values"
            users+=("${file_users[@]}")
        fi
    fi
done

if [[ ${#users[@]} -eq 0 ]]; then
    echo "No users found"
else
    sorted_users=$(printf "%s\n" "${users[@]}" | sort)
    echo "Here are the users: $(echo "$sorted_users" | tr '\n' ', ' | sed 's/, $//')"
fi