#!/bin/bash

set -xe # Exit with nonzero exit code if anything fails

npm \
  i \
  --prefix ./dependencies \
  github-release-notes

export PATH=$PATH:`pwd`/node_modules/.bin

tag=`git describe --tags`
branch="$CIRCLE_BRANCH"
milestone_name="$tag"



milestone_id=`curl https://api.github.com/repos/actiniumio/allspark/milestones | jq ".[] | select(.title | contains(\"$milestone_name\")) | .number"`


if [ -z "$milestone_id" ]
then
  echo "Could not find the milestone '$milestone_name'."
  exit 1
else
  curl \
    "https://api.github.com/repos/actiniumio/allspark/milestones/$milestone_id" \
    --data "{\"title\": \"$milestone_name\", \"state\": \"closed\"}" \
    -X PATCH \
    -H "Authorization: token $GREN_GITHUB_TOKEN"  \
    -H 'Content-Type: application/json'
  echo "Milestone $milestone_name closed."
fi

git checkout $CIRCLE_BRANCH

./dependencies/node_modules/.bin/gren \
  changelog \
  --generate \
  -m \
  --override \
  --tags=$tag \
  -L duplicate,invalid,need_infos,question,stale,wontfix \
  -I duplicate,invalid,need_infos,question,stale,wontfix \
  -D milestones \
  -p v \
  -g label \
  -M '{{tag_name}}'

diffs=`git diff-index --quiet HEAD; echo $?`

if [ $diffs != 0 ]
then
  echo "Changelog updated, pushing to the repository."
  git add CHANGELOG.md
  git commit -m "Updated CHANGELOG for milestone $milestone_name"
  git push origin $CIRCLE_BRANCH
else
  echo "Nothing changed in this release. Skipping push."
fi
