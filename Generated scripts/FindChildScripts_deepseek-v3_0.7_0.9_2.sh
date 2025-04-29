#!/bin/bash

# Find the PID of the exec.sh process
parent_pid=$(pgrep -f exec.sh)

if [[ -z "$parent_pid" ]]; then
    echo "exec.sh is not running"
    exit 1
fi

# Get all child processes recursively using ps
child_pids=$(ps --ppid "$parent_pid" -o pid=)
all_pids="$parent_pid $child_pids"

# Expand to include grandchildren
for pid in $child_pids; do
    all_pids="$all_pids $(ps --ppid "$pid" -o pid=)"
done

# Check each process for script execution
echo "Child scripts launched by exec.sh or its children:"
for pid in $all_pids; do
    # Get the command line without using cat
    if [[ -f "/proc/$pid/cmdline" ]]; then
        cmdline=$(tr '\0' ' ' < "/proc/$pid/cmdline")
        # Match script files or bash/sh executions with script arguments
        if [[ "$cmdline" =~ \.sh(\ |$) ]] || 
           [[ "$cmdline" =~ ^(/bin/bash|/bin/sh)\ .*\.sh ]] || 
           [[ "$cmdline" =~ ^(/bin/bash|/bin/sh)\ .*-c\ .*\.sh ]]; then
            script_name=$(basename "$(echo "$cmdline" | awk '{print $NF}')")
            echo "$script_name (PID: $pid)"
        fi
    fi
done | sort -u