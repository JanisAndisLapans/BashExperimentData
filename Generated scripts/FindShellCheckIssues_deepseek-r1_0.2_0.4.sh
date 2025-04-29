count=$(shellcheck -f gcc *.sh 2>/dev/null | grep -c ": warning")
echo "Count warning: $count"