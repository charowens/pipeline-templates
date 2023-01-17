#!/bin/bash

set -ve

pushd ../docker
cp -r ~/.aws .
cp ~/data/bin/setup_aws_profile.sh . #To setup aws profile
git clone https://git-codecommit.us-west-2.amazonaws.com/v1/repos/XXXX #To Setup up http gateway add your repo name
