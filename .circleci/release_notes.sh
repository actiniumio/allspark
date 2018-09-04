#!/bin/bash

set -e # Exit with nonzero exit code if anything fails

REPO=`git config remote.origin.url`
git clone $REPO
cd allspark


npm \
  i \
  --prefix ./dependencies \
  github-release-notes

export PATH=$PATH:`pwd`/dependencies/node_modules/.bin

tag=`git describe --tags`
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

git config --global user.email "bot.actinium@gmail.com"
git config --global user.name "Actinium Bot"

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

git add CHANGELOG.md

diffs=`git diff-index --quiet HEAD; echo $?`

if [ $diffs != 0 ]
then
  echo "Changelog updated, pushing to the repository."
  git commit -m "Updated CHANGELOG for milestone $milestone_name"
  git push origin master
else
  echo "Nothing changed in this release. Skipping push."
fi
