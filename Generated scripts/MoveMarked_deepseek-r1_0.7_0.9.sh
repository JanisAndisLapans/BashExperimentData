mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' file; do
    docx_file="${file%.found}"
    mv -- "$file" "/etc/movedDocs/"
    mv -- "$docx_file" "/etc/movedDocs/"
done