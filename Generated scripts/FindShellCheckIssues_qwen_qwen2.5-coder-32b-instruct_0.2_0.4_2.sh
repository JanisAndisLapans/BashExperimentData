count=$(shellcheck ./*.sh | grep -c '^WARNING')
echo "Count warning: $count"