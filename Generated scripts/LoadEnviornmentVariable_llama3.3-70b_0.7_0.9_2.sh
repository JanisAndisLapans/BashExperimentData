USERNAME_VAR=$(grep ^USERNAME=. .env | cut -d '=' -f2-)
export USERNAME="$USERNAME_VAR"