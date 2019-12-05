#!/bin/bash
set -ve

pushd $(dirname $0)

pushd ../docker

# get the deploy role and region from the settings file
deployRole=$(jq -r ".deployRoleARN | values" ../settings.json)
deployRegion=$(jq -r .region ../settings.json)

# assume the deploy role
if [ -n "$deployRole" ]; then
	assumedRoleDetails=$(aws sts assume-role --role-arn $deployRole --role-session-name ui-deploy)
	export AWS_ACCESS_KEY_ID=$(echo $assumedRoleDetails | jq -r .Credentials.AccessKeyId)
	export AWS_SECRET_ACCESS_KEY=$(echo $assumedRoleDetails | jq -r .Credentials.SecretAccessKey)
	export AWS_SESSION_TOKEN=$(echo $assumedRoleDetails | jq -r .Credentials.SessionToken)
fi
export AWS_DEFAULT_REGION=$deployRegion

# get the docker tag and EC$ Url from the settings file
tag=$(jq -r .docker.tag ../settings.json)
version=$(jq -r .docker.version ../settings.json)
accountId=$(jq -r .accountId ../settings.json)
region=$(jq -r .region ../settings.json)
ecrUrl=$accountId.dkr.ecr.$region.amazonaws.com

# build the docker image
docker build \
    -t $tag:$version \
    --build-arg NEW_USER=$USER \
    --build-arg NEW_USER_ID=$UID \
    .
# tag the image
docker tag $tag:$version $ecrUrl/$tag:$version
docker tag $tag:$version $ecrUrl/$tag:latest
# push the tagged image
$(aws ecr get-login --no-include-email)
docker push $ecrUrl/$tag:$version

popd

popd
