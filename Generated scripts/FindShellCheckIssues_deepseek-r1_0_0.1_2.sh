count=$(find . -maxdepth 1 -type f -name '*.sh' -exec shellcheck --format=gcc {} + | grep -c ": warning: ")
echo "Count warning: $count"