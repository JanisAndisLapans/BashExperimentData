while IFS= read -r line; do
    # Strip comments and skip empty lines/sections
    line_clean=${line%%;*}
    [[ "$line_clean" =~ ^[[:space:]]*$ || "$line_clean" =~ ^\[ ]] && continue
    
    # Split key=value and trim whitespace
    if [[ "$line_clean" =~ ^[[:space:]]*([^=]+)=(.*) ]]; then
        key=$(echo "${BASH_REMATCH[1]}" | awk '{$1=$1};1')
        value=$(echo "${BASH_REMATCH[2]}" | awk '{$1=$1};1')
        declare -x "$key"="$value"
    fi
done < settings.ini