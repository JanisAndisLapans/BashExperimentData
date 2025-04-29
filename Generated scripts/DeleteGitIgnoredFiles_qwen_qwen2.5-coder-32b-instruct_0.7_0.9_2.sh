#!/bin/bash

# Ensure git is installed
if ! command -v git &> /dev/null; then
    apt install -y git
fi

# Restore files that were deleted by git clean
git checkout -- .gitignore data.log program.js
#!/bin/bash

# Ensure extundelete is installed
if ! command -v extundelete &> /dev/null; then
    apt install -y extundelete
fi

# Replace /dev/sdXN with the actual partition where the files were deleted
extundelete /dev/sdXN --restore-all