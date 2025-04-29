#!/bin/bash

count=$(grep "$(date '+%b %e')" /var/log/auth.log | grep -i "failed" | awk '{print $9}' | sort | uniq -c | awk '$1 >= 3 {print $2}' | wc -l)
echo "Users: $count"