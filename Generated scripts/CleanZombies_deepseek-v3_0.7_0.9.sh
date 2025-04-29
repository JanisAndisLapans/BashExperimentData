#!/bin/bash

# Find all zombie processes and get their PPIDs
zombie_ppids=$(ps -A -ostat,ppid | awk '/[Zz]/ && $2 != 0 {print $2}')

if [[ -z "$zombie_ppids" ]]; then
    echo "No zombie processes found."
    exit 0
fi

# Kill each parent process with SIGKILL
for ppid in $zombie_ppids; do
    echo "Killing parent process $ppid of zombie process"
    kill -9 "$ppid"
done

echo "Zombie cleanup completed."