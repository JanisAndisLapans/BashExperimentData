#!/bin/bash

# Get the process id of the exec.sh script
exec_pid=$(pgrep -f "exec.sh")

# List all child processes of the exec.sh script
pids=$(pgrep -P "$exec_pid")

# Loop through each child process and find the script name
while IFS= read -r pid; do
    cmd=$(ps -p "$pid" -o cmd --no-headers)
    script_name=$(echo "$cmd" | awk '{print $1}')
    echo "$script_name"
done <<< "$pids"