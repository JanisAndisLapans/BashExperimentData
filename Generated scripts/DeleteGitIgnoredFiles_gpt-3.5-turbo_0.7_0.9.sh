# Delete all files according to .gitignore
find . -type f -print | git check-ignore --stdin | xargs rm -f