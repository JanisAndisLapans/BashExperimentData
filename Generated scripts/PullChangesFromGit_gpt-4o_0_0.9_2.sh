git remote add origin <remote-repository-url>
git fetch origin develop
git checkout develop
git merge -X ours origin/develop