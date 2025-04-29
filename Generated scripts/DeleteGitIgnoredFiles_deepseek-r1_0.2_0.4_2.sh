if [[ -f .gitignore ]]; then
    git init -q
    git clean -Xdf
    rm -rf .git
else
    echo "Error: No .gitignore file found" >&2
    exit 1
fi