USERNAME_LINE=$(grep -w '^USERNAME' .env)
USERNAME=$(echo "$USERNAME_LINE" | cut -d '=' -f2)
export USERNAME
echo "USERNAME: $USERNAME"