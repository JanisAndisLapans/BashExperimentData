#!/bin/bash

# Check if at least source and destination are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 [--sc|--sd] [--dr|--dk|--dd] [--sw] source destination"
    exit 1
fi

# Initialize flags
copy_mode=true
delete_source=false
dest_replace=true
dest_keep=false
dest_delete=false
swap_mode=false

# Parse flags
while [[ $# -gt 2 ]]; do
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
            dest_delete=false
            shift
            ;;
        --dk)
            dest_replace=false
            dest_keep=true
            dest_delete=false
            shift
            ;;
        --dd)
            dest_replace=false
            dest_keep=false
            dest_delete=true
            shift
            ;;
        --sw)
            swap_mode=true
            shift
            ;;
        *)
            echo "Unknown option: $1"
            exit 1
            ;;
    esac
done

# Get source and destination from remaining arguments
args=("$@")
source_dir="${args[-2]}"
dest_dir="${args[-1]}"

# Validate directories
if [ ! -d "${source_dir:?}" ]; then
    echo "Source directory does not exist: $source_dir"
    exit 1
fi

if [ ! -d "${dest_dir:?}" ]; then
    echo "Destination directory does not exist: $dest_dir"
    exit 1
fi

# Handle swap mode
if [ "$swap_mode" = true ]; then
    temp_dir=$(mktemp -d)
    mv "${source_dir:?}"/* "${temp_dir:?}/" 2>/dev/null
    mv "${dest_dir:?}"/* "${source_dir:?}/" 2>/dev/null
    mv "${temp_dir:?}"/* "${dest_dir:?}/" 2>/dev/null
    rm -rf "$temp_dir"
    exit 0
fi

# Handle destination deletion
if [ "$dest_delete" = true ]; then
    rm -rf "${dest_dir:?}"/*
fi

# Process files
if [ "$copy_mode" = true ]; then
    if [ "$dest_replace" = true ]; then
        cp -rf "${source_dir:?}"/* "${dest_dir:?}/" 2>/dev/null
    elif [ "$dest_keep" = true ]; then
        for file in "${source_dir:?}"/*; do
            if [ -e "$file" ]; then
                base=$(basename "$file")
                if [ ! -e "${dest_dir:?}/$base" ]; then
                    cp -rf "$file" "${dest_dir:?}/"
                fi
            fi
        done
    fi
    if [ "$delete_source" = true ]; then
        rm -rf "${source_dir:?}"/*
    fi
else
    # Move mode (--sd)
    if [ "$dest_replace" = true ]; then
        for file in "${source_dir:?}"/*; do
            if [ -e "$file" ]; then
                base=$(basename "$file")
                if [ -e "${dest_dir:?}/$base" ]; then
                    rm -rf "${dest_dir:?}/$base"
                fi
                mv "$file" "${dest_dir:?}/"
            fi
        done
    elif [ "$dest_keep" = true ]; then
        for file in "${source_dir:?}"/*; do
            if [ -e "$file" ]; then
                base=$(basename "$file")
                if [ ! -e "${dest_dir:?}/$base" ]; then
                    mv "$file" "${dest_dir:?}/"
                elif [ "$delete_source" = true ]; then
                    rm -rf "$file"
                fi
            fi
        done
    elif [ "$dest_delete" = true ]; then
        # Special case for --sd --dd
        rm -rf "${dest_dir:?}"/*
        mv "${source_dir:?}"/* "${dest_dir:?}/" 2>/dev/null
    fi
fi