count=$(shellcheck *.sh | grep -i "warning:" | wc -l)
echo "Count warning: $count"