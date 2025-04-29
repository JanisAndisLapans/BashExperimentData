#!/bin/bash

# Search all home directories for WordPress installations
find /home -type d -name 'wp-content' | while read -r wp_content_dir; do
    # Get the WordPress root directory (parent of wp-content)
    wp_root=$(dirname "$wp_content_dir")
    
    # Check for version.php in the expected location
    version_file="$wp_root/wp-includes/version.php"
    
    if [[ -f "$version_file" ]]; then
        wp_version=$(grep -oP "\$wp_version = '\K[^']+" "$version_file" 2>/dev/null)
        if [[ -n "$wp_version" ]]; then
            echo "Found: $wp_version (in $wp_root)"
        fi
    fi
done

# Alternative check for wp-config.php if version.php isn't found
find /home -type f -name 'wp-config.php' | while read -r wp_config; do
    wp_root=$(dirname "$wp_config")
    version_file="$wp_root/wp-includes/version.php"
    
    if [[ -f "$version_file" ]]; then
        wp_version=$(grep -oP "\$wp_version = '\K[^']+" "$version_file" 2>/dev/null)
        if [[ -n "$wp_version" ]]; then
            echo "Found: $wp_version (in $wp_root)"
        fi
    fi
done