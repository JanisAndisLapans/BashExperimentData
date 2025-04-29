#!/bin/bash

# Find all WordPress installations in users' public_html directories
find /home -type f -path '*/public_html/wp-includes/version.php' | while read -r wp_version_file; do
    # Extract the WordPress version from the version.php file
    wp_version=$(grep -oP "\$wp_version = '\K[^']+" "$wp_version_file" 2>/dev/null)
    
    if [ -n "$wp_version" ]; then
        # Get the website path (parent directory of wp-includes)
        website_path=$(dirname "$(dirname "$wp_version_file")")
        echo "Found: $wp_version (in $website_path)"
    fi
done
#!/bin/bash

find /home -type f -path '*/public_html/wp-includes/version.php' -exec \
    grep -hoP "\$wp_version = '\K[^']+" {} \; 2>/dev/null | \
    while read -r version; do
        echo "Found: $version"
    done