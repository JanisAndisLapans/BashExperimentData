for pid in "$(ps -eo pid,ppid,state --no-headers | awk '$3 == "Z" {print $2}')"; do
  kill -9 "$pid"
done