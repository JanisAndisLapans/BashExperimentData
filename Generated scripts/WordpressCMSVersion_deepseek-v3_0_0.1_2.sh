#!/bin/bash

# Search all home directories for WordPress installations
find /home -type d -name 'public_html' -o -type d -name 'www' | while read -r webroot; do
    # Check if this directory contains WordPress
    if [ -f "$webroot/wp-includes/version.php" ]; then
        version=$(grep -oP "\$wp_version = '\K[^']+" "$webroot/wp-includes/version.php" 2>/dev/null)
        if [ -n "$version" ]; then
            echo "Found: $version (in $webroot)"
        fi
    fi
    
    # Also check for WordPress in subdirectories
    find "$webroot" -maxdepth 3 -type f -name 'version.php' | grep '/wp-includes/version.php$' | while read -r version_file; do
        version=$(grep -oP "\$wp_version = '\K[^']+" "$version_file" 2>/dev/null)
        if [ -n "$version" ]; then
            wp_path=$(dirname "$(dirname "$version_file")")
            echo "Found: $version (in $wp_path)"
        fi
    done
done