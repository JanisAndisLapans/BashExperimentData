#!/bin/bash

# Get the PID of the exec.sh process
parent_pid=$(pgrep -f exec.sh)

if [[ -z "$parent_pid" ]]; then
    echo "exec.sh is not running"
    exit 1
fi

# Get all child PIDs recursively
child_pids=$(pstree -p "$parent_pid" | grep -o '([0-9]\+)' | grep -o '[0-9]\+')

# Find all script processes among children
for pid in $parent_pid $child_pids; do
    # Get the command line and check if it's a script
    cmdline=$(cat "/proc/$pid/cmdline" | tr '\0' ' ')
    if [[ "$cmdline" =~ \.sh(\ |$) ]]; then
        script_name=$(basename "$(echo "$cmdline" | awk '{print $1}')")
        echo "$script_name"
    fi
done | sort -u