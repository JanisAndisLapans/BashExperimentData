#!/bin/bash

# Create temporary directory
tmpdir=$(mktemp -d)
trap 'rm -rf "$tmpdir"' EXIT

# Find all files and group by size first (optimization)
find /usr/files -type f -printf "%s\n" | sort -n | uniq -d > "$tmpdir/duplicate_sizes"

# For each duplicate size, find and compare files
while read -r size; do
    # Create checksum file for this size group
    checksum_file="$tmpdir/checksums_$size"
    touch "$checksum_file"
    
    # Process all files of this size
    find /usr/files -type f -size "${size}c" -print0 | while IFS= read -r -d '' file; do
        # Get full checksum (not just first bytes)
        checksum=$(md5sum "$file" | cut -d' ' -f1)
        # Get device and inode to identify hard links
        inode=$(stat -c '%i' "$file")
        device=$(stat -c '%d' "$file")
        
        # Store file path with unique identifier
        echo "$file" >> "$tmpdir/${checksum}_${device}_${inode}"
    done
done < "$tmpdir/duplicate_sizes"

# Output groups of identical files
find "$tmpdir" -type f -name "*_*_*" | while read -r group; do
    # Only show groups with more than one file
    if [ $(wc -l < "$group") -gt 1 ]; then
        # Replace newlines with spaces
        files=$(tr '\n' ' ' < "$group")
        # Remove trailing space and print
        echo "${files% }"
    fi
done