#!/bin/bash

# Create a temporary directory for storing file information
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

# Find all files in /usr/files and its subdirectories
find /usr/files -type f -print0 | while IFS= read -r -d '' file; do
    # Get inode and device to identify hard links
    inode=$(stat -c '%i' "$file")
    device=$(stat -c '%d' "$file")
    
    # Get file size and first few bytes as a checksum
    size=$(stat -c '%s' "$file")
    checksum=$(head -c 1024 "$file" | md5sum | cut -d' ' -f1)
    
    # Create a unique identifier for potential duplicates
    echo "$file" >> "$tmpdir/files_${device}_${inode}_${size}_${checksum}"
done

# Output groups of identical files
find "$tmpdir" -type f -size +0c | while read -r group; do
    # Only show groups with more than one file
    if [ $(wc -l < "$group") -gt 1 ]; then
        tr '\n' ' ' < "$group"
        echo
    fi
done