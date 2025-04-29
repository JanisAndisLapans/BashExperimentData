#!/bin/bash

users=()
for file in *; do
  if [ -f "$file" ]; then
    json_data=$(jq -r '.user' "$file" 2>/dev/null)
    if [ $? -eq 0 ] && [ -n "$json_data" ]; then
      users+=("$json_data")
    fi
  fi
done

if [ ${#users[@]} -gt 0 ]; then
  IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
  echo "Here are the users: ${sorted_users[*]}"
else
  echo "No users found"
fi