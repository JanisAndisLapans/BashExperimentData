mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" | while read -r file; do
    base_name="${file%.found}"
    mv "$file" /etc/movedDocs/
    if [ -e "$base_name" ]; then
        mv "$base_name" /etc/movedDocs/
    fi
done