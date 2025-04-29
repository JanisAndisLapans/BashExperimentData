#!/bin/bash

# Find all files matching archive.*
files=( archive.* )

# Check if there is exactly one archive file
if [[ ${#files[@]} -eq 0 ]]; then
    echo "Error: No archive.* file found." >&2
    exit 1
elif [[ ${#files[@]} -gt 1 ]]; then
    echo "Error: Multiple archive.* files found. Only one expected." >&2
    exit 1
fi

file="${files[0]}"

# Extract based on file extension
case "$file" in
    *.tar.gz|*.tgz)    tar -xzf "$file" ;;
    *.tar.bz2|*.tbz2)  tar -xjf "$file" ;;
    *.tar.xz|*.txz)    tar -xJf "$file" ;;
    *.tar)             tar -xf "$file" ;;
    *.zip)             unzip "$file" ;;
    *.rar)             unrar x "$file" ;;
    *.gz)              gunzip "$file" ;;
    *.bz2)             bunzip2 "$file" ;;
    *.xz)              unxz "$file" ;;
    *.7z)              7z x "$file" ;;
    *)
        echo "Error: Unsupported archive format: $file" >&2
        exit 1
        ;;
esac

# Check if extraction succeeded
if [[ $? -ne 0 ]]; then
    echo "Error: Failed to extract $file" >&2
    exit 1
fi

echo "Successfully extracted: $file"