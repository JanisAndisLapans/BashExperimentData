#!/bin/bash

if [ $# -lt 2 ]; then
    echo "Usage: $0 [options] source destination"
    echo "Options:"
    echo "  --sc : copy from source (default)"
    echo "  --sd : delete from source (move)"
    echo "  --dr : replace same name in destination (default)"
    echo "  --dk : keep same name in destination"
    echo "  --dd : delete all existing in destination first"
    echo "  --sw : swap contents of directories"
    exit 1
fi

# Initialize flags with default values
action="cp"  # Default: copy (--sc)
dest_behavior="replace"  # Default: replace (--dr)
delete_dest=false
swap=false

# Parse flags
while [[ $# -gt 0 ]]; do
    case "$1" in
        --sc)
            action="cp"
            shift
            ;;
        --sd)
            action="mv"
            shift
            ;;
        --dr)
            dest_behavior="replace"
            shift
            ;;
        --dk)
            dest_behavior="keep"
            shift
            ;;
        --dd)
            delete_dest=true
            shift
            ;;
        --sw)
            swap=true
            shift
            ;;
        *)
            # First non-flag argument is source, second is destination
            if [ -z "$source" ]; then
                source="$1"
            else
                destination="$1"
            fi
            shift
            ;;
    esac
done

# Validate arguments
if [ -z "$source" ] || [ -z "$destination" ]; then
    echo "Error: Both source and destination directories must be specified"
    exit 1
fi

if [ ! -d "$source" ]; then
    echo "Error: Source directory '$source' does not exist"
    exit 1
fi

if [ ! -d "$destination" ]; then
    echo "Error: Destination directory '$destination' does not exist"
    exit 1
fi

# Handle swap case
if [ "$swap" = true ]; then
    temp_dir=$(mktemp -d)
    echo "Swapping contents between $source and $destination"
    mv "$source"/* "$temp_dir/"
    mv "$destination"/* "$source/"
    mv "$temp_dir"/* "$destination/"
    rmdir "$temp_dir"
    exit 0
fi

# Handle delete destination case
if [ "$delete_dest" = true ]; then
    echo "Deleting all contents in destination directory $destination"
    rm -rf "${destination:?}/"*  # :? prevents accidental deletion if variable is empty
fi

# Perform the operation
echo "Processing files from $source to $destination"
for item in "$source"/*; do
    item_name=$(basename "$item")
    dest_path="$destination/$item_name"
    
    if [ "$dest_behavior" = "keep" ] && [ -e "$dest_path" ]; then
        echo "Skipping $item_name (exists in destination)"
        continue
    fi
    
    if [ "$action" = "cp" ]; then
        echo "Copying $item_name"
        cp -r "$item" "$destination/"
    else
        echo "Moving $item_name"
        mv "$item" "$destination/"
    fi
done

echo "Operation completed"