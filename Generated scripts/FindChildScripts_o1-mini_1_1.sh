#!/bin/bash

# Find the PID(s) of exec.sh
pids=$(pgrep -f "/path/to/exec.sh")

# Function to recursively find child PIDs
get_child_pids() {
    local parent_pid=$1
    children=$(pgrep -P "$parent_pid")
    for child in $children; do
        echo "$child"
        get_child_pids "$child"
    done
}

# Collect all child PIDs
all_child_pids=()
for pid in $pids; do
    all_child_pids+=($(get_child_pids "$pid"))
done

# Get the script names from the collected PIDs
for pid in "${all_child_pids[@]}"; do
    cmd=$(ps -p "$pid" -o cmd=)
    if [[ "$cmd" =~ \.sh$ ]]; then
        echo "$cmd"
    fi
done