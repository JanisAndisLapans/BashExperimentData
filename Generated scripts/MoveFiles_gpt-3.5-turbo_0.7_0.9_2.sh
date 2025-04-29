#!/bin/bash

source_dir="$1"
destination_dir="$2"
shift 2

if [ "$1" == "--sc" ]; then
    cp -r "$source_dir"/. "$destination_dir"
elif [ "$1" == "--sd" ]; then
    mv "$source_dir"/* "$destination_dir"
elif [ "$1" == "--dr" ]; then
    cp -ur "$source_dir"/. "$destination_dir"
elif [ "$1" == "--dk" ]; then
    cp -n "$source_dir"/* "$destination_dir"
elif [ "$1" == "--dd" ]; then
    rm -rf "$destination_dir"/*
    cp -r "$source_dir"/* "$destination_dir"
elif [ "$1" == "--sw" ]; then
    temp_dir=$(mktemp -d)
    mv "$source_dir"/* "$temp_dir"
    mv "$destination_dir"/* "$source_dir"
    mv "$temp_dir"/* "$destination_dir"
    rmdir "$temp_dir"
else
    cp -r "$source_dir"/* "$destination_dir"
fi