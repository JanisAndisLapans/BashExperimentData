USERNAME=$(grep -E '^USERNAME=' .env | cut -d '=' -f 2)
echo $USERNAME