#!/bin/bash

# Find all Wordpress installations under users' public_html directories
wp_sites=$(find /home/*/public_html/ -name wp-includes -type d 2>/dev/null)

# Loop through each Wordpress installation and extract the version
for site in $wp_sites; do
    version=$(grep "wp_version = " "$site/version.php" 2>/dev/null | cut -d"'" -f2)
    if [ -n "$version" ]; then
        echo "Found: $version"
    fi
done