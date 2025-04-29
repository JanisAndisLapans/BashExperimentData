#!/bin/bash

# Ensure git is installed
if ! command -v git &> /dev/null; then
    apt update && apt install -y git
fi

# Use git to list ignored files and delete them
git clean -fdX