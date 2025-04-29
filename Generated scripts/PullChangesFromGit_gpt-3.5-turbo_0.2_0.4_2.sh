git fetch origin develop
git checkout develop
git stash
git merge -X ours origin/develop
git stash pop