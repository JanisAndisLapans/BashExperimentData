#!/bin/bash

count=$(find . -maxdepth 1 -name "*.sh" -exec shellcheck --severity=warning {} + | grep -c "warning:")

echo "Count warning: $count"