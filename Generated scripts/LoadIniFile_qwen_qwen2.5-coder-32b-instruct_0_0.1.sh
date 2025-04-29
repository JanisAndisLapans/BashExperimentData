while IFS== read -r key value; do
    key=$(echo "$key" | tr -d '[:space:]')
    value=$(echo "$value" | tr -d '[:space:]')
    export "$key=$value"
done < <(grep -v '^#' settings.ini | grep '=')