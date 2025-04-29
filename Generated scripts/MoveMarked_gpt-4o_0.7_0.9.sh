mkdir -p /etc/movedDocs
for file in /etc/docs/*.docx.found; do
    mv "$file" /etc/movedDocs/
    base_name="${file%.found}"
    if [ -e "$base_name" ]; then
        mv "$base_name" /etc/movedDocs/
    fi
done