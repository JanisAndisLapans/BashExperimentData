find /home/*/public_html -path '*/wp-includes/version.php' -exec \
  grep -h -oP "\$wp_version\s*=\s*\047\K[^\047]+" {} \; | \
  awk '{print "Found: " $0}'