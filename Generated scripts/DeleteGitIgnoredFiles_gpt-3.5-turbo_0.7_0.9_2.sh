# Delete all files according to .gitignore, ignoring errors
find . -type f -print | git check-ignore --stdin 2>/dev/null | xargs rm -f