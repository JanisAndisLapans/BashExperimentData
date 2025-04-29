count=$(find . -type f -name "*.sh" -exec shellcheck -f gcc {} + | grep -c "warning:")
echo "Count warning: $count"