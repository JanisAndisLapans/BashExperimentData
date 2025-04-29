#!/bin/bash

# Check all auth logs including rotated ones
log_files=(/var/log/auth.log /var/log/auth.log.[0-9] /var/log/auth.log.[0-9].gz)

# Patterns for different types of failed authentication
patterns=(
    "Failed password"
    "authentication failure"
    "FAILED LOGIN"
    "invalid user"
    "user unknown"
)

# Get today's date in log format (e.g., "Jan  1")
today=$(date '+%b %e')

# Temporary file for storing results
temp_file=$(mktemp)

for log in "${log_files[@]}"; do
    if [ -f "$log" ]; then
        if [[ "$log" == *.gz ]]; then
            zgrep -h "$today" "$log" | grep -E "$(IFS='|'; echo "${patterns[*]}")" >> "$temp_file"
        else
            grep -h "$today" "$log" | grep -E "$(IFS='|'; echo "${patterns[*]}")" >> "$temp_file"
        fi
    fi
done

# Extract usernames from logs and count
count=$(awk '{
    if (/invalid user|user unknown/) {
        for(i=1; i<=NF; i++) if ($i == "user") {print $(i+1); break}
    } else if (/authentication failure/) {
        for(i=1; i<=NF; i++) if ($i == "user=") {print $(i+1); break}
    } else {
        for(i=1; i<=NF; i++) if ($i == "for") {print $(i+1); break}
    }
}' "$temp_file" | sort | uniq -c | awk '$1 >= 3 {print $2}' | wc -l)

echo "Users: $count"
rm "$temp_file"