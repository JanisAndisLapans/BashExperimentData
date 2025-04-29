#!/bin/bash

users=()
for file in *; do
  if [ -f "$file" ]; then
    if jq -e '.user' "$file" > /dev/null; then
      user=$(jq -r '.user' "$file")
      users+=("$user")
    fi
  fi
done

if [ ${#users[@]} -gt 0 ]; then
  printf -v sorted_users "%s, " "${users[@]}"
  sorted_users=$(echo "${sorted_users%, }" | tr ',' '\n' | sort | tr '\n' ', ')
  echo "Here are the users: ${sorted_users%, }"
else
  echo "No users found"
fi