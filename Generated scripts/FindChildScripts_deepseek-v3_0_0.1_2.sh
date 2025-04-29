#!/bin/bash

# Get the PID of the exec.sh process
parent_pid=$(pgrep -f exec.sh)

if [[ -z "$parent_pid" ]]; then
    echo "exec.sh is not running"
    exit 1
fi

# Get all child PIDs recursively using ps
child_pids=$(ps --ppid "$parent_pid" -o pid --no-headers | xargs)

# Function to recursively get all descendants
get_descendants() {
    local children=$(ps --ppid "$1" -o pid --no-headers)
    for pid in $children; do
        echo "$pid"
        get_descendants "$pid"
    done
}

# Get all descendant PIDs
all_pids="$parent_pid $(get_descendants "$parent_pid")"

# Find all script processes among children
for pid in $all_pids; do
    # Get the command line and check if it's a script
    if [[ -f "/proc/$pid/cmdline" ]]; then
        cmdline=$(tr '\0' ' ' < "/proc/$pid/cmdline")
        if [[ "$cmdline" =~ \.sh(\ |$) ]]; then
            script_name=$(basename "$(echo "$cmdline" | awk '{print $1}')")
            echo "$script_name"
        fi
    fi
done | sort -u