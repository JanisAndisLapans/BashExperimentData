#!/bin/bash
mkdir -p /etc/movedDocs
for found_file in /etc/docs/*.docx.found; do
    base_name="${found_file%.found}"
    if [ -f "$base_name" ]; then
        mv "$base_name" /etc/movedDocs
        mv "$found_file" /etc/movedDocs
    fi
done