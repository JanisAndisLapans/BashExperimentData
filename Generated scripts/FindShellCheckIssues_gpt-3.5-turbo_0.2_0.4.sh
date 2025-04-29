#!/bin/bash

count=0

for file in *.sh; do
    warnings=$(shellcheck -f gcc "$file" | grep -c "warning:")
    count=$((count + warnings))
done

echo "Count warning: $count"