#!/bin/bash
set -ve

major_max=1;
minor_max=1;
patch_max=0;
echo "Creating tag for branch $GIT_REPO"
if [ -z "$GIT_REPO" ]; then
    echo 'GIT_REPO not provided'
    exit 1
fi
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git init .
git remote add -t \* -f origin $GIT_REPO
git tag -d $(git tag -l)
git fetch --tags
last_tag=$(git tag -l | sort -t. -k 1,1n -k 2,2n -k 3,3n  | tail -n 1)
if [[ $last_tag ]]; then
    echo "Last tag: $last_tag"
    version=$(echo $last_tag | grep -o '[^-]*$')
    major=$(echo $version | cut -d. -f1)
    minor=$(echo $version | cut -d. -f2)
    patch=$(echo $version | cut -d. -f3)
if [ "$major_max" -lt "$major" ]; then
        let major_max=$major
    fi
if [ "$minor_max" -lt "$minor" ]; then
        let minor_max=$minor
    fi
if [ "$patch_max" -lt "$patch" ]; then
        let patch_max=$patch
    fi
    let patch_max=($patch_max+1)
fi
if [ "$major_max" -ne "${MAJOR_VERSION}" ] || [ "$minor_max" -ne "${MINOR_VERSION}" ]; then
    major_max="${MAJOR_VERSION}"
    minor_max="${MINOR_VERSION}"
fi
echo 'Switching to new version:' $major_max'.'$minor_max'.'$patch_max
source_version=$major_max.$minor_max.$patch_max
echo $source_version > version
git config --global user.email "codepipeline@yourorg.com"
git tag -a $source_version -m "Version $source_version" origin/master

echo 'Push tag to remote'
$(git push origin $source_version)






