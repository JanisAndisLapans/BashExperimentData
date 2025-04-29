# Stash uncommitted changes
git stash

# Ensure we are on the desired branch
git checkout develop

# Pull changes from remote "develop" branch, favoring local files in case of conflict
git pull -s recursive -X ours origin develop

# Apply stashed changes
git stash pop