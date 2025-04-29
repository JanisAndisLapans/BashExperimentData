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
declare -a cmd  # Array to hold extraction command and arguments

# Determine extraction command based on file extension
case "$file" in
    *.tar.gz|*.tgz)    cmd=(tar -xzf) ;;
    *.tar.bz2|*.tbz2)  cmd=(tar -xjf) ;;
    *.tar.xz|*.txz)    cmd=(tar -xJf) ;;
    *.tar)             cmd=(tar -xf) ;;
    *.zip)             cmd=(unzip) ;;
    *.rar)             cmd=(unrar x) ;;
    *.gz)              cmd=(gunzip) ;;
    *.bz2)             cmd=(bunzip2) ;;
    *.xz)              cmd=(unxz) ;;
    *.7z)              cmd=(7z x) ;;
    *)
        echo "Error: Unsupported archive format: $file" >&2
        exit 1
        ;;
esac

# Execute extraction command and check exit code directly
if ! "${cmd[@]}" "$file"; then
    echo "Error: Failed to extract $file" >&2
    exit 1
fi

echo "Successfully extracted: $file"