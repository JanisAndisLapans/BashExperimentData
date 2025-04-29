#!/bin/bash
mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' found_file; do
    docx_file="${found_file%.found}"
    mv -f "$found_file" /etc/movedDocs/ 2>/dev/null
    mv -f "$docx_file" /etc/movedDocs/ 2>/dev/null
done