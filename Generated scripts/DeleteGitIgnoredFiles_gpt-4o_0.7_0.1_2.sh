mapfile -t ignored_files < <(git check-ignore **/*)
for file in "${ignored_files[@]}"; do
    rm -rf "$file"
done