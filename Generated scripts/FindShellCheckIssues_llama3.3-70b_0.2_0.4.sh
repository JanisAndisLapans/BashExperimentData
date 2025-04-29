count=$(shellcheck *.sh | grep -c "warning:")
echo "Count warning: $count"