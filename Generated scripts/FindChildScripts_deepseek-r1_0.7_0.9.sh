#!/bin/bash

# Get the PID of exec.sh
pid=$(pgrep -o exec.sh)
[[ -z "$pid" ]] && { echo "exec.sh not found" >&2; exit 1; }

# Collect all child PIDs (including descendants)
child_pids=$(pstree -p "$pid" | grep -o '([0-9]\+)' | tr -d '()')

# Include the main PID in case it's a script replacement via exec
all_pids="$pid $child_pids"

declare -A scripts=()

for pid in $all_pids; do
    # Read cmdline from kernel if process exists
    [[ -e "/proc/$pid/cmdline" ]] || continue
    while IFS= read -r -d '' arg; do
        if [[ "$arg" == *.sh ]]; then
            scripts["$arg"]=1
        fi
    done < "/proc/$pid/cmdline"
done

# Output unique script names
printf "%s\n" "${!scripts[@]}"