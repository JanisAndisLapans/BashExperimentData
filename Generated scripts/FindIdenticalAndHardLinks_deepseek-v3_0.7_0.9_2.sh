#!/bin/bash

# Create temporary directory
tmpdir=$(mktemp -d) || exit 1

# Process each file
find /usr/files -type f -print0 | while IFS= read -r -d '' file; do
    # Get unique identifier (device + inode) to detect hard links
    file_id=$(stat -c '%d:%i' -- "$file")
    
    # Get full file checksum (SHA-256)
    checksum=$(sha256sum -- "$file" | cut -d' ' -f1)
    
    # Store file path under both identifiers
    echo "$file" >> "$tmpdir/by_id_$file_id"
    echo "$file" >> "$tmpdir/by_hash_$checksum"
done

# Output duplicate groups
{
    # Find hard link duplicates (same inode)
    find "$tmpdir" -name 'by_id_*' -type f -size +0c | while read -r idfile; do
        files=()
        while IFS= read -r -d '' file; do
            files+=("$file")
        done < <(tr '\n' '\0' < "$idfile")
        
        if [ "${#files[@]}" -gt 1 ]; then
            printf '%s ' "${files[@]}"
            printf '\n'
        fi
    done
    
    # Find content duplicates (same hash)
    find "$tmpdir" -name 'by_hash_*' -type f -size +0c | while read -r hashfile; do
        files=()
        while IFS= read -r -d '' file; do
            files+=("$file")
        done < <(tr '\n' '\0' < "$hashfile")
        
        if [ "${#files[@]}" -gt 1 ]; then
            printf '%s ' "${files[@]}"
            printf '\n'
        fi
    done
} | sort -u

# Clean up
rm -rf "$tmpdir"