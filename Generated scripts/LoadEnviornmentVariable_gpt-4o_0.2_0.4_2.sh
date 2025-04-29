USERNAME=$(grep -oP '^USERNAME=\K.*' .env)
export USERNAME