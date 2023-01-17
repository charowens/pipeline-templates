#!/bin/bash
set -ve

if [ -z "$RELEASE_BUCKET" ]; then
    echo 'RELEASE_BUCKET not provided'
    exit 1
fi
version=$(jq .$ENVIRONMENT.version settings.json)
version=$(echo $version | sed 's/"//g')
s3path=s3://$RELEASE_BUCKET/$version/tar.gz
echo "SET s3path in fetch_tar.sh default is tar.gz for Fetching version $version from $s3path"
aws s3 cp $s3path .

