#!/bin/bash

# Check for correct number of arguments
if [ $# -lt 2 ] || [ $# -gt 3 ]; then
    echo "Usage: $0 source destination [flag]" >&2
    exit 1
fi

source="$1"
dest="$2"
flag="${3:-}"

# Validate source directory
if [ ! -d "$source" ]; then
    echo "Error: Source directory does not exist" >&2
    exit 1
fi

# Create destination if it doesn't exist
mkdir -p "$dest"

case "$flag" in
    ""|--sc|--dr)
        rsync -a --info=progress2 "$source"/ "$dest"/
        ;;
    --sd)
        rsync -a --info=progress2 --remove-source-files "$source"/ "$dest"/
        find "$source" -mindepth 1 -depth -type d -empty -exec rmdir {} \;
        ;;
    --dk)
        rsync -a --info=progress2 --ignore-existing "$source"/ "$dest"/
        ;;
    --dd)
        shopt -s dotglob
        rm -rf "${dest:?}"/*
        rsync -a --info=progress2 "$source"/ "$dest"/
        ;;
    --sw)
        tmp=$(mktemp -d)
        rsync -a --info=progress2 --remove-source-files "$source"/ "$tmp"/
        rsync -a --info=progress2 --remove-source-files "$dest"/ "$source"/
        rsync -a --info=progress2 --remove-source-files "$tmp"/ "$dest"/
        rmdir "$tmp"
        ;;
    *)
        echo "Error: Invalid flag" >&2
        exit 1
        ;;
esac