#!/bin/bash

users=()

for file in *.json; do
  if jq -e '.user' "$file" > /dev/null 2>&1; then
    user=$(jq -r '.user' "$file")
    users+=("$user")
  fi
done

if [ ${#users[@]} -eq 0 ]; then
  echo "No users found"
else
  IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
  echo "Here are the users: ${sorted_users[*]}"
fi