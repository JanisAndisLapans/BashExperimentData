#!/bin/bash

count=$(find . -type f -name '*.sh' -exec shellcheck --severity=warning -f gcc {} + | grep -c ": warning:")
echo "Count warning: $count"