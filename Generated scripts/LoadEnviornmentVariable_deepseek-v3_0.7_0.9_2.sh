# Read .env file line by line, extract only USERNAME
while IFS='=' read -r key value; do
    if [ "$key" = "USERNAME" ]; then
        USERNAME="$value"
        break
    fi
done < ".env"

# Output the value with proper quoting
echo "$USERNAME"