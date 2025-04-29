#!/bin/bash

source_dir="$1"
dest_dir="$2"

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_dir dest_dir"
    exit 1
fi

if [ ! -d "$source_dir" ] || [ ! -d "$dest_dir" ]; then
    echo "Both source and destination directories must exist."
    exit 1
fi

copy_files() {
    cp -Rf "$1"/* "$2"
}

delete_files() {
    rm -rf "$1"/*
}

replace_files() {
    cp -Rf "$1"/* "$2"
}

keep_files() {
    cp -Rn "$1"/* "$2"
}

delete_dest() {
    rm -rf "$2"/*
}

swap_contents() {
    temp_dir=$(mktemp -d)
    mv "$1"/* "$temp_dir"
    mv "$2"/* "$1"
    mv "$temp_dir"/* "$2"
    rmdir "$temp_dir"
}

case "$3" in
    --sc)
        copy_files "$source_dir" "$dest_dir"
        ;;
    --sd)
        delete_files "$source_dir"
        ;;
    --dr)
        replace_files "$source_dir" "$dest_dir"
        ;;
    --dk)
        keep_files "$source_dir" "$dest_dir"
        ;;
    --dd)
        delete_dest "$dest_dir"
        copy_files "$source_dir" "$dest_dir"
        ;;
    --sw)
        swap_contents "$source_dir" "$dest_dir"
        ;;
    *)
        replace_files "$source_dir" "$dest_dir"
        ;;
esac