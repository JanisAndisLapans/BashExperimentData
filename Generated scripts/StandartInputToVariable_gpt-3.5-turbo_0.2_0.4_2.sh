text=""
while IFS= read -r -n 1 char; do
    if [ "$char" = "%" ]; then
        break
    fi
    text+="$char"
done
echo "$text"