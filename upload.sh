#!/bin/bash

# takes 1 args
# 1 - directory/filename.tgz - created by `helm package .` command in directory

#cd "$(dirname "$0")/.." || exit

if [ -f .env ]
then
  export $(cat .env | xargs)
else
  echo ".env file not set"
  exit 0
fi

fspec="$1"
filename="${fspec##*/}"  # get filename
dirname="${fspec%/*}" # get directory/path name

cd "$dirname"

curl -u "$CHARTMUSEUM_USER":"$CHARTMUSEUM_PASS" --data-binary "@$filename" https://chartmuseum.stackendsolutions.com/api/charts