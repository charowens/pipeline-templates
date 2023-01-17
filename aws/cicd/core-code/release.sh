#!/bin/bash
set -ve

version=$1

pushd $(dirname $0)

s3path=s3://$RELEASE_BUCKET/$version
latestpath=s3://$RELEASE_BUCKET/latest

if [ -z "$GIT_REPO" ]; then
    echo 'GIT_REPO not provided'
    exit 1
fi

echo "=== show source dirs ==="
ls -a

if [ -z "$(aws s3 ls $s3path)" ]; then
  echo "Version does not exist"
  aws s3 cp core.tar.gz $s3path/core.tar.gz
  echo "Copying to latest"
  aws s3 cp core.tar.gz $latestpath/core.tar.gz
  echo "Copying to latest"
  git config --global credential.helper '!aws codecommit credential-helper $@'
  git config --global credential.UseHttpPath true
  git config --global user.email "codepipline@yourorg.com"
  git clone $GIT_REPO repo

  echo $version > repo/latest
  cd repo
  git add *
  git commit -m "updating latest file to version $version"
  git push origin master
  
else
  echo "Version already exists"
  exit 1
fi

popd