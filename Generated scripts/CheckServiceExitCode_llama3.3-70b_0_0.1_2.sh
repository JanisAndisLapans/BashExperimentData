EXIT_CODE=$(systemctl show myservice -p ExitCode | cut -d '=' -f2)
if [ -n "$EXIT_CODE" ]; then
  echo "exit code: $EXIT_CODE"
else
  echo "exit code: $(journalctl -u myservice --no-pager | grep -oP '(?<=exited with status )\d+')"
fi