#!/bin/bash
set -ve

echo "Fetching latests metaschema and configurations from $CORE_REPO"
if [ -z "$CORE_REPO" ]; then
    echo 'CORE_REPO not provided'
    exit 1
fi
if [ -z "$INSTANCE_PREFIX" ]; then
    echo 'INSTANCE_PREFIX not provided'
    exit 1
fi
if [ -z "$ENVIRONMENT" ]; then
    echo '$ENVIRONMENT not provided'
    exit 1
fi
git config --global credential.helper '!aws codecommit credential-helper $@'
git config --global credential.UseHttpPath true
git config --global user.email "codepipeline@coca-cola.com"
git clone $CORE_REPO core_repo

echo "Grab your metaschemas and configurations"
rm -rf core_repo