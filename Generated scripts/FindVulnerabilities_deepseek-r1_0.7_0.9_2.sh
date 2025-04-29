vulns=$(trivy fs --quiet --severity HIGH,CRITICAL . --format json | jq -r '[.Results[].Vulnerabilities[]?.VulnerabilityID] | unique | join(" ")')
if [[ -z "$vulns" ]]; then
    echo "The project is clean"
else
    echo "Here are the vulnerabilities: $vulns"
fi