#!/bin/bash

# Run trivy to scan the current directory and filter for vulnerabilities with severity "HIGH" or higher
vulnerabilities=$(trivy fs --severity HIGH,CRITICAL . | grep -oP 'CVE-\d{4}-\d{4,7}' | sort | uniq)

# Check if any vulnerabilities were found
if [[ -z "$vulnerabilities" ]]; then
    echo "The project is clean"
else
    # Format the output
    echo "Here are the vulnerabilities: $vulnerabilities"
fi