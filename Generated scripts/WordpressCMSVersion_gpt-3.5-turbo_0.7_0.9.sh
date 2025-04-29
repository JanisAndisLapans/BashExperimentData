#!/bin/bash

# Find all WordPress installations under users' home directories
find /home/*/public_html -name wp-includes -type d | while read -r wp_dir; do
    version=$(grep 'wp_version =' "$wp_dir/version.php" 2>/dev/null | cut -d "'" -f 2)
    if [ -n "$version" ]; then
        echo "Found: $version"
    fi
done