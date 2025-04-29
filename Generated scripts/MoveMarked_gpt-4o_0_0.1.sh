mkdir -p /etc/movedDocs
for file in /etc/docs/*.docx.found; do
    base_name="${file%.found}"
    mv "$file" /etc/movedDocs/
    if [ -e "$base_name" ]; then
        mv "$base_name" /etc/movedDocs/
    fi
done