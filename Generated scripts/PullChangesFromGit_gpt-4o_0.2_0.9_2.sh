git remote add origin <remote-repository-url>
git checkout develop
git fetch origin develop
git merge -X ours origin/develop