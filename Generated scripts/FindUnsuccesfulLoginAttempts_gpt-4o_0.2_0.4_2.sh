grep "$(date '+%b %e')" /var/log/auth.log | \
grep -E 'authentication failure|Failed password|invalid user' | \
awk '{print $(NF-2)}' | sort | uniq -c | awk '$1 >= 3 {count++} END {print "Users:", count}'