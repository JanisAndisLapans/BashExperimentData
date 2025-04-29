#!/bin/bash

count=$(find . -maxdepth 1 -name "*.sh" -exec shellcheck --format=json {} + | jq '[.[] | select(.level == "warning")] | length')
echo "Count warning: $count"