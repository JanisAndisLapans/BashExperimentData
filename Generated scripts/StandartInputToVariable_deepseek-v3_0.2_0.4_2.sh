# Read stdin into variable 'text' until first '%' character, including newlines
text=""
while IFS= read -r -d '' -n1 char; do
    if [[ "$char" == "%" ]]; then
        break
    fi
    text+="$char"
done