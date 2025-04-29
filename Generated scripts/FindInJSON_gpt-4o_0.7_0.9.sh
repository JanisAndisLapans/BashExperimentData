#!/bin/bash

users=()

for file in *; do
    if [[ -f $file ]]; then
        values=$(jq -r 'to_entries[] | select(.key == "user") | .value' "$file" 2>/dev/null)
        if [[ ! -z $values ]]; then
            users+=($values)
        fi
    fi
done

if [[ ${#users[@]} -eq 0 ]]; then
    echo "No users found"
else
    sorted_users=$(printf "%s\n" "${users[@]}" | sort)
    echo "Here are the users: $(echo $sorted_users | tr '\n' ', ' | sed 's/, $//')"
fi