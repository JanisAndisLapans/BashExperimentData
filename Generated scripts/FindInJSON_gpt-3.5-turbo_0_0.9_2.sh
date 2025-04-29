#!/bin/bash

shopt -s nullglob

users=$(grep -h '"user"' ./*.json 2>/dev/null | cut -d '"' -f 4 | sort | uniq)

if [ -z "$users" ]; then
    echo "No users found"
else
    echo "Here are the users: $users"
fi