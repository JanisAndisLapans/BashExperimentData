if [ -d .git ]; then
  git clean -fdX
else
  echo "Initializing a temporary git repository to use .gitignore"
  git init
  git add .
  git commit -m "Initial commit"
  git clean -fdX
  rm -rf .git
fi