#!/bin/bash

source_dir=$1
dest_dir=$2

if [ "$#" -ne 2 ]; then
    echo "Usage: $0 source_dir dest_dir"
    exit 1
fi

if [ ! -d "$source_dir" ] || [ ! -d "$dest_dir" ]; then
    echo "Both source and destination directories must exist."
    exit 1
fi

if [ "$3" == "--sc" ]; then
    cp -r "$source_dir"/* "$dest_dir"
elif [ "$3" == "--sd" ]; then
    mv "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dr" ]; then
    cp -ur "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dk" ]; then
    cp -n "$source_dir"/* "$dest_dir"
elif [ "$3" == "--dd" ]; then
    rm -rf "$dest_dir"/*
elif [ "$3" == "--sw" ]; then
    tmp_dir=$(mktemp -d)
    mv "$source_dir"/* "$tmp_dir"
    mv "$dest_dir"/* "$source_dir"
    mv "$tmp_dir"/* "$dest_dir"
    rmdir "$tmp_dir"
else
    cp -ur "$source_dir"/* "$dest_dir"
fi