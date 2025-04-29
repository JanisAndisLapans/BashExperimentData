awk '/authentication failure/ && /'$(date '+%b %e')'/' /var/log/auth.log | \
awk '{print $NF}' | sort | uniq -c | awk '$1 >= 3 {count++} END {print "Users:", count}'