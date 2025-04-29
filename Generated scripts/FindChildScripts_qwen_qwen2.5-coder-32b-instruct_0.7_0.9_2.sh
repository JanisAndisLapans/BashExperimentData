#!/bin/bash

# Get the PID of exec.sh
EXEC_PID=$(pgrep -f exec.sh)

# Check if exec.sh is running
if [ -z "$EXEC_PID" ]; then
  echo "exec.sh is not running."
  exit 1
fi

# Use pstree to list all child processes of exec.sh
pstree -p $EXEC_PID | grep -oP '\(\K[^\)]+' | grep -v "^$EXEC_PID$" | xargs -I{} ps -o cmd= -p {} | awk '{print $1}' | xargs -I{} basename "{}"