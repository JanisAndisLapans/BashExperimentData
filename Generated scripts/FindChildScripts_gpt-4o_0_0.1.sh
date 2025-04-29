#!/bin/bash

# Get the process ID of exec.sh
exec_pid=$(pgrep -f exec.sh)

# Use pstree to list all child processes and filter for script names
pstree -p $exec_pid | grep -oP '\(\d+\) \K[^ ]+' | while read pid; do
    # Check if the process is a script
    script_name=$(ps -p $pid -o args= | grep -oP '.*\.sh')
    if [ -n "$script_name" ]; then
        echo "$script_name"
    fi
done