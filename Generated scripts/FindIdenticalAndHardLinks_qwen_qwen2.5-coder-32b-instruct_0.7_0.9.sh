#!/bin/bash
cd /usr/files || exit
find . -type f -print0 | xargs -0 md5sum | sort | uniq -w32 --all-repeated=separate | awk '{print $2}' | paste -sd' ' - | sed '/^$/d'