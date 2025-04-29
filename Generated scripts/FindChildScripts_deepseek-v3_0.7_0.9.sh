#!/bin/bash

# Find the PID of the exec.sh process
parent_pid=$(pgrep -f exec.sh)

if [[ -z "$parent_pid" ]]; then
    echo "exec.sh is not running"
    exit 1
fi

# Get all child processes recursively
child_pids=$(pstree -p "$parent_pid" | grep -o '([0-9]\+)' | grep -o '[0-9]\+')

# Check each process for script execution
echo "Child scripts launched by exec.sh or its children:"
for pid in $parent_pid $child_pids; do
    # Get the command line and check if it's a script
    cmdline=$(cat /proc/"$pid"/cmdline | tr '\0' ' ')
    if [[ "$cmdline" =~ \.sh$ ]] || [[ "$cmdline" =~ ^/bin/bash ]] || [[ "$cmdline" =~ ^/bin/sh ]]; then
        script_name=$(basename "$(echo "$cmdline" | awk '{print $1}')")
        echo "$script_name (PID: $pid)"
    fi
done | sort -u