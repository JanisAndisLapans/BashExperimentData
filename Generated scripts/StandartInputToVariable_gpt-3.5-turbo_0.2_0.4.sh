text=""
while IFS= read -r -n 1 char; do
    text+="$char"
    if [ "$char" = "%" ]; then
        break
    fi
done
echo "$text"