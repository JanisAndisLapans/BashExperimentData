#!/bin/bash

# Find all WordPress installations in users' home directories under public_html
find /home -type d -name "public_html" -exec find {} -type f -name "wp-includes/version.php" \; | while read -r version_file; do
    # Extract the version number from version.php
    version=$(grep -oP "wp_version\s*=\s*'\K[0-9.]+(?=')" "$version_file")
    # Print the version in the required format
    echo "Found: $version"
done