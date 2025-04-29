mkdir -p /etc/movedDocs
find /etc/docs -type f -name '*.docx.found' -print0 | while IFS= read -r -d '' found_file; do
    docx_file="${found_file%.found}"
    if [[ -f "$docx_file" ]]; then
        relative_path="${found_file#/etc/docs/}"
        target_dir="/etc/movedDocs/${relative_path%/*}"
        mkdir -p "$target_dir"
        mv -- "$found_file" "$docx_file" "$target_dir/"
    fi
done