today=$(date '+%b %d')
count=$(grep "$today" /var/log/{auth.log,secure} 2>/dev/null | grep -E "Failed password|FAILED LOGIN" | awk '{print $(NF-5)}' | sort | uniq -c | awk '$1 >= 3' | wc -l)
echo "Users: $count"