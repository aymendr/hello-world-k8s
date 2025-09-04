# Récupération des commits depuis le dernier tag
git checkout master
LAST_TAG=$(git describe --tags --abbrev=0 || echo "")
echo Dernier tag "$LAST_TAG"
if [ -z "$LAST_TAG" ]; then COMMITS=$(git log --pretty=format:"- %s"); else COMMITS=$(git log $LAST_TAG..HEAD --pretty=format:"- %s"); fi
echo "## $(date +'%Y-%m-%d') Deployment" >> tmp_changelog.md
echo "$COMMITS" >> tmp_changelog.md
echo "" >> tmp_changelog.md
cat CHANGELOG.md >> tmp_changelog.md
mv tmp_changelog.md CHANGELOG.md
# Commit + push
git add CHANGELOG.md
git commit -m "chore update changelog"