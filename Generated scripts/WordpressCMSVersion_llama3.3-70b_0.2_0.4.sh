for user in /home/*; do
  if [ -d "$user/public_html" ]; then
    version=$(grep -oP 'Version: \K[0-9\.]+' "$user/public_html/wp-includes/version.php" 2>/dev/null)
    if [ -n "$version" ]; then
      echo "Found: $version"
    fi
  fi
done