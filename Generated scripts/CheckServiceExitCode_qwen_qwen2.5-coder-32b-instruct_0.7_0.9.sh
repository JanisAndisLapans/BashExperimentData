exit_code=$(systemctl status myservice | grep 'Main PID' | awk '{print $3}' | cut -d= -f2)
echo "exit code: $exit_code"