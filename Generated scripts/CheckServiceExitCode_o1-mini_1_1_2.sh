exit_code=$(systemctl show myservice -p ExecMainExitCode --value)
echo "exit code: ${exit_code:-0}"