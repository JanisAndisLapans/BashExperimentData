while IFS='=' read -r key value; do
    key=$(echo "$key" | tr -d '[:space:]')
    value=$(echo "$value" | tr -d '[:space:]')
    if [[ -n "$key" && ! "$key" =~ ^# ]]; then
        export "$key=$value"
    fi
done < settings.ini