#!/bin/bash

users=$(grep -h '"user"' ./*.json | cut -d '"' -f 4 | sort | uniq)

if [ -z "$users" ]; then
    echo "No users found"
else
    sorted_users=$(echo "$users" | tr ' ' '\n' | sort | tr '\n' ' ')
    echo "Here are the users: $sorted_users"
fi