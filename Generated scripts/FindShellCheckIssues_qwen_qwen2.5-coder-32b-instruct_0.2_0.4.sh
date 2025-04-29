count=$(shellcheck -f json ./*.sh | jq -r '[.[] | .warnings[]? | select(.level == "warning")] | length')
echo "Count warning: $count"