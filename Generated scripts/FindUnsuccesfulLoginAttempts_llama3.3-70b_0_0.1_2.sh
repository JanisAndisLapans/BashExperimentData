LOG_FILE="/var/log/auth.log"
if [ -f "$LOG_FILE" ]; then
  TODAY=$(date +"%b %d")
  UNIQUE_USERS=$(grep -E "authentication failure|Failed password|invalid user" "$LOG_FILE" | grep "$TODAY" | awk '{print $3}' | sort | uniq -c | awk '$1 >= 3 {print $2}' | wc -l)
  echo "Users: $UNIQUE_USERS"
else
  echo "Users: 0"
fi