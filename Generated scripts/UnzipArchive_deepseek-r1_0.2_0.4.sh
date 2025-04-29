#!/bin/bash

# Enable nullglob to prevent literal interpretation if no files match
shopt -s nullglob

# Find all files matching archive.* pattern
files=(archive.*)

# Check if exactly one file exists
if [[ ${#files[@]} -ne 1 ]]; then
    echo "Error: Exactly one archive.* file must exist in the current directory" >&2
    exit 1
fi

filename="${files[0]}"

# Extract based on file extension
case "$filename" in
    *.tar.bz2|*.tbz2)  tar xjf "$filename" ;;
    *.tar.gz|*.tgz)    tar xzf "$filename" ;;
    *.tar.xz)          tar xJf "$filename" ;;
    *.tar)             tar xf "$filename" ;;
    *.zip)             unzip "$filename" ;;
    *.gz)              gunzip "$filename" ;;
    *.bz2)             bunzip2 "$filename" ;;
    *.rar)             unrar x "$filename" ;;
    *.7z)              7z x "$filename" ;;
    *)
        echo "Unsupported archive format: $filename" >&2
        exit 1
        ;;
esac

echo "Extracted $filename successfully"