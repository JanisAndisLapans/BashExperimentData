git checkout develop
git fetch origin develop
git stash
git merge origin/develop
git stash pop --index
git merge -X ours origin/develop