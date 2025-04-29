#!/bin/bash

# Find json data in files with "user" keys
users=$(grep -h '"user"' *.json | cut -d '"' -f 4 | sort | uniq)

if [ -z "$users" ]; then
    echo "No users found"
else
    echo "Here are the users: $users"
fi