#!/bin/bash

# Check if at least source and destination are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 [--sc|--sd] [--dr|--dk|--dd] [--sw] source destination"
    exit 1
fi

# Initialize flags
copy_mode="sc"  # Default is copy (sc)
dest_behavior="dr"  # Default is replace (dr)
swap_flag=0

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --sc|--sd)
            copy_mode="${1#--}"
            shift
            ;;
        --dr|--dk|--dd)
            dest_behavior="${1#--}"
            shift
            ;;
        --sw)
            swap_flag=1
            shift
            ;;
        *)
            # First non-flag argument is source, second is destination
            if [ -z "$source" ]; then
                source="$1"
            elif [ -z "$dest" ]; then
                dest="$1"
            else
                echo "Too many arguments"
                exit 1
            fi
            shift
            ;;
    esac
done

# Validate source and destination
if [ -z "$source" ] || [ -z "$dest" ]; then
    echo "Source and destination directories must be specified"
    exit 1
fi

if [ ! -d "$source" ]; then
    echo "Source directory does not exist: $source"
    exit 1
fi

if [ ! -d "$dest" ]; then
    echo "Destination directory does not exist: $dest"
    exit 1
fi

# Handle swap mode
if [ $swap_flag -eq 1 ]; then
    temp_dir=$(mktemp -d)
    echo "Swapping contents between $source and $dest"
    mv "$source"/* "$temp_dir/"
    mv "$dest"/* "$source/"
    mv "$temp_dir"/* "$dest/"
    rmdir "$temp_dir"
    exit 0
fi

# Handle destination behavior first
case "$dest_behavior" in
    dd)
        echo "Deleting all contents in destination before operation"
        rm -rf "$dest"/*
        ;;
esac

# Handle the copy/delete operation
case "$copy_mode" in
    sc)
        echo "Copying contents from $source to $dest"
        case "$dest_behavior" in
            dr)
                cp -rf "$source"/* "$dest/"
                ;;
            dk)
                # Copy only if file doesn't exist in destination
                for item in "$source"/*; do
                    dest_item="$dest/$(basename "$item")"
                    if [ ! -e "$dest_item" ]; then
                        cp -rf "$item" "$dest/"
                    fi
                done
                ;;
        esac
        ;;
    sd)
        echo "Moving contents from $source to $dest"
        case "$dest_behavior" in
            dr)
                mv -f "$source"/* "$dest/"
                ;;
            dk)
                # Move only if file doesn't exist in destination
                for item in "$source"/*; do
                    dest_item="$dest/$(basename "$item")"
                    if [ ! -e "$dest_item" ]; then
                        mv -f "$item" "$dest/"
                    fi
                done
                ;;
        esac
        ;;
esac

echo "Operation completed"