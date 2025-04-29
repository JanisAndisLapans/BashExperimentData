#!/bin/bash

# Find all WordPress installations and check their versions
find /home -type f -path '*/public_html/wp-includes/version.php' -print0 | while IFS= read -r -d $'\0' wp_version_file; do
    wp_dir=$(dirname "$(dirname "$wp_version_file")")
    wp_version=$(grep -oP "(?<=\\$wp_version = ')[^']+" "$wp_version_file")
    echo "Found: $wp_version in $wp_dir"
done
    echo "Found: $wp_version"