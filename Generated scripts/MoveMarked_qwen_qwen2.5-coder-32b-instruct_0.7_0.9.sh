mkdir -p /etc/movedDocs
find /etc/docs -type f \( -name "*.docx.found" -o -name "*.docx" \) -exec mv {} /etc/movedDocs \;