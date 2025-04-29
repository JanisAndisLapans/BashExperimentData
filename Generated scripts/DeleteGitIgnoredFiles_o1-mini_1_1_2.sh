#!/bin/bash

# Check if .gitignore exists
if [ ! -f .gitignore ]; then
    echo ".gitignore file not found in the current directory."
    exit 1
fi

# Function to convert .gitignore patterns to find expressions
convert_pattern() {
    local pattern="$1"
    # Escape special characters for find
    pattern=$(printf '%q' "$pattern")
    
    # Handle directory patterns
    if [[ "$pattern" == */ ]]; then
        echo "-type d -name \"${pattern%/}\""
    else
        echo "-type f -name \"$pattern\""
    fi
}

# Read .gitignore patterns, ignoring comments and empty lines
mapfile -t patterns < <(grep -vE '^\s*(#|$)' .gitignore)

# Initialize find commands
find_cmd="find ."

# Build find expression
find_expr=""
for pattern in "${patterns[@]}"; do
    expr=$(convert_pattern "$pattern")
    if [ -n "$expr" ]; then
        find_expr+=" -o $expr"
    fi
done

# Remove the first '-o'
find_expr=${find_expr# -o }

# Combine and execute the find command
if [ -n "$find_expr" ]; then
    eval "$find_cmd \\( $find_expr \\) -exec rm -rf {} +"
else
    echo "No patterns found to delete."
fi