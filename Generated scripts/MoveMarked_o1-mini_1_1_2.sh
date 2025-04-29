mkdir -p /etc/movedDocs

find /etc/docs -type f -name '*.docx.found' | while IFS= read -r file; do
  # Move the .docx.found file
  mv "$file" /etc/movedDocs/
  
  # Determine the corresponding .docx file
  corresponding="${file%.found}"
  
  # Check if the corresponding .docx file exists and move it
  if [ -f "$corresponding" ]; then
    mv "$corresponding" /etc/movedDocs/
  fi
done