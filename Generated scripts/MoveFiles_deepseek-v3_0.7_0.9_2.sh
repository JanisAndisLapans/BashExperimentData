#!/bin/bash

# Check if at least source and destination are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 [--sc|--sd] [--dr|--dk|--dd] [--sw] source destination"
    exit 1
fi

# Initialize flags with default values
copy_mode=true
delete_source=false
dest_replace=true
dest_keep=false
dest_delete=false
swap_mode=false

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --sc)
            copy_mode=true
            delete_source=false
            shift
            ;;
        --sd)
            copy_mode=false
            delete_source=true
            shift
            ;;
        --dr)
            dest_replace=true
            dest_keep=false
            shift
            ;;
        --dk)
            dest_replace=false
            dest_keep=true
            shift
            ;;
        --dd)
            dest_delete=true
            shift
            ;;
        --sw)
            swap_mode=true
            shift
            ;;
        *)
            # First non-flag argument is source, second is destination
            if [ -z "$source" ]; then
                source="${1:?Source directory cannot be empty}"
            elif [ -z "$dest" ]; then
                dest="${1:?Destination directory cannot be empty}"
            else
                echo "Too many arguments"
                exit 1
            fi
            shift
            ;;
    esac
done

# Verify source and destination are provided
if [ -z "$source" ] || [ -z "$dest" ]; then
    echo "Source and destination directories must be specified"
    exit 1
fi

# Verify directories exist
if [ ! -d "$source" ]; then
    echo "Source directory does not exist: $source"
    exit 1
fi

if [ ! -d "$dest" ]; then
    echo "Destination directory does not exist: $dest"
    exit 1
fi

# Handle swap mode
if [ "$swap_mode" = true ]; then
    temp_dir=$(mktemp -d)
    mv "${source:?}"/* "$temp_dir"/
    mv "${dest:?}"/* "$source"/
    mv "$temp_dir"/* "$dest"/
    rmdir "$temp_dir"
    exit 0
fi

# Handle destination delete
if [ "$dest_delete" = true ]; then
    rm -rf "${dest:?}"/*
fi

# Process files
if [ "$copy_mode" = true ]; then
    if [ "$dest_replace" = true ]; then
        cp -rf "${source:?}"/* "${dest:?}"/
    elif [ "$dest_keep" = true ]; then
        # Copy only if destination doesn't exist
        for item in "${source:?}"/*; do
            dest_item="${dest:?}/$(basename "$item")"
            if [ ! -e "$dest_item" ]; then
                cp -r "$item" "${dest:?}"/
            fi
        done
    fi
fi

if [ "$delete_source" = true ]; then
    if [ "$dest_replace" = true ]; then
        mv -f "${source:?}"/* "${dest:?}"/
    elif [ "$dest_keep" = true ]; then
        # Move only if destination doesn't exist
        for item in "${source:?}"/*; do
            dest_item="${dest:?}/$(basename "$item")"
            if [ ! -e "$dest_item" ]; then
                mv "$item" "${dest:?}"/
            else
                rm -rf "$item"
            fi
        done
    fi
fi