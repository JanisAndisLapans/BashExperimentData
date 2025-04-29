#!/bin/bash

# Get the process ID of exec.sh
exec_pid=$(pgrep -f exec.sh)

# Use pstree to list all child processes and filter out the script names
pstree -p $exec_pid | grep -oP '\(\d+\) \K[^ ]+' | grep -v '^('