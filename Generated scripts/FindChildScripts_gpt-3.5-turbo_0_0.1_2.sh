#!/bin/bash

# Find the process ID of the exec.sh script
pid=$(pgrep -f "exec.sh")

# Find all child processes of the exec.sh script
children=$(pgrep -P "$pid")

# List the names of all child scripts launched by exec.sh script or its child processes
while IFS= read -r child_pid; do
    cmdline=$(tr -d '\0' < "/proc/$child_pid/cmdline")
    echo "Child script name: $cmdline"
done <<< "$children"