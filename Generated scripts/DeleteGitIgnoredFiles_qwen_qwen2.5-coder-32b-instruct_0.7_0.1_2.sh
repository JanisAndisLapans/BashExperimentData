#!/bin/bash

# Ensure git is installed
if ! command -v git &> /dev/null; then
    apt update && apt install -y git
fi

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo ".gitignore file not found in the current directory."
    exit 1
fi

# Use git to list ignored files and delete them
git clean -fdX

# Verify if there are any files left that should be ignored
ignored_files=$(git check-ignore -v ./** 2>/dev/null | awk '{print $3}' | sort -u)

if [ -z "$ignored_files" ]; then
    echo "No files to delete according to .gitignore."
else
    echo "Deleting files according to .gitignore:"
    echo "$ignored_files"
    xargs -r rm -f <<< "$ignored_files"
fi