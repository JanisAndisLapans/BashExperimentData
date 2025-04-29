#!/bin/bash

# Using a for loop to iterate over each bash script in the current directory
# Using shellcheck to check for warnings and counting the output lines containing "warning"
warning_count=0
for script in *.sh; do
    ((warning_count += $(shellcheck "$script" | grep -c "warning")))
done

echo "Count warning: $warning_count"