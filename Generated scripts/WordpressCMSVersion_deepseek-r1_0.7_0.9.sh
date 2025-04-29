#!/bin/bash
find /home -path "*/public_html/wp-includes/version.php" -exec grep -hPo '^\$wp_version\s*=\s*'\''\K[^'\'']+' {} + | while read -r version; do echo "Found: $version"; done