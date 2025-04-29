#!/bin/bash

# Check for auth log files (Debian typically uses auth.log or secure)
LOG_FILES=()
[ -f /var/log/auth.log ] && LOG_FILES+=(/var/log/auth.log)
[ -f /var/log/secure ] && LOG_FILES+=(/var/log/secure)
[ -f /var/log/syslog ] && LOG_FILES+=(/var/log/syslog)

if [ ${#LOG_FILES[@]} -eq 0 ]; then
    echo "Error: No authentication log files found" >&2
    exit 1
fi

# Count unique users with >=3 failed auth attempts today
count=$(grep -h "$(date '+%b %e')" "${LOG_FILES[@]}" | \
         grep -iE "failed|invalid|authentication failure" | \
         grep -iE "password|authentication|login|sshd" | \
         awk 'match($0, /user(name)?=([^ ]+)/, a) {print a[2]} 
              match($0, /for( invalid user)? ([^ ]+)/, a) {print a[2]} 
              /FAILED/ {for(i=1;i<=NF;i++) if ($i=="for") print $(i+1)}' | \
         sort | uniq -c | \
         awk '$1 >= 3 {print $0}' | \
         wc -l)

echo "Users: $count"