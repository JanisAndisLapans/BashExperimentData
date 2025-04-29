#!/bin/bash

# Find all WordPress installations under public_html in user home directories
find /home -type f -path '*/public_html/wp-includes/version.php' | while read -r version_file; do
    # Extract the WordPress version from the version.php file
    wp_version=$(grep -oP "\$wp_version = '\K[^']+" "$version_file" 2>/dev/null)
    
    if [[ -n "$wp_version" ]]; then
        # Get the website path (two directories up from wp-includes)
        website_path=$(dirname "$(dirname "$version_file")")
        echo "Found: $wp_version (in $website_path)"
    fi
done