#!/bin/bash

users=$(jq -r '.. | objects | .user? // empty' ./* 2>/dev/null | sort | uniq)

if [ -z "$users" ]; then
    echo "No users found"
else
    user_list=$(echo "$users" | paste -sd, - | sed 's/,/, /g')
    echo "Here are the users: $user_list"
fi