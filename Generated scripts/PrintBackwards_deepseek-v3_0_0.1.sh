while IFS= read -r line; do
  reversed=$(echo "$line" | rev)
  echo "result = $reversed"
done < info.txt