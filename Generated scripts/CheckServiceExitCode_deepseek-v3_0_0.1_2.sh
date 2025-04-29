systemctl show myservice.service --property=ExecMainStatus,Result --no-pager | 
  awk -F= '/ExecMainStatus/ {code=$2} /Result/ {result=$2} 
           END {printf "exit code: %d\n", (code != "") ? code : (result == "exit-code") ? 0 : "unknown"}'