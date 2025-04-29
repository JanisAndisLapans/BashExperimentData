text=""
while IFS= read -r -n1 char; do
    if [[ "$char" == "%" ]]; then
        break
    fi
    text+="$char"
done < /dev/stdin
echo -e "line1\nline2%line3" | ./yourscript.sh
# $text will contain "line1\nline2"