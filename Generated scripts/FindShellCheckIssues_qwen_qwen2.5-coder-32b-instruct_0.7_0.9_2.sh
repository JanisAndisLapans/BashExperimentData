count=$(find . -type f -name "*.sh" -exec shellcheck -f json {} + | jq -r '[.[] | .[].level | select(. == "warning")] | length')
echo "Count warning: $count"