for file in *; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        echo "$file"
    fi
done