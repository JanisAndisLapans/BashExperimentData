#!/bin/bash

# Using find command to locate all bash scripts in the current directory
# Using xargs to execute shellcheck on each script and grep to count the lines containing "warning"
warning_count=$(find . -type f -name "*.sh" -exec shellcheck {} \; | grep -c "warning")

echo "Count warning: $warning_count"