#!/bin/bash

users=$(grep -hR "user" --include="*.json" . | jq -r '.user' | sort | uniq)

if [ -z "$users" ]; then
    echo "No users found"
else
    echo "Here are the users: $users"
fi