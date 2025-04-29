#!/bin/bash

# Run trivy to scan the current directory for vulnerabilities
vulnerabilities=$(trivy fs --severity HIGH --format json . | jq -r '.Results[].Vulnerabilities[] | select(.Severity == "HIGH" or .Severity == "CRITICAL") | .VulnerabilityID')

# Check if there are any vulnerabilities found
if [ -z "$vulnerabilities" ]; then
    echo "The project is clean"
else
    echo -n "Here are the vulnerabilities: "
    echo "$vulnerabilities" | tr '\n' ' '
    echo
fi