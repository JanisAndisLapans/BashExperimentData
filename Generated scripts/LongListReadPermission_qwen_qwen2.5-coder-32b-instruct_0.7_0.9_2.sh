for file in *; do
    if [ -r "$file" ]; then
        ls -l "$file"
    fi
done