#!/bin/bash

# Enable extended globbing
shopt -s extglob

# Get the PID of exec.sh
exec_pid=$(pgrep -f "^/bin/bash ./exec.sh$")

# Use pstree to list all child processes of exec.sh and filter out script names
if [ -n "$exec_pid" ]; then
  pstree -p $exec_pid | grep -oP '(?<=\().*?(?=\))' | while read pid; do
    # Check if the process is a script
    cmd=$(ps -o args= -p $pid)
    if [[ $cmd == */bin/bash* ]]; then
      echo $(basename $(echo $cmd | awk '{print $2}'))
    fi
  done | sort -u
fi