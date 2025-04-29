# Initialize a Git repository if it doesn't exist
if [ ! -d .git ]; then
    git init
fi

# Add the .gitignore file to the repository
git add .gitignore

# Use git clean to delete all files ignored by .gitignore
git clean -Xdf