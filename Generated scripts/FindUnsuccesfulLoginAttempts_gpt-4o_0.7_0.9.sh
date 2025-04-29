today=$(date '+%b %d')
count=$(grep "$today" /var/log/auth.log | grep "Failed password" | awk '{print $(NF-5)}' | sort | uniq -c | awk '$1 >= 3' | wc -l)
echo "Users: $count"