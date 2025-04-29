exit_code=$(systemctl show myservice --property=ExecMainStatus --value)
echo "exit code: ${exit_code}"