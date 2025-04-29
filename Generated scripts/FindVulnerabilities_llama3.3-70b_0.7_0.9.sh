vulnerabilities=$(trivy fs . --format json | jq -r '.Results[] | .Vulnerabilities[] | select(.Severity == "HIGH" or .Severity == "CRITICAL") | .VulnerabilityID')
if [ -n "$vulnerabilities" ]; then
  echo "Here are the vulnerabilities: $vulnerabilities"
else
  echo "The project is clean"
fi