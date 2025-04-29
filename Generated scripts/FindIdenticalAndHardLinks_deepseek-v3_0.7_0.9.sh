#!/bin/bash

# Create a temporary directory for storing file information
tmpdir=$(mktemp -d)

# Find all files in /usr/files and its subdirectories
find /usr/files -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get inode and device to identify hard links
    inode=$(stat -c '%i' "$file")
    device=$(stat -c '%d' "$file")
    
    # Get file size and first few bytes as checksum
    size=$(stat -c '%s' "$file")
    checksum=$(head -c 1024 "$file" | md5sum | cut -d' ' -f1)
    
    # Create a unique identifier combining device, inode, size and partial checksum
    id="${device}:${inode}:${size}:${checksum}"
    
    # Append file path to the identifier's record
    echo "$file" >> "$tmpdir/$id"
done

# Output files with identical identifiers (including hard links)
for idfile in "$tmpdir"/*; do
    # Only show groups with more than one file
    if [ $(wc -l < "$idfile") -gt 1 ]; then
        # Replace newlines with spaces
        tr '\n' ' ' < "$idfile"
        echo # Add newline after each group
    fi
done

# Clean up
rm -rf "$tmpdir"