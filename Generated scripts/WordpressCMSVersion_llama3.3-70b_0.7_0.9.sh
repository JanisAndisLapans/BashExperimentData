for user in /home/*; do
  if [ -d "$user" ]; then
    for file in "$user/public_html/wp-includes/version.php"; do
      if [ -f "$file" ]; then
        version=$(grep '$wp_version' "$file" | cut -d "'" -f2)
        echo "Found: $version"
      fi
    done
  fi
done