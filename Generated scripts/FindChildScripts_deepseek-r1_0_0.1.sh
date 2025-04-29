#!/bin/bash

# Find the PID of exec.sh
exec_pid=$(pgrep -f 'exec\.sh')

if [ -z "$exec_pid" ]; then
    echo "Error: exec.sh is not running." >&2
    exit 1
fi

# Get all descendant PIDs using pstree
descendants=$(pstree -p "$exec_pid" | grep -o '([0-9]\+)' | grep -o '[0-9]\+')

# Collect all .sh scripts from cmdline arguments
script_names=()
for pid in $descendants; do
    if [ -r "/proc/$pid/cmdline" ]; then
        mapfile -d $'\0' args < "/proc/$pid/cmdline"
        for arg in "${args[@]}"; do
            if [[ "$arg" == *.sh ]]; then
                script_names+=("$arg")
            fi
        done
    fi
done

# Output unique script names
printf "%s\n" "${script_names[@]}" | sort -u