#!/bin/bash

# Run trivy to scan the current directory for vulnerabilities with at least high severity
vulnerabilities=$(trivy fs --severity HIGH,CRITICAL --format json . | jq -r '.Results[].Vulnerabilities[]?.VulnerabilityID')

# Check if any vulnerabilities were found
if [ -z "$vulnerabilities" ]; then
    echo "The project is clean"
else
    echo -n "Here are the vulnerabilities: "
    echo "$vulnerabilities" | tr '\n' ' '
    echo
fi