#!/bin/bash

count=$(find . -maxdepth 1 -name "*.sh" -exec shellcheck --format=gcc {} + | grep -c "warning:")
echo "Count warning: $count"