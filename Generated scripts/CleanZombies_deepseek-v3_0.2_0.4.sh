#!/bin/bash

# Find all zombie processes and kill their parents
ps -eo stat,pid,ppid | awk '$1 ~ /^Z/ {print $3}' | while read -r ppid; do
    if [ -n "$ppid" ] && [ "$ppid" -ne 1 ]; then
        echo "Killing parent process $ppid of zombie process"
        kill -9 "$ppid"
    fi
done