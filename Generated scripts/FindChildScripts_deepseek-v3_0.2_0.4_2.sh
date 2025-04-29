#!/bin/bash

# Get the PID of the exec.sh process
parent_pid=$(pgrep -f 'exec.sh')

if [[ -z "$parent_pid" ]]; then
    echo "Error: exec.sh process not found"
    exit 1
fi

# Function to recursively get child processes
get_children() {
    local pid=$1
    ps -o pid= --ppid "$pid" | while read -r child_pid; do
        echo "$child_pid"
        get_children "$child_pid"
    done
}

# Get all child PIDs including the parent
all_pids=($(get_children "$parent_pid") "$parent_pid")

# Get command names and filter for scripts
for pid in "${all_pids[@]}"; do
    ps -o cmd= -p "$pid" | grep -E '\.sh$' | awk '{print $1}'
done | sort -u