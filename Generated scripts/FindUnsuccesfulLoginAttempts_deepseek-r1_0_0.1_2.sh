current_date=$(date +"%b %_d")
zgrep -hE -i "$current_date.*(failed password|authentication failure|failed login|authentication error|user unknown|invalid user)" /var/log/auth.log* 2>/dev/null | {
  while read -r line; do
    user=$(echo "$line" | sed -nE \
      -e 's/.*[Ff]ailed [Pp]assword (for|during) (invalid user )?([^ ]+).*/\3/p' \
      -e 's/.*[Aa]uthentication failure.* (user|ruser)=([^ ]+).*/\2/p' \
      -e 's/.*FAILED LOGIN .* FOR (\x27)?([^ ]+).*/\2/p' \
      -e 's/.*Invalid user ([^ ]+) from.*/\1/p' \
      -e 's/.* user ([^ ]+) .*authentication failure.*/\1/p' \
      -e 's/.*[Ee]rror: ([^ ]+) authentication failure.*/\1/p')
    [ -n "$user" ] && echo "$user"
  done
} | sort | uniq -c | awk '$1 >=3 {count++} END {printf "Users: %d\n", count}'