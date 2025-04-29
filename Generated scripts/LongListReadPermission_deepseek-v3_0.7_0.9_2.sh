for file in *; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        ls -l "$file"
    fi
done