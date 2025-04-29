#!/bin/bash
fdupes -Hr /usr/files | awk -v RS= '{gsub(/\n/, " "); print}'