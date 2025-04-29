#!/bin/bash

total_warnings=0

for script in *.sh; do
    warnings=$(shellcheck "$script" --format json | jq '[.[] | select(.level == "warning")] | length')
    total_warnings=$((total_warnings + warnings))
done

echo "Count warning: $total_warnings"