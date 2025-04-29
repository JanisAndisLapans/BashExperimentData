git remote add origin <remote_repository_url>
git fetch origin develop
git checkout develop
git merge -s recursive -X ours origin/develop