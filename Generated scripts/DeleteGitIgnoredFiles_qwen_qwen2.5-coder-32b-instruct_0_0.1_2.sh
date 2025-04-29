#!/bin/bash

# Ensure git is installed
if ! command -v git &> /dev/null; then
    apt update && apt install -y git
fi

# Find the .gitignore file in the current directory or parent directories
GITIGNORE_PATH=$(git rev-parse --show-toplevel 2>/dev/null)

if [ -z "$GITIGNORE_PATH" ]; then
    echo "No .git repository found. Exiting."
    exit 1
fi

# Change to the root of the git repository
cd "$GITIGNORE_PATH"

# Use git to list ignored files and delete them
git clean -fdX