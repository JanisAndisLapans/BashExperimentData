mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -exec mv {} /etc/movedDocs \; -exec mv {} | sed 's/\.found$//' /etc/movedDocs \;