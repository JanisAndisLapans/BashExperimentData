vulnerabilities=$(trivy fs . --format json --severity HIGH,CRITICAL | jq -r '.Results[] | .Vulnerabilities[] | .VulnID')
if [ -n "$vulnerabilities" ]; then
  echo "Here are the vulnerabilities: $vulnerabilities"
else
  echo "The project is clean"
fi