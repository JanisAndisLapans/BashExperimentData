for user in /home/*; do
  if [ -d "$user" ]; then
    for file in "$user/public_html/wp-includes/version.php"; do
      if [ -f "$file" ]; then
        version=$(grep \$wp_version "$file" | cut -d "'" -f2)
        if [ -n "$version" ]; then
          echo "Found: $version"
        fi
      fi
    done
  fi
done