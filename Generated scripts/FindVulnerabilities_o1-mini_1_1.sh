vulns=$(trivy fs . --severity HIGH,CRITICAL --format json | jq -r '.Results[].Vulnerabilities[].VulnerabilityID' | sort -u)
if [ -z "$vulns" ]; then
  echo "The project is clean"
else
  echo -n "Here are the vulnerabilities:"
  for code in $vulns; do
    echo -n " $code"
  done
  echo
fi