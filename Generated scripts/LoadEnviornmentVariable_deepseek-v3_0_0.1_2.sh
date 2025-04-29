USERNAME=$(grep -E '^USERNAME=' .env | cut -d '=' -f2-)
echo "$USERNAME"