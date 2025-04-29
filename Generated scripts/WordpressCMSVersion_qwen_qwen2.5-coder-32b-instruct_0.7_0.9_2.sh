#!/bin/bash

# Find all WordPress installations in user home directories under public_html
find /home -type d -name "wp-includes" -print0 | while IFS= read -r -d '' wp; do
    # Navigate to the wp-includes directory
    cd "$wp" || continue
    # Check if the version.php file exists
    if [ -f version.php ]; then
        # Extract the version number from version.php
        version=$(grep -oP "wp_version\s*=\s*'\K[0-9.]*" version.php)
        # Print the found version
        echo "Found: $version"
    fi
done