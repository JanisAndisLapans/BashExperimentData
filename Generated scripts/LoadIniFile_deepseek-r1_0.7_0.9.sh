shopt -s extglob
while IFS= read -r line; do
    [[ "$line" =~ ^[[:space:]]*([;#]|\[|$) ]] && continue
    if [[ "$line" =~ ^[[:space:]]*([^=]+?)[[:space:]]*=[[:space:]]*(.*) ]]; then
        key="${BASH_REMATCH[1]}"
        value="${BASH_REMATCH[2]%%;*}"
        key="${key%%+([[:space:]])}"
        key="${key##+([[:space:]])}"
        value="${value%%+([[:space:]])}"
        value="${value##+([[:space:]])}"
        declare -g -- "${key}"="${value}"
    fi
done < settings.ini
shopt -u extglob