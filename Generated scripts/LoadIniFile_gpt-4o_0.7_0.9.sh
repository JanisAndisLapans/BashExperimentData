#!/bin/bash

# Define the path to the ini file
INI_FILE="settings.ini"

# Use awk to parse the ini file and export variables
awk -F= '/^[^;#]/ { gsub(/ /, "", $1); gsub(/^[ \t]+|[ \t]+$/, "", $2); printf "export %s=\"%s\"\n", $1, $2 }' "$INI_FILE" | source /dev/stdin