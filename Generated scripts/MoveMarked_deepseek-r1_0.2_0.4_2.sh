#!/bin/bash
mkdir -p /etc/movedDocs
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' found_file; do
    docx_file="${found_file%.found}"
    relative_path=$(dirname "$found_file" | sed 's|^/etc/docs/||')
    target_dir="/etc/movedDocs/${relative_path}"
    mkdir -p "$target_dir"
    mv -f "$found_file" "$target_dir/" 2>/dev/null
    mv -f "$docx_file" "$target_dir/" 2>/dev/null
done