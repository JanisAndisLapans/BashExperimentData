#!/bin/bash

# Create a temporary directory for storing file information
tmpdir=$(mktemp -d)

# Find all files in /usr/files and process them
find /usr/files -type f -print0 | while IFS= read -r -d $'\0' file; do
    # Get inode and device to identify hard links
    inode=$(stat -c '%i' "$file")
    device=$(stat -c '%d' "$file")
    
    # Get file size and first few bytes as checksum (for quick comparison)
    size=$(stat -c '%s' "$file")
    checksum=$(head -c 1024 "$file" | md5sum | cut -d' ' -f1)
    
    # Create a unique identifier combining device and inode
    unique_id="${device}:${inode}"
    
    # Store file path with its unique_id, size, and checksum
    echo "$file" >> "$tmpdir/files_${unique_id}_${size}_${checksum}.txt"
done

# Now compare files with same size and initial checksum
find "$tmpdir" -type f -name 'files_*.txt' | while read -r group; do
    # Get the first file in the group
    first_file=$(head -n 1 "$group")
    
    # If we have multiple files or the checksum file has multiple entries
    if [ $(wc -l < "$group") -gt 1 ]; then
        # Verify with full checksum if needed
        full_md5=$(md5sum "$first_file" | cut -d' ' -f1)
        same_files=("$first_file")
        
        # Compare with other files in the group
        while read -r other_file; do
            if [ "$other_file" != "$first_file" ]; then
                other_md5=$(md5sum "$other_file" | cut -d' ' -f1)
                if [ "$full_md5" = "$other_md5" ]; then
                    same_files+=("$other_file")
                fi
            fi
        done < "$group"
        
        # If we found duplicates, print them
        if [ ${#same_files[@]} -gt 1 ]; then
            echo "${same_files[@]}"
        fi
    fi
done

# Clean up
rm -rf "$tmpdir"