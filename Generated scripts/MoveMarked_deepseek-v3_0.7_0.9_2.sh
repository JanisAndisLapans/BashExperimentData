#!/bin/bash

# Create destination directory if it doesn't exist
mkdir -p /etc/movedDocs

# Find all .docx.found files and process them
find /etc/docs -type f -name "*.docx.found" -print0 | while IFS= read -r -d '' found_file; do
    # Get the corresponding .docx filename
    docx_file="${found_file%.found}"
    
    # Get relative path from /etc/docs
    rel_path="${found_file#/etc/docs/}"
    rel_path="${rel_path%/*}"
    
    # Create destination subdirectory if needed
    dest_dir="/etc/movedDocs/${rel_path}"
    mkdir -p "$dest_dir"
    
    # Move both files if they exist
    if [[ -f "$docx_file" ]]; then
        mv "$docx_file" "$found_file" "$dest_dir/"
    else
        mv "$found_file" "$dest_dir/"
    fi
done