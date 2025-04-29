#!/bin/bash

# Move all *.docx.found files and their corresponding *.docx files under /etc/docs to /etc/movedDocs

# Create the destination directory if it doesn't exist
mkdir -p /etc/movedDocs

# Move the files
find /etc/docs -type f -name "*.docx.found" -exec sh -c 'mv "$1" /etc/movedDocs/$(basename "$1" .found)' _ {} \;
find /etc/docs -type f -name "*.docx" -exec sh -c 'mv "$1" /etc/movedDocs/$(basename "$1" .docx)' _ {} \;