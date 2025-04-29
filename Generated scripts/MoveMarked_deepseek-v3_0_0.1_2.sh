#!/bin/bash

# Create the destination directory if it doesn't exist
mkdir -p /etc/movedDocs

# Find all .docx.found files under /etc/docs and process them
find /etc/docs -type f -name "*.docx.found" | while read -r found_file; do
    # Get the corresponding .docx file path by removing the .found suffix
    docx_file="${found_file%.found}"
    
    # Get the relative path (removing /etc/docs prefix)
    relative_path="${found_file#/etc/docs/}"
    relative_path="${relative_path%/*}"  # Get directory part
    
    # Create destination subdirectory if needed
    dest_dir="/etc/movedDocs/$relative_path"
    mkdir -p "$dest_dir"
    
    # Check if the corresponding .docx file exists
    if [ -f "$docx_file" ]; then
        # Move both files to the destination directory
        mv "$found_file" "$docx_file" "$dest_dir/"
    else
        echo "Warning: Corresponding .docx file not found for $found_file"
    fi
done