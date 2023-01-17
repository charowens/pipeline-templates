#!/bin/bash
set -ve

pushd $(dirname $0)

pushd ../docker

# get the docker tag and EC$ Url from the settings file
tag=$(jq -r .docker.tag ../settings.json)
version=$(jq -r .docker.version ../settings.json)

# build the docker image
docker build \
    -t $tag:$version \
    --build-arg NEW_USER=$USER \
    --build-arg NEW_USER_ID=$UID \
    .

docker run -v /var/run/docker.sock:/var/run/docker.sock -it $tag:$version bash

popd

popd
