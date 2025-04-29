#!/bin/bash

# Check if at least source and destination are provided
if [ $# -lt 2 ]; then
    echo "Usage: $0 source destination [--sc|--sd] [--dr|--dk|--dd] [--sw]"
    exit 1
fi

# Initialize variables
source_dir="${1:?Source directory not specified}"
dest_dir="${2:?Destination directory not specified}"
operation="--sc"  # default operation
conflict_resolution="--dr"  # default conflict resolution
swap_flag=0

# Process flags
for arg in "${@:3}"; do
    case "$arg" in
        --sc|--sd)
            operation="$arg"
            ;;
        --dr|--dk|--dd)
            conflict_resolution="$arg"
            ;;
        --sw)
            swap_flag=1
            ;;
        *)
            echo "Unknown option: $arg" >&2
            exit 1
            ;;
    esac
done

# Validate directories
if [ ! -d "$source_dir" ]; then
    echo "Source directory does not exist: $source_dir" >&2
    exit 1
fi

if [ ! -d "$dest_dir" ]; then
    echo "Destination directory does not exist: $dest_dir" >&2
    exit 1
fi

# Handle swap operation
if [ $swap_flag -eq 1 ]; then
    temp_dir=$(mktemp -d) || exit 1
    shopt -s dotglob
    mv -- "$source_dir"/* "$temp_dir/" || exit 1
    mv -- "$dest_dir"/* "$source_dir/" || exit 1
    mv -- "$temp_dir"/* "$dest_dir/" || exit 1
    rmdir -- "$temp_dir" || exit 1
    exit 0
fi

# Handle destination preparation
case "$conflict_resolution" in
    --dd)
        rm -rf -- "${dest_dir:?}"/* || exit 1
        ;;
esac

# Perform the main operation
shopt -s dotglob
case "$operation" in
    --sc)
        # Copy from source
        case "$conflict_resolution" in
            --dr)
                cp -rf -- "${source_dir:?}"/* "${dest_dir:?}/" || exit 1
                ;;
            --dk)
                for item in "${source_dir:?}"/*; do
                    dest_item="${dest_dir:?}/$(basename -- "$item")"
                    if [ ! -e "$dest_item" ]; then
                        cp -rf -- "$item" "${dest_dir:?}/" || exit 1
                    fi
                done
                ;;
        esac
        ;;
    --sd)
        # Move from source (delete from source)
        case "$conflict_resolution" in
            --dr)
                mv -f -- "${source_dir:?}"/* "${dest_dir:?}/" || exit 1
                ;;
            --dk)
                for item in "${source_dir:?}"/*; do
                    dest_item="${dest_dir:?}/$(basename -- "$item")"
                    if [ ! -e "$dest_item" ]; then
                        mv -f -- "$item" "${dest_dir:?}/" || exit 1
                    else
                        rm -rf -- "$item" || exit 1
                    fi
                done
                ;;
        esac
        ;;
esac