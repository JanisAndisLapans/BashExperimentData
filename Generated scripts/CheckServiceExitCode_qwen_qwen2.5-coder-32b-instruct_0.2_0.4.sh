exit_code=$(systemctl status myservice | grep 'Main PID' | awk '{print $3}' | tr -d ')')
echo "exit code: $exit_code"