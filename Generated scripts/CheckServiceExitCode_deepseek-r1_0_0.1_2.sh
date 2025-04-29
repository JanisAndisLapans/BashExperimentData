code=$(journalctl -u myservice --no-pager | grep -a "Main process exited, code=exited, status=" | tail -n1 | sed -n 's/.*status=\([0-9]\+\).*/\1/p')
[ -z "$code" ] && code=$(systemctl show myservice --property=ExecMainStatus --value)
echo "exit code: ${code:-0}"