#!/bin/bash

# Check if source and destination directories are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 [--sc|--sd] [--dr|--dk|--dd] [--sw] source destination"
    exit 1
fi

# Initialize flags
copy_mode="sc"  # Default: copy from source
dest_behavior="dr"  # Default: replace same name in destination
swap_flag=0

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --sc)
            copy_mode="sc"
            shift
            ;;
        --sd)
            copy_mode="sd"
            shift
            ;;
        --dr)
            dest_behavior="dr"
            shift
            ;;
        --dk)
            dest_behavior="dk"
            shift
            ;;
        --dd)
            dest_behavior="dd"
            shift
            ;;
        --sw)
            swap_flag=1
            shift
            ;;
        *)
            # Assume remaining arguments are source and destination
            if [ -z "$source" ]; then
                source="$1"
            else
                destination="$1"
            fi
            shift
            ;;
    esac
done

# Verify source and destination are provided
if [ -z "$source" ] || [ -z "$destination" ]; then
    echo "Error: Both source and destination directories must be specified"
    exit 1
fi

# Verify directories exist
if [ ! -d "$source" ]; then
    echo "Error: Source directory '$source' does not exist"
    exit 1
fi

if [ ! -d "$destination" ]; then
    echo "Error: Destination directory '$destination' does not exist"
    exit 1
fi

# Handle swap mode
if [ $swap_flag -eq 1 ]; then
    temp_dir=$(mktemp -d)
    mv "$source"/* "$temp_dir/" 2>/dev/null
    mv "$destination"/* "$source/" 2>/dev/null
    mv "$temp_dir"/* "$destination/" 2>/dev/null
    rmdir "$temp_dir"
    exit 0
fi

# Handle destination behavior
case "$dest_behavior" in
    "dd")
        # Delete all existing in destination
        rm -rf "$destination"/*
        ;;
esac

# Handle copy/move operation
case "$copy_mode" in
    "sc")
        # Copy from source
        case "$dest_behavior" in
            "dr")
                cp -rf "$source"/* "$destination/"
                ;;
            "dk")
                # Copy only if file doesn't exist in destination
                for file in "$source"/*; do
                    dest_file="$destination/$(basename "$file")"
                    if [ ! -e "$dest_file" ]; then
                        cp -rf "$file" "$destination/"
                    fi
                done
                ;;
        esac
        ;;
    "sd")
        # Move (delete from source)
        case "$dest_behavior" in
            "dr")
                mv -f "$source"/* "$destination/" 2>/dev/null
                ;;
            "dk")
                # Move only if file doesn't exist in destination
                for file in "$source"/*; do
                    dest_file="$destination/$(basename "$file")"
                    if [ ! -e "$dest_file" ]; then
                        mv -f "$file" "$destination/" 2>/dev/null
                    else
                        rm -rf "$file"
                    fi
                done
                ;;
        esac
        ;;
esac