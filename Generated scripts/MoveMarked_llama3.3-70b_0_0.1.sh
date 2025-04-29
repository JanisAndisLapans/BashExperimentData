mkdir -p /etc/movedDocs
find /etc/docs -name "*.docx.found" -exec mv {} /etc/movedDocs \;
find /etc/docs -name "*.docx" -exec mv {} /etc/movedDocs \;