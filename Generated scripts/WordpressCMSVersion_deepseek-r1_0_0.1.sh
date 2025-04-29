find /home/*/public_html -type f -path '*/wp-includes/version.php' -print0 | while IFS= read -r -d '' file; do
    version=$(grep -m1 '^\$wp_version\s*=' "$file" | awk -F"['\"]" '{print $2}')
    [[ -n "$version" ]] && echo "Found: $version"
done