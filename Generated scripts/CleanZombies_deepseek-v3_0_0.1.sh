#!/bin/bash

# Find all zombie processes and get their PPIDs
zombie_ppids=$(ps -A -ostat,ppid | awk '/[Zz]/{print $2}' | sort -u)

if [[ -z "$zombie_ppids" ]]; then
    echo "No zombie processes found"
    exit 0
fi

# Kill each parent process with SIGKILL
for ppid in $zombie_ppids; do
    if [[ $ppid -ne 1 ]]; then  # Don't kill init (PID 1)
        echo "Killing parent process $ppid of zombie process(es)"
        kill -9 "$ppid"
    else
        echo "Cannot kill init (PID 1) which has zombie children"
    fi
done

echo "Zombie cleanup complete"