#!/bin/bash
ps -e -o stat,ppid | awk '/^Z/ {print $2}' | sort -u | xargs -r -- kill -9 2>/dev/null