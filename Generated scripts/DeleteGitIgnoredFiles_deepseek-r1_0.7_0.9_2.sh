# Check if in a Git repo, initialize temporarily if not
if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
    git init -q
    TEMP_GIT=1
fi

# Delete ignored files
git clean -dfX

# Clean up temporary repo
if [[ -n "$TEMP_GIT" ]]; then
    rm -rf .git
fi