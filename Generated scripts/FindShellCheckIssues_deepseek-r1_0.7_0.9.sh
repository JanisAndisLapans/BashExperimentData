#!/bin/bash

count=$(find . -type f -name '*.sh' -exec shellcheck --severity=warning -f gcc {} + | wc -l)
echo "Count warning: $count"