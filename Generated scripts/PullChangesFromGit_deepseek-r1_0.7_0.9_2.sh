git fetch origin develop
git checkout develop
git stash
git merge --ff-only origin/develop
git checkout stash -- .
git stash drop