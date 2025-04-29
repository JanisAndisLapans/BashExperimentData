#!/bin/bash

source_dir="$1"
dest_dir="$2"

# Check if source and destination directories are provided
if [ -z "$source_dir" ] || [ -z "$dest_dir" ]; then
    echo "Usage: $0 <source_directory> <destination_directory>"
    exit 1
fi

# Move all contents from source to destination based on flags
if [ "$3" == "--sc" ]; then
    cp -r "$source_dir"/* "$dest_dir"
elif [ "$3" == "--sd" ]; then
    mv "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dr" ]; then
    yes | cp -rf "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dk" ]; then
    cp -n "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dd" ]; then
    rm -rf "$dest_dir"/*
    cp -r "$source_dir"/* "$dest_dir"
elif [ "$3" == "--sw" ]; then
    tmp_dir=$(mktemp -d)
    mv "$source_dir"/* "$tmp_dir"
    mv "$dest_dir"/* "$source_dir"
    mv "$tmp_dir"/* "$dest_dir"
    rmdir "$tmp_dir"
else
    cp -f "$source_dir"/* "$dest_dir"
fi