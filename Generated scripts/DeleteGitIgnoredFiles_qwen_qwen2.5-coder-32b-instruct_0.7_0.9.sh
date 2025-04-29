#!/bin/bash

# Ensure git is installed
if ! command -v git &> /dev/null; then
    apt install -y git
fi

# Use git to identify and delete files according to .gitignore
git clean -fdx