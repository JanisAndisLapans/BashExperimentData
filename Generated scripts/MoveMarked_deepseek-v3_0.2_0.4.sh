#!/bin/bash

# Create destination directory if it doesn't exist
mkdir -p /etc/movedDocs

# Find all .docx.found files under /etc/docs and process them
find /etc/docs -type f -name "*.docx.found" | while read found_file; do
    # Get the corresponding .docx file path
    docx_file="${found_file%.found}"
    
    # Move both files if they exist
    if [[ -f "$docx_file" ]]; then
        mv "$docx_file" "$found_file" /etc/movedDocs/
    else
        mv "$found_file" /etc/movedDocs/
    fi
done