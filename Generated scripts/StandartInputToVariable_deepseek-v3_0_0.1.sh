text=""
while IFS= read -r -n1 char; do
    if [[ "$char" == "%" ]]; then
        break
    fi
    text+="$char"
done