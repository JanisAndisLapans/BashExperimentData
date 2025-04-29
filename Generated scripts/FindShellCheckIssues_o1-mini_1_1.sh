#!/bin/bash
count=$(shellcheck ./*.sh --format=json | jq '[.[] | select(.level=="warning")] | length')
echo "Count warning: $count"