vulnerabilities=$(trivy fs --severity HIGH,CRITICAL . | grep -oP 'CVE-\d{4}-\d{4,7}' | sort -u | tr '\n' ' ')

if [ -z "$vulnerabilities" ]; then
  echo "The project is clean"
else
  echo "Here are the vulnerabilities: $vulnerabilities"
fi