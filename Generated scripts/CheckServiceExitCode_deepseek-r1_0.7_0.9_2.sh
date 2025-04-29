#!/bin/bash
# Get the last exit code from journal or current status
exit_code=$(LANG=C.UTF-8 journalctl -u myservice --no-pager | grep 'Main process exited, code=exited, status=' | tail -n1 | sed -n 's/.*status=\([0-9]*\).*/\1/p')
if [[ -z "$exit_code" ]]; then
    exit_code=$(systemctl show -p ExecMainStatus --value myservice)
fi
echo "exit code: $exit_code"