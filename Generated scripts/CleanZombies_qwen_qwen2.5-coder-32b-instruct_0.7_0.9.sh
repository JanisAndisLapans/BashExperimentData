#!/bin/bash

# Find all zombie processes and their parent PIDs
zombies=$(ps -eo pid,ppid,state,cmd | awk '$3 == "Z" {print $2}')

# Kill the parent processes with SIGKILL
for ppid in $zombies; do
    kill -9 $ppid
done