#!/bin/bash

src_dir="/etc/docs"
dest_dir="/etc/movedDocs"

find "$src_dir" -type f -name "*.docx.found" -exec sh -c '
    for found_file; do
        base_dir=$(dirname "$found_file")
        dest_subdir="${base_dir#$src_dir}"
        dest_subdir="${dest_subdir#/}"
        mkdir -p "$dest_dir/$dest_subdir"
        mv "$found_file" "$dest_dir/$dest_subdir/"
        mv "${found_file%.found}" "$dest_dir/$dest_subdir/"
    done
' find-sh {} +