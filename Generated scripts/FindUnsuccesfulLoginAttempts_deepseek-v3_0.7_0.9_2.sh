#!/bin/bash

# Find all auth log files (including rotated ones)
log_files=()
possible_locations=(
    "/var/log/auth.log"
    "/var/log/auth.log.1"
    "/var/log/auth.log.*.gz"
    "/var/log/secure"
    "/var/log/secure.*"
)

for loc in "${possible_locations[@]}"; do
    for file in $loc; do
        if [ -f "$file" ] || [[ "$file" == *.gz ]]; then
            log_files+=("$file")
        fi
    done
done

if [ ${#log_files[@]} -eq 0 ]; then
    echo "Users: 0 (no auth logs found)"
    exit 1
fi

# Count unique users with >=3 failed auth attempts today
count=$(zgrep -h "$(date '+%b %e')" "${log_files[@]}" 2>/dev/null | \
         grep -iE "failed|invalid|authentication failure" | \
         grep -E "user=|user |for |login failed" | \
         sed -E 's/.*(user=|user |for )([^ ]+).*/\2/i' | \
         sort | uniq -c | \
         awk '$1 >= 3 {print $2}' | wc -l)

echo "Users: $count"