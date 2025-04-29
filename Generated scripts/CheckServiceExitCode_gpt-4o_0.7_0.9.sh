status=$(systemctl show myservice --property=ExecMainStatus --value)
echo "exit code: $status"