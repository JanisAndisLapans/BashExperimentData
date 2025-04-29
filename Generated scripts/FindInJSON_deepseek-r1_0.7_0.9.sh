#!/bin/bash

users=$(find . -maxdepth 1 -type f -exec jq -r '.user // empty' 2>/dev/null {} \; | sort)
user_list=$(echo "$users" | paste -sd, -)

if [[ -z "$user_list" ]]; then
    echo "No users found"
else
    echo "Here are the users: $user_list"
fi