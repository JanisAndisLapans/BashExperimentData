for file in *; do
    if [ -f "$file" ] && [ -r "$file" ]; then
        ls -l "$file"
    fi
done
find . -maxdepth 1 -type f -perm -u=r -exec ls -l {} +