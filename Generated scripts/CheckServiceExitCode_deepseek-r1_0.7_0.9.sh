#!/bin/bash
exit_code=$(systemctl show -p ExecMainStatus --value myservice)
echo "exit code: $exit_code"