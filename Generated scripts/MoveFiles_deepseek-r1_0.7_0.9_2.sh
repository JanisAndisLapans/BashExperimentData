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

for flag in "$@"; do
    case "$flag" in
        --sw) swap_mode=1 ;;
        --sd) delete_source=1 ;;
        --dd) delete_dest=1 ;;
        --dk) overwrite="keep" ;;
        --dr) overwrite="replace" ;;
        --sc) : ;; # Now handled through delete_source=0
        *) echo "Unknown flag: $flag" >&2; exit 1 ;;
    esac
done

# Handle swap mode
if [ $swap_mode -eq 1 ]; then
    tmp=$(mktemp -d)
    shopt -s dotglob
    mv -- "$source"/* "$tmp"/
    mv -- "$dest"/* "$source"/
    mv -- "$tmp"/* "$dest"/
    rmdir "$tmp"
    shopt -u dotglob
    exit 0
fi

# Clean destination if requested
if [ $delete_dest -eq 1 ]; then
    shopt -s dotglob
    rm -rf -- "${dest:?}"/*
    shopt -u dotglob
fi

# Determine copy/move action and flags
if [ $delete_source -eq 1 ]; then
    cmd=(mv)
    case $overwrite in
        keep) overwrite_flags=(-n) ;;
        *) overwrite_flags=(-f) ;;
    esac
else
    cmd=(cp -a)
    case $overwrite in
        keep) overwrite_flags=(-n) ;;
        *) overwrite_flags=(-f) ;;
    esac
fi

# Execute the operation
shopt -s dotglob
if [ "${cmd[0]}" = "cp" ]; then
    "${cmd[@]}" "${overwrite_flags[@]}" -- "$source"/. "$dest/"
else
    files=("$source"/*)
    if [ ${#files[@]} -gt 0 ]; then
        "${cmd[@]}" "${overwrite_flags[@]}" -- "$source"/* "$dest/"
    fi
fi
shopt -u dotglob