current_date=$(date +"%b %e")
zgrep -hE "$current_date.*(Failed password|authentication failure)" /var/log/auth.log* | {
  while read -r line; do
    if [[ "$line" == *"Failed password"* ]]; then
      echo "$line" | sed -nE 's/.*Failed password for (invalid user )?([^ ]+).*/\2/p'
    else
      echo "$line" | grep -o 'user=[^ ]*' | cut -d= -f2
    fi
  done
} | sort | uniq -c | awk '$1 >=3 {count++} END {printf "Users: %d\n", count}'