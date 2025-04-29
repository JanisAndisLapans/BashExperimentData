git stash
git fetch origin develop
git checkout develop
git merge -s recursive -X ours origin/develop
git stash pop