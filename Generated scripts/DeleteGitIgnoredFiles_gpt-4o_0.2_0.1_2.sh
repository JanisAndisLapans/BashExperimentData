#!/bin/bash

# Ensure we are in a git repository
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
  echo "Not inside a git repository."
  exit 1
fi

# Get the list of files to be deleted according to .gitignore
mapfile -t files_to_delete < <(git ls-files --others --ignored --exclude-standard)

# Check if there are files to delete
if [ ${#files_to_delete[@]} -eq 0 ]; then
  echo "No files to delete."
  exit 0
fi

# Delete the files
for file in "${files_to_delete[@]}"; do
  rm -rf -- "$file"
done