#!/bin/bash

# Create a temporary directory for storing file information
tmpdir=$(mktemp -d)

# Find all files in /usr/files and process them
find /usr/files -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get inode and device to identify hard links
    inode=$(stat -c '%i' "$file")
    device=$(stat -c '%d' "$file")
    
    # Get file size and full checksum
    size=$(stat -c '%s' "$file")
    checksum=$(md5sum "$file" | cut -d' ' -f1)
    
    # Create a unique identifier combining device, inode, size and checksum
    unique_id="${device}:${inode}:${size}:${checksum}"
    
    # Store file path with its unique_id
    echo "$file" >> "$tmpdir/${unique_id}.txt"
done

# Process each group of potentially identical files
find "$tmpdir" -type f -name '*.txt' -print0 | while IFS= read -r -d $'\0' group; do
    # Count files in this group
    count=$(wc -l < "$group")
    
    # If we have multiple files, print them
    if [ "$count" -gt 1 ]; then
        # Read all files in the group into an array
        mapfile -t files < "$group"
        # Print all files in the group on one line
        printf '%s\n' "${files[*]}"
    fi
done

# Clean up
rm -rf "$tmpdir"