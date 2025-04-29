#!/bin/bash

# Find the PID(s) of exec.sh
mapfile -t pids < <(pgrep -f "/path/to/exec.sh")

# Function to recursively find child PIDs
get_child_pids() {
    local parent_pid=$1
    local children
    children=$(pgrep -P "$parent_pid")
    for child in $children; do
        echo "$child"
        get_child_pids "$child"
    done
}

# Collect all child PIDs
all_child_pids=()
for pid in "${pids[@]}"; do
    while IFS= read -r child_pid; do
        all_child_pids+=("$child_pid")
    done < <(get_child_pids "$pid")
done

# Remove duplicate PIDs
unique_pids=($(printf "%s\n" "${all_child_pids[@]}" | sort -u))

# Get the script names from the collected PIDs
for pid in "${unique_pids[@]}"; do
    cmd=$(ps -p "$pid" -o cmd=)
    if [[ "$cmd" =~ \.sh$ ]]; then
        echo "$cmd"
    fi
done