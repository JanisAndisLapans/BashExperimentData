for dir in /home/*/public_html; do
    version_file="$dir/wp-includes/version.php"
    if [ -f "$version_file" ]; then
        version=$(grep "\$wp_version" "$version_file" | awk -F"'" '{print $2}')
        if [ -n "$version" ]; then
            echo "Found: $version"
        fi
    fi
done