mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' file; do
    relative_path="${file#/etc/docs/}"
    dest_dir="/etc/movedDocs/$(dirname "$relative_path")"
    mkdir -p "$dest_dir"
    mv -- "$file" "$dest_dir/"
    mv -- "${file%.found}" "$dest_dir/"
done