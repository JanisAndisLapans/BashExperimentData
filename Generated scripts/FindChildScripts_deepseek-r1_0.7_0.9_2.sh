#!/bin/bash

pid=$(pgrep -o exec.sh)
[[ -z "$pid" ]] && { echo "exec.sh not found" >&2; exit 1; }

child_pids=$(pstree -p "$pid" | grep -o '([0-9]\+)' | tr -d '()')

declare -A scripts=()

for pid in $child_pids; do
    [[ -e "/proc/$pid/cmdline" ]] || continue
    while IFS= read -r -d '' arg; do
        if [[ "$arg" == *.sh ]]; then
            scripts["$arg"]=1
        fi
    done < "/proc/$pid/cmdline"
done

printf "%s\n" "${!scripts[@]}"