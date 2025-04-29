for user in /home/*; do
  if [ -d "$user" ] && [ -d "$user/public_html" ]; then
    if [ -f "$user/public_html/wp-includes/version.php" ]; then
      version=$(grep -oP 'Version: \K[0-9\.]+' "$user/public_html/wp-includes/version.php" 2>/dev/null)
      if [ -n "$version" ]; then
        echo "Found: $version"
      else
        echo "Found: Unknown"
      fi
    fi
  fi
done