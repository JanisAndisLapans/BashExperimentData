exit_code=$(journalctl -u myservice -o cat | tail -n 1 | awk '{print $NF}')
echo "exit code: $exit_code"