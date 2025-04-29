# Install rsync if not already installed
apt-get install -y rsync

# Create a temporary directory
temp_dir=$(mktemp -d)

# Use rsync to exclude files listed in .gitignore
rsync -a --exclude-from=.gitignore ./ "$temp_dir"

# Replace the current directory with the filtered contents
rm -rf ./*
mv "$temp_dir"/* .

# Clean up the temporary directory
rm -rf "$temp_dir"