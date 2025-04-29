for file in *; do
    if [ -r "$file" ]; then
        echo "$file"
    fi
done