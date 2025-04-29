vulns=$(trivy fs --severity HIGH,CRITICAL --format json . | jq -r '.Results[].Vulnerabilities[]?.VulnerabilityID' | sort -u | xargs)
if [[ -z "$vulns" ]]; then
    echo "The project is clean"
else
    echo "Here are the vulnerabilities: $vulns"
fi