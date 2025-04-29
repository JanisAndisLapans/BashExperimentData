mkdir -p /etc/movedDocs
for file in /etc/docs/*.docx.found; do
  docx_file="${file%.found}"
  if [ -f "$docx_file" ]; then
    mv "$file" "$docx_file" /etc/movedDocs
  fi
done