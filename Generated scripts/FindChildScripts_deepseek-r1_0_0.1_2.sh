#!/bin/bash

exec_pid=$(pgrep -f 'exec\.sh')

if [ -z "$exec_pid" ]; then
    echo "Error: exec.sh is not running." >&2
    exit 1
fi

# Get descendant PIDs excluding the parent itself
descendants=$(pstree -p "$exec_pid" | grep -o '([0-9]\+)' | grep -o '[0-9]\+' | grep -v "^${exec_pid}$")

script_names=()
for pid in $descendants; do
    if [ -r "/proc/$pid/cmdline" ]; then
        mapfile -d $'\0' args < "/proc/$pid/cmdline"
        for arg in "${args[@]}"; do
            if [[ "$arg" == *.sh ]]; then
                script_names+=("$(basename "$arg")")
            fi
        done
    fi
done

printf "%s\n" "${script_names[@]}" | sort -u