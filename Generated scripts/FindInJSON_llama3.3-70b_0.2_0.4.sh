#!/bin/bash

users=()
for file in *; do
  if grep -q "\"user\"" "$file"; then
    user=$(jq -r '.user' "$file")
    if [ $? -eq 0 ]; then
      users+=("$user")
    fi
  fi
done

if [ ${#users[@]} -gt 0 ]; then
  IFS=$'\n' sorted_users=($(sort <<<"${users[*]}"))
  echo "Here are the users: ${sorted_users[*]}"
else
  echo "No users found"
fi