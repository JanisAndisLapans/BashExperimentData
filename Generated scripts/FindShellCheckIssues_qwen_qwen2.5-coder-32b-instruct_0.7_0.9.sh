count=$(find . -type f -name "*.sh" -exec shellcheck -f json {} + | jq -r '[.[] | .[].level] | count(.[] | select(. == "warning"))')
echo "Count warning: $count"