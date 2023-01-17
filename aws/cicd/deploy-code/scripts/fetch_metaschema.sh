#!/bin/bash
set -ve

echo "Fetching latests metaschema and configurations from $CORE_REPO"
if [ -z "$CORE_REPO" ]; then
    echo 'CORE_REPO not provided'
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

##EXAMPLE 
# mkdir build && mkdir build/definition-schemas && mkdir build/config-flags 
# cp -R core_repo/definition-schemas* build
# cp -R core_repo/config-flags* build/config-flags/
rm -rf core_repo