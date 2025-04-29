while IFS= read -r line; do
    reversed=$(printf "%s" "$line" | rev)
    printf "result = %s\n" "$reversed"
done < info.txt