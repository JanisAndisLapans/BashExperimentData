#!/bin/bash

# Count unique users with >=3 failed auth attempts today
count=$(grep "$(date '+%b %e')" /var/log/auth.log* | \
         grep -i "failed" | \
         grep -i "password\|authentication" | \
         awk '{print $9, $10, $11}' | \
         sort | uniq -c | \
         awk '$1 >= 3 {print $0}' | \
         wc -l)

echo "Users: $count"