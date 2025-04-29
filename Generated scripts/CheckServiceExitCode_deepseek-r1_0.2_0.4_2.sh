exit_code=$(journalctl -u myservice -o cat --no-pager | grep -oP 'status=\K\d+' | tail -n1)
[[ -z "$exit_code" ]] && exit_code=0
echo "exit code: ${exit_code}"