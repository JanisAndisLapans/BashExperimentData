count=$(find . -maxdepth 1 -type f -name "*.sh" -exec shellcheck -n {} \; | grep -c "warning:")
echo "Count warning: $count"