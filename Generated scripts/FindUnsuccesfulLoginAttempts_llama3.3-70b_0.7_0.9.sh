users=$(awk -v date=$(date +"%b %d") '$0 ~ date && $6 == "Failed" {print $9}' /var/log/auth.log | cut -d':' -f1 | sort | uniq -c | awk '$1 >= 3 {print $2}' | wc -l)
echo "Users: $users"