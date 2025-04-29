mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" | while read -r file; do
    mv "$file" /etc/movedDocs/
    base_name="${file%.found}"
    if [ -e "$base_name" ]; then
        mv "$base_name" /etc/movedDocs/
    fi
done