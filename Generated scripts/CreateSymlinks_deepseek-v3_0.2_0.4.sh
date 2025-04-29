#!/bin/bash
for src_file in /usr/src/*.java; do
    if [ -f "$src_file" ]; then
        ln -s "$src_file" "./$(basename "$src_file")"
    fi
done