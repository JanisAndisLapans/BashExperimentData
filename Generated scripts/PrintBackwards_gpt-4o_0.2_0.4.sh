while IFS= read -r line; do
    echo "result = $(echo "$line" | rev)"
done < info.txt