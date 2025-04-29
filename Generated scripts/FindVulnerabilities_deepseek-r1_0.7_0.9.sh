vulns=$(trivy fs --quiet --severity HIGH,CRITICAL . --template '{{.VulnerabilityID}} ' | tr ' ' '\n' | sort -u | tr '\n' ' ' | sed 's/ *$//')
if [[ -z "$vulns" ]]; then
    echo "The project is clean"
else
    echo "Here are the vulnerabilities: $vulns"
fi