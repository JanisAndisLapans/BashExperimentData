if [ -f .gitignore ]; then
    git init -q
    git clean -dfX
    rm -rf .git
else
    echo "Error: No .gitignore file found in current directory" >&2
    exit 1
fi