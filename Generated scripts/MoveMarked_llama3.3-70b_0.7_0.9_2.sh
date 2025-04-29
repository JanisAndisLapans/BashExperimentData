mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' file; do
  mv "$file" /etc/movedDocs
  mv "${file%.found}" /etc/movedDocs
done