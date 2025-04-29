#!/bin/bash

set -e

source="$1"
dest="$2"
shift 2

# Validate directories
if [ ! -d "$source" ] || [ ! -d "$dest" ]; then
    echo "Error: Source and destination must be directories" >&2
    exit 1
fi

# Parse flags
swap_mode=0
delete_source=0
delete_dest=0
overwrite="replace"
operation="copy"

for flag in "$@"; do
    case "$flag" in
        --sw) swap_mode=1 ;;
        --sd) delete_source=1 ;;
        --dd) delete_dest=1 ;;
        --dk) overwrite="keep" ;;
        --dr) overwrite="replace" ;;
        --sc) operation="copy" ;;
        *) echo "Unknown flag: $flag" >&2; exit 1 ;;
    esac
done

# Handle swap mode
if [ $swap_mode -eq 1 ]; then
    tmp=$(mktemp -d)
    shopt -s dotglob
    mv "$source"/* "$tmp"/
    mv "$dest"/* "$source"/
    mv "$tmp"/* "$dest"/
    rmdir "$tmp"
    shopt -u dotglob
    exit 0
fi

# Clean destination if requested
if [ $delete_dest -eq 1 ]; then
    shopt -s dotglob
    rm -rf "$dest"/*
    shopt -u dotglob
fi

# Determine copy/move action
if [ $delete_source -eq 1 ]; then
    cmd="mv"
    overwrite_flag="-f"
    if [ "$overwrite" = "keep" ]; then
        overwrite_flag="-n"
    fi
else
    cmd="cp"
    overwrite_flag="-f"
    if [ "$overwrite" = "keep" ]; then
        overwrite_flag="-n"
    fi
    overwrite_flag+=" -a"
fi

# Execute the operation
shopt -s dotglob
if [ "$cmd" = "cp" ]; then
    cp $overwrite_flag "$source"/. "$dest"/
else
    files=("$source"/*)
    if [ ${#files[@]} -gt 0 ]; then
        mv $overwrite_flag "$source"/* "$dest"/
    fi
fi
shopt -u dotglob