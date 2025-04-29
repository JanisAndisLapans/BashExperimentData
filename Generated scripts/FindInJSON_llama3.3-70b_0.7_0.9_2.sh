#!/bin/bash

users=()
for file in *; do
  if [ -f "$file" ]; then
    if json_data=$(jq -r '.user' "$file" 2>/dev/null); then
      if [ "$json_data" != "null" ]; then
        users+=("$json_data")
      fi
    fi
  fi
done

if [ ${#users[@]} -gt 0 ]; then
  mapfile -t sorted_users < <(printf '%s\n' "${users[@]}" | sort)
  echo "Here are the users: ${sorted_users[*]}"
else
  echo "No users found"
fi