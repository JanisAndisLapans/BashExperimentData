exit_code=$(journalctl -u myservice --no-pager -n 1 | grep 'exited' | awk -F'code=' '{print $2}' | awk '{print $1}')
echo "exit code: $exit_code"