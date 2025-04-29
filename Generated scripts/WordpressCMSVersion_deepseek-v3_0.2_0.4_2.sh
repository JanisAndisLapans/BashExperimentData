#!/bin/bash

# Process each WordPress installation found
while IFS= read -r -d $'\0' wp_version_file; do
    wp_version=$(awk -F\' '/^\$wp_version = / {print $2}' "$wp_version_file")
    echo "Found: $wp_version"
done < <(find /home -type f -path '*/public_html/wp-includes/version.php' -print0)