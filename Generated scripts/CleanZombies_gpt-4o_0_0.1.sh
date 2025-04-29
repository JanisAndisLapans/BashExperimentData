for pid in $(ps -eo stat,ppid | awk '$1 ~ /Z/ {print $2}' | sort -u); do
  kill -9 $pid
done