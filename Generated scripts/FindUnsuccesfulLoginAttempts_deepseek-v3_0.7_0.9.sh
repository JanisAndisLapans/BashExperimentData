#!/bin/bash

# Count unique users with >=3 failed auth attempts today
count=$(grep "$(date '+%b %e')" /var/log/auth.log* | \
         grep -i "failed" | \
         grep -E "user=|user " | \
         sed -E 's/.*(user=|user )([^ ]+).*/\2/i' | \
         sort | uniq -c | \
         awk '$1 >= 3 {print $2}' | wc -l)

echo "Users: $count"