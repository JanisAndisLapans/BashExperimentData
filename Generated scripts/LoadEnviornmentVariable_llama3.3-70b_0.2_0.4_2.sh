USERNAME=$(grep "^USERNAME=" .env | cut -d "=" -f2-)
echo "$USERNAME"