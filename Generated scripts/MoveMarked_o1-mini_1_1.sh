mkdir -p /etc/movedDocs

for file in /etc/docs/*.docx.found; do
  mv "$file" /etc/movedDocs/
  corresponding="${file%.found}"
  if [ -f "$corresponding" ]; then
    mv "$corresponding" /etc/movedDocs/
  fi
done