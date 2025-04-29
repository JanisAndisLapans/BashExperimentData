#!/bin/bash

for user_home in /home/*/public_html; do
    if [ -d "$user_home/wp-includes" ]; then
        version=$(grep "wp_version = " "$user_home/wp-includes/version.php" | cut -d \' -f 2)
        echo "Found: $version"
    fi
done