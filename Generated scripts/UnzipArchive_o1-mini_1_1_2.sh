#!/bin/bash

# Find the first archive file matching archive.* in the current directory
file=$(find . -maxdepth 1 -type f -name 'archive.*' -print -quit)

if [ -z "$file" ]; then
    echo "No archive file named archive.* found in the current directory."
    exit 1
fi

case "$file" in
    *.tar.gz|*.tgz)
        tar -xzf "$file"
        ;;
    *.tar.bz2|*.tbz2)
        tar -xjf "$file"
        ;;
    *.tar.xz|*.txz)
        tar -xJf "$file"
        ;;
    *.zip)
        unzip "$file"
        ;;
    *.7z)
        7z x "$file"
        ;;
    *.gz)
        gunzip "$file"
        ;;
    *.bz2)
        bunzip2 "$file"
        ;;
    *.xz)
        unxz "$file"
        ;;
    *)
        echo "Unsupported archive format: $file"
        exit 1
        ;;
esac